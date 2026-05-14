from pathlib import Path
import pandas as pd

ARTICLE_DIR = Path(__file__).resolve().parents[1]
DATA_PATH = ARTICLE_DIR / "data" / "network_readiness_scores.csv"
OUTPUT_DIR = ARTICLE_DIR / "outputs"
OUTPUT_DIR.mkdir(exist_ok=True)

def as_bool(value) -> bool:
    if isinstance(value, bool):
        return value
    return str(value).strip().lower() in {"true", "1", "yes", "y"}

def spatial_coverage(row: pd.Series) -> float:
    target = float(row["target_area_km2"])
    if target <= 0:
        return 0.0
    return max(0.0, min(1.0, float(row["monitored_area_km2"]) / target))

def temporal_completeness(row: pd.Series) -> float:
    expected = float(row["expected_time_steps"])
    if expected <= 0:
        return 0.0
    return max(0.0, min(1.0, float(row["valid_time_steps"]) / expected))

def network_availability(row: pd.Series) -> float:
    deployed = float(row["deployed_nodes"])
    if deployed <= 0:
        return 0.0
    return max(0.0, min(1.0, float(row["active_nodes"]) / deployed))

def latency_readiness(row: pd.Series) -> float:
    target = float(row["target_latency_minutes"])
    if target <= 0:
        return 0.0
    ratio = float(row["observed_latency_minutes"]) / target
    return max(0.0, 1.0 - min(ratio, 1.0))

def network_evidence_quality(row: pd.Series) -> float:
    return (
        0.14 * row["spatial_coverage"]
        + 0.14 * row["temporal_completeness"]
        + 0.14 * row["network_availability"]
        + 0.14 * row["representativeness"]
        + 0.14 * row["valid_data_share"]
        + 0.12 * row["metadata_maturity"]
        + 0.10 * row["latency_readiness"]
        + 0.08 * row["action_fit"]
    )

def classify_review_priority(row: pd.Series) -> str:
    if as_bool(row["high_stakes_use"]) and row["valid_data_share"] < 0.80:
        return "high_stakes_quality_review"
    if row["spatial_coverage"] < 0.70:
        return "coverage_review"
    if row["temporal_completeness"] < 0.80:
        return "temporal_completeness_review"
    if row["network_availability"] < 0.80:
        return "node_availability_review"
    if row["representativeness"] < 0.75:
        return "representativeness_review"
    if row["metadata_maturity"] < 0.75:
        return "metadata_interoperability_review"
    if row["latency_readiness"] < 0.25:
        return "latency_readiness_review"
    if row["action_fit"] < 0.75:
        return "action_fit_review"
    if row["network_evidence_quality"] < 0.75:
        return "network_evidence_quality_review"
    return "routine_monitoring"

def main() -> None:
    df = pd.read_csv(DATA_PATH)
    df["spatial_coverage"] = df.apply(spatial_coverage, axis=1).round(3)
    df["temporal_completeness"] = df.apply(temporal_completeness, axis=1).round(3)
    df["network_availability"] = df.apply(network_availability, axis=1).round(3)
    df["latency_readiness"] = df.apply(latency_readiness, axis=1).round(3)
    df["network_evidence_quality"] = df.apply(network_evidence_quality, axis=1).round(3)
    df["review_priority"] = df.apply(classify_review_priority, axis=1)

    ranked = df.sort_values(["review_priority", "network_evidence_quality"])
    output_path = OUTPUT_DIR / "sensor_network_readiness_scores.csv"
    ranked.to_csv(output_path, index=False)

    print("Environmental sensor-network readiness and evidence-quality review")
    print(ranked[[
        "network_id",
        "domain",
        "network_type",
        "spatial_coverage",
        "temporal_completeness",
        "network_availability",
        "representativeness",
        "valid_data_share",
        "metadata_maturity",
        "latency_readiness",
        "action_fit",
        "network_evidence_quality",
        "review_priority"
    ]].to_string(index=False))
    print(f"\nWrote: {output_path}")

if __name__ == "__main__":
    main()
