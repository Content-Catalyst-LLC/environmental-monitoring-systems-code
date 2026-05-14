from pathlib import Path
import pandas as pd

ARTICLE_DIR = Path(__file__).resolve().parents[1]
READINESS_PATH = ARTICLE_DIR / "data" / "climate_monitoring_readiness_scores.csv"
INDICATOR_PATH = ARTICLE_DIR / "data" / "climate_indicator_anomaly_table.csv"
AUDIT_PATH = ARTICLE_DIR / "data" / "coverage_continuity_audit.csv"
ADJUSTMENT_PATH = ARTICLE_DIR / "data" / "homogenization_adjustment_log.csv"
OUTPUT_DIR = ARTICLE_DIR / "outputs"
OUTPUT_DIR.mkdir(exist_ok=True)

def as_bool(value) -> bool:
    if isinstance(value, bool):
        return value
    return str(value).strip().lower() in {"true", "1", "yes", "y"}

def climate_record_quality(row: pd.Series) -> float:
    return (
        0.15 * row["record_continuity"]
        + 0.13 * row["metadata_completeness"]
        + 0.14 * row["calibration_quality"]
        + 0.13 * row["homogenization_readiness"]
        + 0.13 * row["spatial_coverage"]
        + 0.11 * row["version_control"]
        + 0.10 * row["uncertainty_communication"]
        + 0.11 * row["governance_readiness"]
    )

def classify_review_priority(row: pd.Series) -> str:
    if as_bool(row["high_stakes_use"]) and row["record_continuity"] < 0.75:
        return "high_stakes_record_continuity_review"
    if row["metadata_completeness"] < 0.75:
        return "metadata_completeness_review"
    if row["calibration_quality"] < 0.75:
        return "calibration_quality_review"
    if row["homogenization_readiness"] < 0.75:
        return "homogenization_readiness_review"
    if row["spatial_coverage"] < 0.70:
        return "spatial_coverage_review"
    if row["version_control"] < 0.75:
        return "version_control_review"
    if row["uncertainty_communication"] < 0.75:
        return "uncertainty_communication_review"
    if row["governance_readiness"] < 0.75:
        return "governance_readiness_review"
    if row["climate_record_quality"] < 0.75:
        return "climate_record_quality_review"
    return "routine_monitoring"

def summarize_indicators() -> pd.DataFrame:
    indicators = pd.read_csv(INDICATOR_PATH)
    indicators["trend_ready_bool"] = indicators["trend_ready"].map(as_bool)
    return (
        indicators.groupby(["record_id", "climate_variable"], dropna=False)
        .agg(
            records=("indicator_id", "count"),
            mean_anomaly=("anomaly", "mean"),
            max_anomaly=("anomaly", "max"),
            trend_ready_records=("trend_ready_bool", "sum"),
        )
        .reset_index()
        .round(3)
    )

def summarize_coverage_gaps() -> pd.DataFrame:
    audits = pd.read_csv(AUDIT_PATH)
    return audits.sort_values(["priority", "coverage_score"])[
        [
            "audit_id",
            "program_id",
            "domain",
            "coverage_dimension",
            "target_zone_or_record",
            "coverage_score",
            "priority",
            "evidence_gap",
        ]
    ]

def summarize_adjustments() -> pd.DataFrame:
    adjustments = pd.read_csv(ADJUSTMENT_PATH)
    return (
        adjustments.groupby(["platform_id", "climate_variable", "status"], dropna=False)
        .agg(
            adjustments=("adjustment_id", "count"),
            review_items=("status", lambda s: int((s != "pass").sum())),
        )
        .reset_index()
    )

def main() -> None:
    readiness = pd.read_csv(READINESS_PATH)
    readiness["climate_record_quality"] = readiness.apply(climate_record_quality, axis=1).round(3)
    readiness["review_priority"] = readiness.apply(classify_review_priority, axis=1)
    readiness = readiness.sort_values(["review_priority", "climate_record_quality"])

    readiness_output = OUTPUT_DIR / "climate_monitoring_readiness_scores.csv"
    readiness.to_csv(readiness_output, index=False)

    indicator_summary = summarize_indicators()
    indicator_output = OUTPUT_DIR / "climate_indicator_anomaly_summary.csv"
    indicator_summary.to_csv(indicator_output, index=False)

    coverage_gaps = summarize_coverage_gaps()
    coverage_output = OUTPUT_DIR / "climate_monitoring_coverage_gap_summary.csv"
    coverage_gaps.to_csv(coverage_output, index=False)

    adjustment_summary = summarize_adjustments()
    adjustment_output = OUTPUT_DIR / "climate_homogenization_adjustment_summary.csv"
    adjustment_summary.to_csv(adjustment_output, index=False)

    print("Climate monitoring readiness and record-quality review")
    print(readiness.to_string(index=False))
    print(f"\nWrote: {readiness_output}")

    print("\nClimate indicator anomaly summary")
    print(indicator_summary.to_string(index=False))
    print(f"\nWrote: {indicator_output}")

    print("\nCoverage and continuity gap summary")
    print(coverage_gaps.to_string(index=False))
    print(f"\nWrote: {coverage_output}")

    print("\nHomogenization and adjustment summary")
    print(adjustment_summary.to_string(index=False))
    print(f"\nWrote: {adjustment_output}")

if __name__ == "__main__":
    main()
