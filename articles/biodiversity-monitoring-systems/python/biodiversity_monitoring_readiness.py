from pathlib import Path
import pandas as pd

ARTICLE_DIR = Path(__file__).resolve().parents[1]
DATA_PATH = ARTICLE_DIR / "data" / "biodiversity_monitoring_readiness_scores.csv"
OUTPUT_DIR = ARTICLE_DIR / "outputs"
OUTPUT_DIR.mkdir(exist_ok=True)

def as_bool(value) -> bool:
    if isinstance(value, bool):
        return value
    return str(value).strip().lower() in {"true", "1", "yes", "y"}

def biodiversity_evidence_quality(row: pd.Series) -> float:
    return (
        0.12 * row["taxonomic_coverage"]
        + 0.12 * row["spatial_representativeness"]
        + 0.10 * row["method_diversity"]
        + 0.12 * row["detectability_adjustment"]
        + 0.12 * row["observation_quality"]
        + 0.12 * row["indicator_readiness"]
        + 0.10 * row["habitat_context_linkage"]
        + 0.09 * row["uncertainty_communication"]
        + 0.11 * row["governance_readiness"]
    )

def classify_review_priority(row: pd.Series) -> str:
    if as_bool(row["high_stakes_use"]) and row["detectability_adjustment"] < 0.70:
        return "high_stakes_detectability_review"
    if row["taxonomic_coverage"] < 0.65:
        return "taxonomic_coverage_review"
    if row["spatial_representativeness"] < 0.65:
        return "spatial_representativeness_review"
    if row["method_diversity"] < 0.65:
        return "method_diversity_review"
    if row["detectability_adjustment"] < 0.70:
        return "detectability_review"
    if row["indicator_readiness"] < 0.70:
        return "indicator_readiness_review"
    if row["habitat_context_linkage"] < 0.70:
        return "habitat_context_review"
    if row["uncertainty_communication"] < 0.75:
        return "uncertainty_communication_review"
    if row["governance_readiness"] < 0.75:
        return "governance_readiness_review"
    if row["biodiversity_evidence_quality"] < 0.75:
        return "biodiversity_evidence_quality_review"
    return "routine_monitoring"

def main() -> None:
    df = pd.read_csv(DATA_PATH)
    df["biodiversity_evidence_quality"] = df.apply(biodiversity_evidence_quality, axis=1).round(3)
    df["review_priority"] = df.apply(classify_review_priority, axis=1)

    ranked = df.sort_values(["review_priority", "biodiversity_evidence_quality"])
    output_path = OUTPUT_DIR / "biodiversity_monitoring_readiness_scores.csv"
    ranked.to_csv(output_path, index=False)

    print("Biodiversity monitoring readiness and evidence-quality review")
    print(ranked[[
        "program_id",
        "ecosystem_context",
        "geography",
        "taxonomic_coverage",
        "spatial_representativeness",
        "method_diversity",
        "detectability_adjustment",
        "observation_quality",
        "indicator_readiness",
        "habitat_context_linkage",
        "uncertainty_communication",
        "governance_readiness",
        "biodiversity_evidence_quality",
        "review_priority"
    ]].to_string(index=False))
    print(f"\nWrote: {output_path}")

if __name__ == "__main__":
    main()
