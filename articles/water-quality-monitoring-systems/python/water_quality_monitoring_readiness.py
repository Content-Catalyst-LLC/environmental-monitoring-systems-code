from pathlib import Path
import pandas as pd

ARTICLE_DIR = Path(__file__).resolve().parents[1]
READINESS_PATH = ARTICLE_DIR / "data" / "water_quality_monitoring_readiness_scores.csv"
LOAD_PATH = ARTICLE_DIR / "data" / "hydrology_load_linkage.csv"
LAB_PATH = ARTICLE_DIR / "data" / "laboratory_results.csv"
THRESHOLD_PATH = ARTICLE_DIR / "data" / "assessment_threshold_registry.csv"
OUTPUT_DIR = ARTICLE_DIR / "outputs"
OUTPUT_DIR.mkdir(exist_ok=True)

def as_bool(value) -> bool:
    if isinstance(value, bool):
        return value
    return str(value).strip().lower() in {"true", "1", "yes", "y"}

def water_quality_evidence_score(row: pd.Series) -> float:
    return (
        0.13 * row["sampling_representativeness"]
        + 0.13 * row["analytical_validity"]
        + 0.12 * row["hydrological_context"]
        + 0.13 * row["qaqc_completeness"]
        + 0.11 * row["load_readiness"]
        + 0.11 * row["threshold_alignment"]
        + 0.09 * row["uncertainty_communication"]
        + 0.09 * row["data_interoperability"]
        + 0.09 * row["governance_readiness"]
    )

def classify_review_priority(row: pd.Series) -> str:
    if as_bool(row["high_stakes_use"]) and row["analytical_validity"] < 0.75:
        return "high_stakes_analytical_validity_review"
    if row["sampling_representativeness"] < 0.70:
        return "sampling_representativeness_review"
    if row["hydrological_context"] < 0.70:
        return "hydrological_context_review"
    if row["qaqc_completeness"] < 0.75:
        return "qaqc_completeness_review"
    if row["load_readiness"] < 0.70:
        return "load_readiness_review"
    if row["threshold_alignment"] < 0.75:
        return "threshold_alignment_review"
    if row["uncertainty_communication"] < 0.75:
        return "uncertainty_communication_review"
    if row["data_interoperability"] < 0.75:
        return "data_interoperability_review"
    if row["governance_readiness"] < 0.75:
        return "governance_readiness_review"
    if row["water_quality_evidence_score"] < 0.75:
        return "water_quality_evidence_review"
    return "routine_monitoring"

def summarize_loads() -> pd.DataFrame:
    loads = pd.read_csv(LOAD_PATH)
    valid_loads = loads.dropna(subset=["instantaneous_load_kg_day"]).copy()
    summary = (
        valid_loads.groupby(["site_id", "concentration_parameter", "event_flag"], dropna=False)
        .agg(
            records=("link_id", "count"),
            mean_concentration=("concentration_value", "mean"),
            total_instantaneous_load_kg_day=("instantaneous_load_kg_day", "sum"),
            review_records=("quality_flag", lambda s: int((s != "pass").sum())),
        )
        .reset_index()
    )
    return summary

def summarize_threshold_exceedances() -> pd.DataFrame:
    lab = pd.read_csv(LAB_PATH)
    thresholds = pd.read_csv(THRESHOLD_PATH)
    merged = lab.merge(thresholds, on="parameter_id", how="inner")
    merged["exceeds"] = merged.apply(
        lambda row: row["result_value"] > row["threshold_value"]
        if row["threshold_type"] == "above"
        else row["result_value"] < row["threshold_value"],
        axis=1,
    )
    summary = (
        merged.groupby(["parameter_id", "decision_use"], dropna=False)
        .agg(
            valid_observations=("lab_result_id", "count"),
            exceedances=("exceeds", "sum"),
            review_records=("lab_qaqc_flag", lambda s: int((s != "pass").sum())),
        )
        .reset_index()
    )
    summary["exceedance_ratio"] = (
        summary["exceedances"] / summary["valid_observations"]
    ).round(3)
    return summary

def main() -> None:
    readiness = pd.read_csv(READINESS_PATH)
    readiness["water_quality_evidence_score"] = readiness.apply(
        water_quality_evidence_score, axis=1
    ).round(3)
    readiness["review_priority"] = readiness.apply(classify_review_priority, axis=1)
    readiness = readiness.sort_values(["review_priority", "water_quality_evidence_score"])

    readiness_output = OUTPUT_DIR / "water_quality_monitoring_readiness_scores.csv"
    readiness.to_csv(readiness_output, index=False)

    load_summary = summarize_loads()
    load_output = OUTPUT_DIR / "water_quality_load_summary.csv"
    load_summary.to_csv(load_output, index=False)

    exceedance_summary = summarize_threshold_exceedances()
    exceedance_output = OUTPUT_DIR / "water_quality_exceedance_summary.csv"
    exceedance_summary.to_csv(exceedance_output, index=False)

    print("Water quality monitoring readiness and aquatic evidence-quality review")
    print(readiness.to_string(index=False))
    print(f"\nWrote: {readiness_output}")

    print("\nLoad summary")
    print(load_summary.to_string(index=False))
    print(f"\nWrote: {load_output}")

    print("\nThreshold exceedance summary")
    print(exceedance_summary.to_string(index=False))
    print(f"\nWrote: {exceedance_output}")

if __name__ == "__main__":
    main()
