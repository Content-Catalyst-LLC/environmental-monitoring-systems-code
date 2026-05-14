from dataclasses import dataclass
from pathlib import Path
import pandas as pd

ARTICLE_DIR = Path(__file__).resolve().parents[1]
DATA_PATH = ARTICLE_DIR / "data" / "resilience_units.csv"
OUTPUT_DIR = ARTICLE_DIR / "outputs"
OUTPUT_DIR.mkdir(exist_ok=True)

@dataclass
class Weights:
    capacity: float = 0.20
    redundancy: float = 0.15
    learning: float = 0.15
    governance: float = 0.15
    ecological_condition: float = 0.15
    recovery: float = 0.10
    vulnerability: float = 0.10

def compute_risk_score(row: pd.Series) -> float:
    """Simplified hazard-exposure-vulnerability-capacity risk score."""
    return (
        row["hazard_score"]
        * row["exposure_score"]
        * row["vulnerability_score"]
        * (1 - row["capacity_score"])
    )

def compute_resilience_score(row: pd.Series, weights: Weights = Weights()) -> float:
    """Composite resilience score kept transparent through disaggregated source columns."""
    return (
        weights.capacity * row["capacity_score"]
        + weights.redundancy * row["redundancy_score"]
        + weights.learning * row["learning_score"]
        + weights.governance * row["governance_score"]
        + weights.ecological_condition * row["ecological_condition_score"]
        + weights.recovery * row["recovery_ratio"]
        - weights.vulnerability * row["vulnerability_score"]
    )

def classify_review_priority(row: pd.Series) -> str:
    if row["threshold_proximity"] >= 0.90:
        return "threshold_escalation_review"
    if row["risk_score"] >= 0.20 and row["resilience_score"] < 0.55:
        return "high_risk_low_resilience_review"
    if row["recovery_ratio"] < 0.60:
        return "recovery_delay_review"
    if row["capacity_score"] < 0.50:
        return "capacity_gap_review"
    return "routine_monitoring"

def main() -> None:
    df = pd.read_csv(DATA_PATH)

    df["risk_score"] = df.apply(compute_risk_score, axis=1).round(3)
    df["resilience_score"] = df.apply(compute_resilience_score, axis=1).round(3)
    df["review_priority"] = df.apply(classify_review_priority, axis=1)

    ranked = df.sort_values(["review_priority", "risk_score"], ascending=[True, False])
    output_path = OUTPUT_DIR / "risk_resilience_scores.csv"
    ranked.to_csv(output_path, index=False)

    print("Risk and resilience monitoring scores")
    print(ranked[[
        "unit_id",
        "domain",
        "risk_score",
        "resilience_score",
        "threshold_proximity",
        "recovery_ratio",
        "review_priority"
    ]].to_string(index=False))
    print(f"\nWrote: {output_path}")

if __name__ == "__main__":
    main()
