from dataclasses import dataclass
from pathlib import Path
import pandas as pd

ARTICLE_DIR = Path(__file__).resolve().parents[1]
DATA_PATH = ARTICLE_DIR / "data" / "observation_source_inventory.csv"
OUTPUT_DIR = ARTICLE_DIR / "outputs"
OUTPUT_DIR.mkdir(exist_ok=True)

@dataclass
class Weights:
    quality: float = 0.20
    coverage: float = 0.15
    freshness: float = 0.15
    interoperability: float = 0.15
    provenance: float = 0.15
    governance: float = 0.10
    uncertainty: float = 0.10

def compute_decision_usefulness(row: pd.Series, weights: Weights = Weights()) -> float:
    """Estimate decision usefulness from evidence-quality dimensions."""
    return (
        weights.quality * row["quality_score"]
        + weights.coverage * row["coverage_score"]
        + weights.freshness * row["freshness_score"]
        + weights.interoperability * row["interoperability_score"]
        + weights.provenance * row["provenance_score"]
        + weights.governance * row["governance_score"]
        - weights.uncertainty * row["uncertainty_score"]
    )

def classify_review_priority(row: pd.Series) -> str:
    if row["uncertainty_score"] > 0.35:
        return "high_uncertainty_review"
    if row["decision_usefulness"] < 0.65:
        return "evidence_strength_review"
    if row["provenance_score"] < 0.70:
        return "provenance_review"
    if row["interoperability_score"] < 0.70:
        return "interoperability_review"
    return "routine_monitoring"

def main() -> None:
    df = pd.read_csv(DATA_PATH)

    df["decision_usefulness"] = df.apply(compute_decision_usefulness, axis=1).round(3)
    df["review_priority"] = df.apply(classify_review_priority, axis=1)

    ranked = df.sort_values("decision_usefulness", ascending=False)
    output_path = OUTPUT_DIR / "environmental_intelligence_scores.csv"
    ranked.to_csv(output_path, index=False)

    print("Environmental intelligence scores")
    print(ranked[[
        "source_id",
        "domain",
        "source_type",
        "decision_usefulness",
        "review_priority"
    ]].to_string(index=False))
    print(f"\nWrote: {output_path}")

if __name__ == "__main__":
    main()
