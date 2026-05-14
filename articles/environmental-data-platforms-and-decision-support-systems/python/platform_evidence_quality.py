from pathlib import Path
import pandas as pd

ARTICLE_DIR = Path(__file__).resolve().parents[1]
DATA_PATH = ARTICLE_DIR / "data" / "platform_assets.csv"
OUTPUT_DIR = ARTICLE_DIR / "outputs"
OUTPUT_DIR.mkdir(exist_ok=True)

def as_bool(value) -> bool:
    if isinstance(value, bool):
        return value
    return str(value).strip().lower() in {"true", "1", "yes", "y"}

def platform_evidence_quality(row: pd.Series) -> float:
    """Evaluate platform assets as governed evidence objects."""
    return (
        0.22 * row["metadata_complete"]
        + 0.20 * row["semantic_compatibility"]
        + 0.22 * row["lineage_complete"]
        + 0.18 * row["uncertainty_visible"]
        + 0.18 * row["decision_fit"]
    )

def classify_review_priority(row: pd.Series) -> str:
    high_stakes = as_bool(row["is_high_stakes"])
    if high_stakes and row["lineage_complete"] < 0.85:
        return "high_stakes_lineage_review"
    if row["metadata_complete"] < 0.75:
        return "metadata_completeness_review"
    if row["semantic_compatibility"] < 0.70:
        return "semantic_integration_review"
    if row["uncertainty_visible"] < 0.70:
        return "uncertainty_visibility_review"
    if row["decision_fit"] < 0.70:
        return "decision_support_fit_review"
    if row["platform_evidence_quality"] < 0.75:
        return "platform_quality_review"
    return "routine_monitoring"

def main() -> None:
    df = pd.read_csv(DATA_PATH)
    df["platform_evidence_quality"] = df.apply(platform_evidence_quality, axis=1).round(3)
    df["review_priority"] = df.apply(classify_review_priority, axis=1)

    ranked = df.sort_values(["review_priority", "platform_evidence_quality"])
    output_path = OUTPUT_DIR / "platform_evidence_quality_scores.csv"
    ranked.to_csv(output_path, index=False)

    print("Platform evidence quality and decision-support readiness")
    print(ranked[[
        "asset_id",
        "domain",
        "asset_type",
        "platform_evidence_quality",
        "metadata_complete",
        "semantic_compatibility",
        "lineage_complete",
        "uncertainty_visible",
        "decision_fit",
        "review_priority"
    ]].to_string(index=False))
    print(f"\nWrote: {output_path}")

if __name__ == "__main__":
    main()
