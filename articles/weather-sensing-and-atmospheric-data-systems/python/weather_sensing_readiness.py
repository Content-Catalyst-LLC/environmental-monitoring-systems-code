from pathlib import Path
import pandas as pd

ARTICLE_DIR = Path(__file__).resolve().parents[1]
READINESS_PATH = ARTICLE_DIR / "data" / "weather_sensing_readiness_scores.csv"
LATENCY_PATH = ARTICLE_DIR / "data" / "telemetry_latency_log.csv"
ASSIM_PATH = ARTICLE_DIR / "data" / "assimilation_readiness_records.csv"
AUDIT_PATH = ARTICLE_DIR / "data" / "coverage_blindspot_audit.csv"
OUTPUT_DIR = ARTICLE_DIR / "outputs"
OUTPUT_DIR.mkdir(exist_ok=True)

def as_bool(value) -> bool:
    if isinstance(value, bool):
        return value
    return str(value).strip().lower() in {"true", "1", "yes", "y"}

def weather_evidence_quality(row: pd.Series) -> float:
    return (
        0.15 * row["observation_freshness"]
        + 0.13 * row["spatial_coverage"]
        + 0.13 * row["vertical_coverage"]
        + 0.14 * row["qc_completeness"]
        + 0.14 * row["assimilation_readiness"]
        + 0.11 * row["representativeness"]
        + 0.10 * row["uncertainty_communication"]
        + 0.10 * row["governance_readiness"]
    )

def classify_review_priority(row: pd.Series) -> str:
    if as_bool(row["high_stakes_use"]) and row["observation_freshness"] < 0.75:
        return "high_stakes_latency_review"
    if row["spatial_coverage"] < 0.70:
        return "spatial_coverage_review"
    if row["vertical_coverage"] < 0.70:
        return "vertical_coverage_review"
    if row["qc_completeness"] < 0.75:
        return "quality_control_review"
    if row["assimilation_readiness"] < 0.75:
        return "assimilation_readiness_review"
    if row["representativeness"] < 0.70:
        return "representativeness_review"
    if row["uncertainty_communication"] < 0.75:
        return "uncertainty_communication_review"
    if row["governance_readiness"] < 0.75:
        return "governance_readiness_review"
    if row["weather_evidence_quality"] < 0.75:
        return "weather_evidence_quality_review"
    return "routine_monitoring"

def summarize_latency() -> pd.DataFrame:
    latency = pd.read_csv(LATENCY_PATH)
    latency["fresh_report_ratio"] = (
        latency["received_reports"] / latency["expected_reports"]
    ).round(3)
    return latency[
        [
            "platform_id",
            "expected_reports",
            "received_reports",
            "fresh_report_ratio",
            "median_latency_minutes",
            "max_latency_minutes",
            "outage_minutes",
            "freshness_status",
        ]
    ].sort_values(["freshness_status", "fresh_report_ratio"])

def summarize_assimilation() -> pd.DataFrame:
    assim = pd.read_csv(ASSIM_PATH)
    bool_columns = [
        "metadata_complete",
        "qc_passed",
        "latency_within_budget",
        "format_supported",
        "error_model_available",
        "assimilable",
    ]
    for col in bool_columns:
        assim[col] = assim[col].map(as_bool)

    return (
        assim.groupby("platform_id", dropna=False)
        .agg(
            observations=("observation_id", "count"),
            assimilable_observations=("assimilable", "sum"),
            metadata_complete=("metadata_complete", "sum"),
            qc_passed=("qc_passed", "sum"),
            latency_within_budget=("latency_within_budget", "sum"),
        )
        .reset_index()
        .assign(
            assimilation_ready_ratio=lambda df: (
                df["assimilable_observations"] / df["observations"]
            ).round(3)
        )
        .sort_values("assimilation_ready_ratio")
    )

def summarize_coverage_gaps() -> pd.DataFrame:
    audits = pd.read_csv(AUDIT_PATH)
    return audits.sort_values(["priority", "coverage_score"])[
        [
            "audit_id",
            "program_id",
            "coverage_dimension",
            "target_zone_or_structure",
            "coverage_score",
            "priority",
            "evidence_gap",
        ]
    ]

def main() -> None:
    readiness = pd.read_csv(READINESS_PATH)
    readiness["weather_evidence_quality"] = readiness.apply(weather_evidence_quality, axis=1).round(3)
    readiness["review_priority"] = readiness.apply(classify_review_priority, axis=1)
    readiness = readiness.sort_values(["review_priority", "weather_evidence_quality"])

    readiness_output = OUTPUT_DIR / "weather_sensing_readiness_scores.csv"
    readiness.to_csv(readiness_output, index=False)

    latency_summary = summarize_latency()
    latency_output = OUTPUT_DIR / "weather_sensing_latency_summary.csv"
    latency_summary.to_csv(latency_output, index=False)

    assimilation_summary = summarize_assimilation()
    assimilation_output = OUTPUT_DIR / "weather_sensing_assimilation_summary.csv"
    assimilation_summary.to_csv(assimilation_output, index=False)

    coverage_gaps = summarize_coverage_gaps()
    coverage_output = OUTPUT_DIR / "weather_sensing_coverage_gap_summary.csv"
    coverage_gaps.to_csv(coverage_output, index=False)

    print("Weather sensing readiness and atmospheric evidence-quality review")
    print(readiness.to_string(index=False))
    print(f"\nWrote: {readiness_output}")

    print("\nLatency and freshness summary")
    print(latency_summary.to_string(index=False))
    print(f"\nWrote: {latency_output}")

    print("\nAssimilation readiness summary")
    print(assimilation_summary.to_string(index=False))
    print(f"\nWrote: {assimilation_output}")

    print("\nCoverage and blind-spot summary")
    print(coverage_gaps.to_string(index=False))
    print(f"\nWrote: {coverage_output}")

if __name__ == "__main__":
    main()
