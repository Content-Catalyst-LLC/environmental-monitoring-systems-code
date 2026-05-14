from pathlib import Path
import pandas as pd

ARTICLE_DIR = Path(__file__).resolve().parents[1]
DATA_PATH = ARTICLE_DIR / "data" / "edge_readiness_scores.csv"
OUTPUT_DIR = ARTICLE_DIR / "outputs"
OUTPUT_DIR.mkdir(exist_ok=True)

def as_bool(value) -> bool:
    if isinstance(value, bool):
        return value
    return str(value).strip().lower() in {"true", "1", "yes", "y"}

def latency_readiness(row: pd.Series) -> float:
    target = float(row["target_latency_seconds"])
    if target <= 0:
        return 0.0
    ratio = float(row["observed_latency_seconds"]) / target
    return max(0.0, 1.0 - min(ratio, 1.0))

def bandwidth_reduction(row: pd.Series) -> float:
    raw = float(row["raw_data_mb"])
    if raw <= 0:
        return 0.0
    return max(0.0, min(1.0, 1.0 - float(row["transmitted_data_mb"]) / raw))

def loss_penalty(row: pd.Series) -> float:
    raw = float(row["raw_data_mb"])
    if raw <= 0:
        return 0.0
    return max(0.0, min(1.0, float(row["discarded_without_audit_mb"]) / raw))

def edge_evidence_quality(row: pd.Series) -> float:
    return (
        0.16 * row["latency_readiness"]
        + 0.16 * row["edge_traceability"]
        + 0.16 * row["retained_context_score"]
        + 0.16 * row["qc_readiness"]
        + 0.14 * row["inference_transparency"]
        + 0.14 * row["decision_fit"]
        + 0.08 * row["bandwidth_reduction"]
        - 0.12 * row["loss_penalty"]
    )

def classify_review_priority(row: pd.Series) -> str:
    if as_bool(row["high_stakes_use"]) and row["qc_readiness"] < 0.80:
        return "high_stakes_qc_review"
    if row["latency_readiness"] < 0.20:
        return "latency_readiness_review"
    if row["edge_traceability"] < 0.75:
        return "edge_traceability_review"
    if row["retained_context_score"] < 0.70:
        return "retained_context_review"
    if row["inference_transparency"] < 0.75:
        return "inference_transparency_review"
    if row["loss_penalty"] > 0.30:
        return "loss_policy_review"
    if row["decision_fit"] < 0.75:
        return "decision_fit_review"
    if row["edge_evidence_quality"] < 0.75:
        return "edge_quality_review"
    return "routine_monitoring"

def main() -> None:
    df = pd.read_csv(DATA_PATH)
    df["latency_readiness"] = df.apply(latency_readiness, axis=1).round(3)
    df["bandwidth_reduction"] = df.apply(bandwidth_reduction, axis=1).round(3)
    df["loss_penalty"] = df.apply(loss_penalty, axis=1).round(3)
    df["edge_evidence_quality"] = df.apply(edge_evidence_quality, axis=1).round(3)
    df["review_priority"] = df.apply(classify_review_priority, axis=1)

    ranked = df.sort_values(["review_priority", "edge_evidence_quality"])
    output_path = OUTPUT_DIR / "edge_readiness_scores.csv"
    ranked.to_csv(output_path, index=False)

    print("Edge computing readiness and environmental evidence review")
    print(ranked[[
        "component_id",
        "domain",
        "component_type",
        "latency_readiness",
        "bandwidth_reduction",
        "loss_penalty",
        "retained_context_score",
        "edge_traceability",
        "qc_readiness",
        "inference_transparency",
        "decision_fit",
        "edge_evidence_quality",
        "review_priority"
    ]].to_string(index=False))
    print(f"\nWrote: {output_path}")

if __name__ == "__main__":
    main()
