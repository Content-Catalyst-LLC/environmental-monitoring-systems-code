from pathlib import Path
import pandas as pd

ARTICLE_DIR = Path(__file__).resolve().parents[1]
DATA_PATH = ARTICLE_DIR / "data" / "iot_architecture_readiness_scores.csv"
OUTPUT_DIR = ARTICLE_DIR / "outputs"
OUTPUT_DIR.mkdir(exist_ok=True)

def as_bool(value) -> bool:
    if isinstance(value, bool):
        return value
    return str(value).strip().lower() in {"true", "1", "yes", "y"}

def latency_penalty(row: pd.Series) -> float:
    target = float(row["target_latency_minutes"])
    if target <= 0:
        return 1.0
    ratio = float(row["end_to_end_latency_minutes"]) / target
    return min(max(ratio - 1.0, 0.0), 1.0)

def iot_evidence_quality(row: pd.Series) -> float:
    return (
        0.18 * row["device_availability"]
        + 0.18 * row["delivery_completeness"]
        + 0.18 * row["semantic_completeness"]
        + 0.16 * row["qc_readiness"]
        + 0.14 * row["edge_traceability"]
        + 0.16 * row["decision_fit"]
        - 0.10 * row["latency_penalty"]
    )

def classify_review_priority(row: pd.Series) -> str:
    if as_bool(row["high_stakes_use"]) and row["qc_readiness"] < 0.80:
        return "high_stakes_qc_review"
    if row["device_availability"] < 0.75:
        return "device_reliability_review"
    if row["delivery_completeness"] < 0.80:
        return "connectivity_delivery_review"
    if row["semantic_completeness"] < 0.80:
        return "semantic_completeness_review"
    if row["edge_traceability"] < 0.75:
        return "edge_traceability_review"
    if row["end_to_end_latency_minutes"] > row["target_latency_minutes"]:
        return "latency_review"
    if row["decision_fit"] < 0.75:
        return "decision_fit_review"
    if row["iot_evidence_quality"] < 0.75:
        return "architecture_quality_review"
    return "routine_monitoring"

def main() -> None:
    df = pd.read_csv(DATA_PATH)
    df["latency_penalty"] = df.apply(latency_penalty, axis=1).round(3)
    df["iot_evidence_quality"] = df.apply(iot_evidence_quality, axis=1).round(3)
    df["review_priority"] = df.apply(classify_review_priority, axis=1)

    ranked = df.sort_values(["review_priority", "iot_evidence_quality"])
    output_path = OUTPUT_DIR / "iot_architecture_readiness_scores.csv"
    ranked.to_csv(output_path, index=False)

    print("IoT architecture readiness and environmental evidence review")
    print(ranked[[
        "component_id", "domain", "component_type", "iot_evidence_quality",
        "device_availability", "delivery_completeness", "semantic_completeness",
        "qc_readiness", "edge_traceability", "decision_fit", "latency_penalty",
        "review_priority"
    ]].to_string(index=False))
    print(f"\nWrote: {output_path}")

if __name__ == "__main__":
    main()
