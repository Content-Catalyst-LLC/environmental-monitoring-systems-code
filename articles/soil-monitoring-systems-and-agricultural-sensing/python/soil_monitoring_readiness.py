from pathlib import Path
import pandas as pd

ARTICLE_DIR = Path(__file__).resolve().parents[1]
DATA_PATH = ARTICLE_DIR / "data" / "soil_monitoring_readiness_scores.csv"
OUTPUT_DIR = ARTICLE_DIR / "outputs"
OUTPUT_DIR.mkdir(exist_ok=True)

def as_bool(value) -> bool:
    if isinstance(value, bool):
        return value
    return str(value).strip().lower() in {"true", "1", "yes", "y"}

def soil_evidence_quality(row: pd.Series) -> float:
    return (
        0.14 * row["spatial_representativeness"]
        + 0.14 * row["depth_representation"]
        + 0.14 * row["calibration_quality"]
        + 0.12 * row["telemetry_completeness"]
        + 0.12 * row["laboratory_support"]
        + 0.10 * row["remote_product_agreement"]
        + 0.10 * row["uncertainty_communication"]
        + 0.14 * row["decision_readiness"]
    )

def classify_review_priority(row: pd.Series) -> str:
    if as_bool(row["high_stakes_use"]) and row["calibration_quality"] < 0.75:
        return "high_stakes_calibration_review"
    if row["spatial_representativeness"] < 0.70:
        return "spatial_representativeness_review"
    if row["depth_representation"] < 0.70:
        return "depth_representation_review"
    if row["calibration_quality"] < 0.75:
        return "calibration_review"
    if row["telemetry_completeness"] < 0.80:
        return "telemetry_completeness_review"
    if row["laboratory_support"] < 0.70:
        return "laboratory_support_review"
    if row["remote_product_agreement"] < 0.70:
        return "remote_product_validation_review"
    if row["uncertainty_communication"] < 0.75:
        return "uncertainty_communication_review"
    if row["decision_readiness"] < 0.75:
        return "decision_readiness_review"
    if row["soil_evidence_quality"] < 0.75:
        return "soil_evidence_quality_review"
    return "routine_monitoring"

def main() -> None:
    df = pd.read_csv(DATA_PATH)
    df["soil_evidence_quality"] = df.apply(soil_evidence_quality, axis=1).round(3)
    df["review_priority"] = df.apply(classify_review_priority, axis=1)
    out = df.sort_values(["review_priority", "soil_evidence_quality"])
    output_path = OUTPUT_DIR / "soil_monitoring_readiness_scores.csv"
    out.to_csv(output_path, index=False)
    print(out.to_string(index=False))
    print(f"Wrote: {output_path}")

if __name__ == "__main__":
    main()
