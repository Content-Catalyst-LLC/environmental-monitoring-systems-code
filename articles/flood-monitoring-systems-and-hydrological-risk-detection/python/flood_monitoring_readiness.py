from pathlib import Path
import pandas as pd

ARTICLE_DIR = Path(__file__).resolve().parents[1]
DATA_PATH = ARTICLE_DIR / "data" / "flood_monitoring_readiness_scores.csv"
OUTPUT_DIR = ARTICLE_DIR / "outputs"
OUTPUT_DIR.mkdir(exist_ok=True)

def as_bool(value) -> bool:
    if isinstance(value, bool):
        return value
    return str(value).strip().lower() in {"true", "1", "yes", "y"}

def flood_warning_quality(row: pd.Series) -> float:
    return (
        0.12 * row["gauge_coverage"]
        + 0.11 * row["rainfall_coverage"]
        + 0.12 * row["telemetry_completeness"]
        + 0.12 * row["forecast_confidence"]
        + 0.11 * row["inundation_map_readiness"]
        + 0.12 * row["protective_lead_time"]
        + 0.10 * row["communication_readiness"]
        + 0.10 * row["response_capacity"]
        + 0.10 * row["governance_readiness"]
    )

def classify_review_priority(row: pd.Series) -> str:
    if as_bool(row["high_stakes_use"]) and row["telemetry_completeness"] < 0.80:
        return "high_stakes_telemetry_review"
    if row["gauge_coverage"] < 0.70:
        return "gauge_coverage_review"
    if row["rainfall_coverage"] < 0.70:
        return "rainfall_coverage_review"
    if row["forecast_confidence"] < 0.70:
        return "forecast_confidence_review"
    if row["inundation_map_readiness"] < 0.70:
        return "inundation_mapping_review"
    if row["protective_lead_time"] < 0.70:
        return "lead_time_review"
    if row["communication_readiness"] < 0.75:
        return "communication_readiness_review"
    if row["response_capacity"] < 0.75:
        return "response_capacity_review"
    if row["governance_readiness"] < 0.75:
        return "governance_readiness_review"
    if row["flood_warning_quality"] < 0.75:
        return "flood_warning_quality_review"
    return "routine_monitoring"

def main() -> None:
    df = pd.read_csv(DATA_PATH)
    df["flood_warning_quality"] = df.apply(flood_warning_quality, axis=1).round(3)
    df["review_priority"] = df.apply(classify_review_priority, axis=1)
    out = df.sort_values(["review_priority", "flood_warning_quality"])
    output_path = OUTPUT_DIR / "flood_monitoring_readiness_scores.csv"
    out.to_csv(output_path, index=False)
    print("Flood monitoring readiness and hydrological risk evidence-quality review")
    print(out.to_string(index=False))
    print(f"\nWrote: {output_path}")

if __name__ == "__main__":
    main()
