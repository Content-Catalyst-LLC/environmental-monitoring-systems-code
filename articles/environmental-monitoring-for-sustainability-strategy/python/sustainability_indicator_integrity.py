from pathlib import Path
import pandas as pd

ARTICLE_DIR = Path(__file__).resolve().parents[1]
DATA_PATH = ARTICLE_DIR / "data" / "indicator_registry.csv"
OUTPUT_DIR = ARTICLE_DIR / "outputs"
OUTPUT_DIR.mkdir(exist_ok=True)

def as_bool(value) -> bool:
    if isinstance(value, bool):
        return value
    return str(value).strip().lower() in {"true", "1", "yes", "y"}

def indicator_integrity(row: pd.Series) -> float:
    """Evaluate indicator integrity from metadata, validation, lineage, uncertainty, and conceptual relevance."""
    return (
        0.20 * row["metadata_score"]
        + 0.20 * row["validation_score"]
        + 0.20 * row["lineage_score"]
        + 0.20 * row["uncertainty_score"]
        + 0.20 * row["conceptual_relevance_score"]
    )

def target_gap(row: pd.Series) -> float:
    denominator = row["baseline_value"] - row["target_value"]
    if denominator == 0:
        return 0.0
    return (row["current_value"] - row["target_value"]) / denominator

def threshold_distance(row: pd.Series) -> float:
    if row["threshold_value"] == 0:
        return 0.0
    return (row["threshold_value"] - row["current_value"]) / row["threshold_value"]

def classify_review_priority(row: pd.Series) -> str:
    material = as_bool(row["material_finding"])
    corrective = as_bool(row["corrective_action_taken"])
    public = as_bool(row["publicly_reviewable"])

    if row["threshold_distance"] <= 0.10:
        return "threshold_proximity_review"
    if row["indicator_integrity"] < 0.70:
        return "indicator_integrity_review"
    if material and not corrective:
        return "feedback_failure_review"
    if material and not public:
        return "accountability_review"
    if row["indicator_type"] == "response" and material:
        return "response_outcome_review"
    return "routine_monitoring"

def main() -> None:
    df = pd.read_csv(DATA_PATH)

    df["indicator_integrity"] = df.apply(indicator_integrity, axis=1).round(3)
    df["target_gap"] = df.apply(target_gap, axis=1).round(3)
    df["threshold_distance"] = df.apply(threshold_distance, axis=1).round(3)
    df["review_priority"] = df.apply(classify_review_priority, axis=1)

    ranked = df.sort_values(["review_priority", "threshold_distance", "indicator_integrity"])
    output_path = OUTPUT_DIR / "sustainability_indicator_integrity_scores.csv"
    ranked.to_csv(output_path, index=False)

    print("Sustainability indicator integrity and feedback review")
    print(ranked[[
        "indicator_id",
        "domain",
        "indicator_type",
        "indicator_integrity",
        "target_gap",
        "threshold_distance",
        "material_finding",
        "corrective_action_taken",
        "publicly_reviewable",
        "review_priority"
    ]].to_string(index=False))
    print(f"\nWrote: {output_path}")

if __name__ == "__main__":
    main()
