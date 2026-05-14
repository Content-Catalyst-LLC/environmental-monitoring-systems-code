from pathlib import Path
import pandas as pd

ARTICLE_DIR = Path(__file__).resolve().parents[1]
DATA_PATH = ARTICLE_DIR / "data" / "embedded_device_readiness_scores.csv"
OUTPUT_DIR = ARTICLE_DIR / "outputs"
OUTPUT_DIR.mkdir(exist_ok=True)

def as_bool(value) -> bool:
    if isinstance(value, bool):
        return value
    return str(value).strip().lower() in {"true", "1", "yes", "y"}

def device_availability(row: pd.Series) -> float:
    deployment = float(row["deployment_hours"])
    if deployment <= 0:
        return 0.0
    return max(0.0, min(1.0, float(row["valid_operation_hours"]) / deployment))

def record_completeness(row: pd.Series) -> float:
    expected = float(row["expected_records"])
    if expected <= 0:
        return 0.0
    return max(0.0, min(1.0, float(row["valid_records"]) / expected))

def power_margin_score(row: pd.Series) -> float:
    required = float(row["energy_required_wh"])
    if required <= 0:
        return 0.0
    margin = (float(row["energy_available_wh"]) - required) / required
    return max(0.0, min(1.0, 0.5 + margin))

def timing_consistency(row: pd.Series) -> float:
    allowed = float(row["allowed_clock_drift_seconds"])
    if allowed <= 0:
        return 0.0
    ratio = abs(float(row["clock_drift_seconds"])) / allowed
    return max(0.0, 1.0 - min(ratio, 1.0))

def field_evidence_quality(row: pd.Series) -> float:
    return (
        0.16 * row["device_availability"]
        + 0.16 * row["record_completeness"]
        + 0.14 * row["power_margin_score"]
        + 0.16 * row["calibration_validity"]
        + 0.12 * row["timing_consistency"]
        + 0.14 * row["qc_readiness"]
        + 0.12 * row["health_visibility"]
        + 0.10 * row["decision_fit"]
    )

def classify_review_priority(row: pd.Series) -> str:
    if as_bool(row["high_stakes_use"]) and row["calibration_validity"] < 0.80:
        return "high_stakes_calibration_review"
    if row["device_availability"] < 0.75:
        return "device_availability_review"
    if row["record_completeness"] < 0.80:
        return "record_completeness_review"
    if row["power_margin_score"] < 0.50:
        return "power_budget_review"
    if row["timing_consistency"] < 0.75:
        return "timing_integrity_review"
    if row["qc_readiness"] < 0.75:
        return "qaqc_readiness_review"
    if row["health_visibility"] < 0.75:
        return "device_health_visibility_review"
    if row["decision_fit"] < 0.75:
        return "decision_fit_review"
    if row["field_evidence_quality"] < 0.75:
        return "field_evidence_quality_review"
    return "routine_monitoring"

def main() -> None:
    df = pd.read_csv(DATA_PATH)
    df["device_availability"] = df.apply(device_availability, axis=1).round(3)
    df["record_completeness"] = df.apply(record_completeness, axis=1).round(3)
    df["power_margin_score"] = df.apply(power_margin_score, axis=1).round(3)
    df["timing_consistency"] = df.apply(timing_consistency, axis=1).round(3)
    df["field_evidence_quality"] = df.apply(field_evidence_quality, axis=1).round(3)
    df["review_priority"] = df.apply(classify_review_priority, axis=1)

    ranked = df.sort_values(["review_priority", "field_evidence_quality"])
    output_path = OUTPUT_DIR / "embedded_device_readiness_scores.csv"
    ranked.to_csv(output_path, index=False)

    print("Embedded field-device readiness and data-integrity review")
    print(ranked[[
        "device_id",
        "domain",
        "device_type",
        "device_availability",
        "record_completeness",
        "power_margin_score",
        "calibration_validity",
        "timing_consistency",
        "qc_readiness",
        "health_visibility",
        "decision_fit",
        "field_evidence_quality",
        "review_priority"
    ]].to_string(index=False))
    print(f"\nWrote: {output_path}")

if __name__ == "__main__":
    main()
