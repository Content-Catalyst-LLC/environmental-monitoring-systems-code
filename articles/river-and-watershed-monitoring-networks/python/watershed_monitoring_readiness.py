from pathlib import Path
import pandas as pd

ARTICLE_DIR = Path(__file__).resolve().parents[1]
DATA_PATH = ARTICLE_DIR / "data" / "watershed_monitoring_readiness_scores.csv"
LOAD_PATH = ARTICLE_DIR / "data" / "water_quality_load_records.csv"
OUTPUT_DIR = ARTICLE_DIR / "outputs"
OUTPUT_DIR.mkdir(exist_ok=True)

def as_bool(value) -> bool:
    if isinstance(value, bool):
        return value
    return str(value).strip().lower() in {"true", "1", "yes", "y"}

def watershed_evidence_quality(row: pd.Series) -> float:
    return (
        0.12 * row["gauge_coverage"]
        + 0.12 * row["water_quality_coverage"]
        + 0.10 * row["ecological_coverage"]
        + 0.13 * row["network_representativeness"]
        + 0.12 * row["temporal_continuity"]
        + 0.12 * row["event_capture"]
        + 0.09 * row["uncertainty_communication"]
        + 0.10 * row["interoperability"]
        + 0.10 * row["governance_readiness"]
    )

def classify_review_priority(row: pd.Series) -> str:
    if as_bool(row["high_stakes_use"]) and row["network_representativeness"] < 0.70:
        return "high_stakes_representativeness_review"
    if row["gauge_coverage"] < 0.70:
        return "gauge_coverage_review"
    if row["water_quality_coverage"] < 0.70:
        return "water_quality_coverage_review"
    if row["ecological_coverage"] < 0.65:
        return "ecological_coverage_review"
    if row["temporal_continuity"] < 0.70:
        return "temporal_continuity_review"
    if row["event_capture"] < 0.70:
        return "event_capture_review"
    if row["interoperability"] < 0.75:
        return "interoperability_review"
    if row["governance_readiness"] < 0.75:
        return "governance_readiness_review"
    if row["watershed_evidence_quality"] < 0.75:
        return "watershed_evidence_quality_review"
    return "routine_monitoring"

def summarize_loads() -> pd.DataFrame:
    loads = pd.read_csv(LOAD_PATH)
    summary = (
        loads.groupby(["station_id", "constituent", "event_flag"], dropna=False)
        .agg(
            records=("record_id", "count"),
            mean_concentration_mg_L=("concentration_mg_L", "mean"),
            total_instantaneous_load_kg_day=("instantaneous_load_kg_day", "sum"),
            review_records=("quality_flag", lambda s: int((s != "pass").sum())),
        )
        .reset_index()
    )
    return summary

def main() -> None:
    df = pd.read_csv(DATA_PATH)
    df["watershed_evidence_quality"] = df.apply(watershed_evidence_quality, axis=1).round(3)
    df["review_priority"] = df.apply(classify_review_priority, axis=1)
    readiness = df.sort_values(["review_priority", "watershed_evidence_quality"])

    readiness_output = OUTPUT_DIR / "watershed_monitoring_readiness_scores.csv"
    readiness.to_csv(readiness_output, index=False)

    load_summary = summarize_loads()
    load_output = OUTPUT_DIR / "watershed_load_summary.csv"
    load_summary.to_csv(load_output, index=False)

    print("Watershed monitoring readiness and basin evidence-quality review")
    print(readiness.to_string(index=False))
    print(f"\nWrote: {readiness_output}")

    print("\nWater-quality load summary")
    print(load_summary.to_string(index=False))
    print(f"\nWrote: {load_output}")

if __name__ == "__main__":
    main()
