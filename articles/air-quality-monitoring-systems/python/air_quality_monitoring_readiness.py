from pathlib import Path
import pandas as pd

ARTICLE_DIR = Path(__file__).resolve().parents[1]
READINESS_PATH = ARTICLE_DIR / "data" / "air_quality_monitoring_readiness_scores.csv"
OBS_PATH = ARTICLE_DIR / "data" / "pollutant_observation_records.csv"
CAL_PATH = ARTICLE_DIR / "data" / "calibration_collocation_log.csv"
EXPOSURE_PATH = ARTICLE_DIR / "data" / "exposure_equity_layer.csv"
OUTPUT_DIR = ARTICLE_DIR / "outputs"
OUTPUT_DIR.mkdir(exist_ok=True)

def as_bool(value) -> bool:
    if isinstance(value, bool):
        return value
    return str(value).strip().lower() in {"true", "1", "yes", "y"}

def air_evidence_quality(row: pd.Series) -> float:
    return (
        0.15 * row["calibration_quality"]
        + 0.14 * row["data_completeness"]
        + 0.13 * row["spatial_coverage"]
        + 0.12 * row["temporal_coverage"]
        + 0.12 * row["meteorological_context"]
        + 0.13 * row["exposure_relevance"]
        + 0.10 * row["uncertainty_communication"]
        + 0.11 * row["governance_readiness"]
    )

def classify_review_priority(row: pd.Series) -> str:
    if as_bool(row["high_stakes_use"]) and row["calibration_quality"] < 0.75:
        return "high_stakes_calibration_review"
    if row["data_completeness"] < 0.75:
        return "data_completeness_review"
    if row["spatial_coverage"] < 0.70:
        return "spatial_coverage_review"
    if row["temporal_coverage"] < 0.75:
        return "temporal_coverage_review"
    if row["meteorological_context"] < 0.70:
        return "meteorological_context_review"
    if row["exposure_relevance"] < 0.70:
        return "exposure_relevance_review"
    if row["uncertainty_communication"] < 0.75:
        return "uncertainty_communication_review"
    if row["governance_readiness"] < 0.75:
        return "governance_readiness_review"
    if row["air_evidence_quality"] < 0.75:
        return "air_evidence_quality_review"
    return "routine_monitoring"

def summarize_pollutants() -> pd.DataFrame:
    observations = pd.read_csv(OBS_PATH)
    return (
        observations.groupby(["pollutant", "unit"], dropna=False)
        .agg(
            observations=("observation_id", "count"),
            mean_value=("value", "mean"),
            max_value=("value", "max"),
            review_required=("qc_flag", lambda s: int((s != "pass").sum())),
        )
        .reset_index()
        .round(3)
        .sort_values(["review_required", "pollutant"], ascending=[False, True])
    )

def summarize_calibration() -> pd.DataFrame:
    calibration = pd.read_csv(CAL_PATH)
    return (
        calibration.groupby(["sensor_id", "status"], dropna=False)
        .agg(
            calibration_events=("calibration_id", "count"),
            review_items=("status", lambda s: int((s != "pass").sum())),
        )
        .reset_index()
        .sort_values(["review_items", "sensor_id"], ascending=[False, True])
    )

def summarize_exposure_equity() -> pd.DataFrame:
    exposure = pd.read_csv(EXPOSURE_PATH)
    return exposure.sort_values(["priority", "monitoring_coverage_score"])[
        [
            "exposure_id",
            "program_id",
            "geography",
            "population_group",
            "source_context",
            "exposure_relevance_score",
            "vulnerability_score",
            "monitoring_coverage_score",
            "priority",
        ]
    ]

def main() -> None:
    readiness = pd.read_csv(READINESS_PATH)
    readiness["air_evidence_quality"] = readiness.apply(air_evidence_quality, axis=1).round(3)
    readiness["review_priority"] = readiness.apply(classify_review_priority, axis=1)
    readiness = readiness.sort_values(["review_priority", "air_evidence_quality"])

    readiness_output = OUTPUT_DIR / "air_quality_monitoring_readiness_scores.csv"
    readiness.to_csv(readiness_output, index=False)

    pollutant_summary = summarize_pollutants()
    pollutant_output = OUTPUT_DIR / "air_quality_pollutant_summary.csv"
    pollutant_summary.to_csv(pollutant_output, index=False)

    calibration_summary = summarize_calibration()
    calibration_output = OUTPUT_DIR / "air_quality_calibration_summary.csv"
    calibration_summary.to_csv(calibration_output, index=False)

    exposure_summary = summarize_exposure_equity()
    exposure_output = OUTPUT_DIR / "air_quality_exposure_equity_summary.csv"
    exposure_summary.to_csv(exposure_output, index=False)

    print("Air quality monitoring readiness and evidence-quality review")
    print(readiness.to_string(index=False))
    print(f"\nWrote: {readiness_output}")

    print("\nPollutant observation summary")
    print(pollutant_summary.to_string(index=False))
    print(f"\nWrote: {pollutant_output}")

    print("\nCalibration and collocation summary")
    print(calibration_summary.to_string(index=False))
    print(f"\nWrote: {calibration_output}")

    print("\nExposure and equity summary")
    print(exposure_summary.to_string(index=False))
    print(f"\nWrote: {exposure_output}")

if __name__ == "__main__":
    main()
