from pathlib import Path
import pandas as pd

ARTICLE_DIR = Path(__file__).resolve().parents[1]
DATA_PATH = ARTICLE_DIR / "data" / "land_monitoring_readiness_scores.csv"
OUTPUT_DIR = ARTICLE_DIR / "outputs"
OUTPUT_DIR.mkdir(exist_ok=True)

def as_bool(value) -> bool:
    if isinstance(value, bool):
        return value
    return str(value).strip().lower() in {"true", "1", "yes", "y"}

def change_confidence(row: pd.Series) -> float:
    detected = float(row["detected_change_samples"])
    if detected <= 0:
        return 0.0
    return max(0.0, min(1.0, float(row["validated_change_samples"]) / detected))

def land_evidence_quality(row: pd.Series) -> float:
    return (
        0.16 * row["classification_accuracy"]
        + 0.14 * row["temporal_consistency"]
        + 0.14 * row["change_confidence"]
        + 0.14 * row["reference_data_strength"]
        + 0.12 * row["condition_sensitivity"]
        + 0.10 * row["fragmentation_visibility"]
        + 0.10 * row["uncertainty_communication"]
        + 0.10 * row["reporting_readiness"]
    )

def classify_review_priority(row: pd.Series) -> str:
    if as_bool(row["high_stakes_use"]) and row["classification_accuracy"] < 0.80:
        return "high_stakes_accuracy_review"
    if row["temporal_consistency"] < 0.75:
        return "temporal_consistency_review"
    if row["change_confidence"] < 0.75:
        return "change_validation_review"
    if row["reference_data_strength"] < 0.75:
        return "reference_data_review"
    if row["condition_sensitivity"] < 0.70:
        return "condition_monitoring_review"
    if row["fragmentation_visibility"] < 0.70:
        return "fragmentation_visibility_review"
    if row["uncertainty_communication"] < 0.75:
        return "uncertainty_communication_review"
    if row["reporting_readiness"] < 0.75:
        return "reporting_readiness_review"
    if row["land_evidence_quality"] < 0.75:
        return "land_evidence_quality_review"
    return "routine_monitoring"

def main() -> None:
    df = pd.read_csv(DATA_PATH)
    df["change_confidence"] = df.apply(change_confidence, axis=1).round(3)
    df["land_evidence_quality"] = df.apply(land_evidence_quality, axis=1).round(3)
    df["review_priority"] = df.apply(classify_review_priority, axis=1)

    ranked = df.sort_values(["review_priority", "land_evidence_quality"])
    output_path = OUTPUT_DIR / "land_monitoring_readiness_scores.csv"
    ranked.to_csv(output_path, index=False)

    print("Land-use monitoring readiness and landscape-evidence review")
    print(ranked[[
        "product_id",
        "geography",
        "monitoring_purpose",
        "classification_accuracy",
        "temporal_consistency",
        "change_confidence",
        "reference_data_strength",
        "condition_sensitivity",
        "fragmentation_visibility",
        "uncertainty_communication",
        "reporting_readiness",
        "land_evidence_quality",
        "review_priority"
    ]].to_string(index=False))
    print(f"\nWrote: {output_path}")

if __name__ == "__main__":
    main()
