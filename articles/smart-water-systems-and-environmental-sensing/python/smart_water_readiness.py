from pathlib import Path
import pandas as pd

ARTICLE_DIR = Path(__file__).resolve().parents[1]
DATA_PATH = ARTICLE_DIR / "data" / "smart_water_readiness_scores.csv"
OUTPUT_DIR = ARTICLE_DIR / "outputs"
OUTPUT_DIR.mkdir(exist_ok=True)

def as_bool(value) -> bool:
    if isinstance(value, bool):
        return value
    return str(value).strip().lower() in {"true", "1", "yes", "y"}

def smart_water_quality(row: pd.Series) -> float:
    return (
        0.11 * row["sensing_coverage"]
        + 0.13 * row["data_quality_validity"]
        + 0.12 * row["telemetry_completeness"]
        + 0.10 * row["latency_readiness"]
        + 0.10 * row["anomaly_confidence"]
        + 0.13 * row["response_capacity"]
        + 0.10 * row["model_readiness"]
        + 0.10 * row["control_safety"]
        + 0.11 * row["governance_readiness"]
    )

def classify_review_priority(row: pd.Series) -> str:
    if as_bool(row["high_stakes_use"]) and row["data_quality_validity"] < 0.75:
        return "high_stakes_data_quality_review"
    if row["telemetry_completeness"] < 0.80:
        return "telemetry_completeness_review"
    if row["response_capacity"] < 0.75:
        return "response_capacity_review"
    if row["control_safety"] < 0.75:
        return "control_safety_review"
    if row["model_readiness"] < 0.70:
        return "model_readiness_review"
    if row["governance_readiness"] < 0.75:
        return "governance_readiness_review"
    if row["smart_water_quality"] < 0.75:
        return "smart_water_quality_review"
    return "routine_monitoring"

def main() -> None:
    df = pd.read_csv(DATA_PATH)
    df["smart_water_quality"] = df.apply(smart_water_quality, axis=1).round(3)
    df["review_priority"] = df.apply(classify_review_priority, axis=1)
    out = df.sort_values(["review_priority", "smart_water_quality"])
    output_path = OUTPUT_DIR / "smart_water_readiness_scores.csv"
    out.to_csv(output_path, index=False)
    print(out.to_string(index=False))
    print(f"Wrote: {output_path}")

if __name__ == "__main__":
    main()
