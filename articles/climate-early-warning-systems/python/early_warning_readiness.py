from pathlib import Path
import pandas as pd

ARTICLE_DIR = Path(__file__).resolve().parents[1]
READINESS_PATH = ARTICLE_DIR / "data" / "early_warning_readiness_scores.csv"
WARNING_PATH = ARTICLE_DIR / "data" / "warning_decision_log.csv"
CHANNEL_PATH = ARTICLE_DIR / "data" / "communication_channel_registry.csv"
AUDIT_PATH = ARTICLE_DIR / "data" / "coverage_inclusion_audit.csv"
OUTPUT_DIR = ARTICLE_DIR / "outputs"
OUTPUT_DIR.mkdir(exist_ok=True)

def as_bool(value) -> bool:
    if isinstance(value, bool):
        return value
    return str(value).strip().lower() in {"true", "1", "yes", "y"}

def early_warning_quality(row: pd.Series) -> float:
    return (
        0.14 * row["forecast_confidence"]
        + 0.14 * row["risk_knowledge"]
        + 0.14 * row["protective_lead_time"]
        + 0.13 * row["communication_reach"]
        + 0.13 * row["action_capacity"]
        + 0.10 * row["trust_readiness"]
        + 0.11 * row["inclusion_capacity"]
        + 0.11 * row["governance_readiness"]
    )

def classify_review_priority(row: pd.Series) -> str:
    if as_bool(row["high_stakes_use"]) and row["protective_lead_time"] < 0.70:
        return "high_stakes_lead_time_review"
    if row["forecast_confidence"] < 0.70:
        return "forecast_confidence_review"
    if row["risk_knowledge"] < 0.70:
        return "risk_knowledge_review"
    if row["communication_reach"] < 0.75:
        return "communication_reach_review"
    if row["action_capacity"] < 0.75:
        return "action_capacity_review"
    if row["trust_readiness"] < 0.70:
        return "trust_readiness_review"
    if row["inclusion_capacity"] < 0.75:
        return "inclusion_capacity_review"
    if row["governance_readiness"] < 0.75:
        return "governance_readiness_review"
    if row["early_warning_quality"] < 0.75:
        return "early_warning_quality_review"
    return "routine_monitoring"

def summarize_warning_lead_time() -> pd.DataFrame:
    warnings = pd.read_csv(WARNING_PATH)
    return (
        warnings.groupby(["program_id", "hazard_type", "warning_level"], dropna=False)
        .agg(
            warnings=("decision_id", "count"),
            mean_protective_lead_time_hours=("protective_lead_time_hours", "mean"),
            min_protective_lead_time_hours=("protective_lead_time_hours", "min"),
        )
        .reset_index()
        .round(3)
    )

def summarize_channel_coverage() -> pd.DataFrame:
    channels = pd.read_csv(CHANNEL_PATH)
    return (
        channels.groupby("program_id", dropna=False)
        .agg(
            channels=("channel_id", "count"),
            mean_coverage=("coverage_estimate", "mean"),
            fallback_channels=("fallback_available", lambda s: int(sum(as_bool(v) for v in s))),
            review_channels=("status", lambda s: int((s != "active").sum())),
        )
        .reset_index()
        .round(3)
    )

def summarize_inclusion_gaps() -> pd.DataFrame:
    audits = pd.read_csv(AUDIT_PATH)
    return (
        audits.sort_values(["priority", "coverage_score"])
        [["audit_id", "program_id", "coverage_dimension", "target_group_or_zone", "coverage_score", "priority", "evidence_gap"]]
    )

def main() -> None:
    readiness = pd.read_csv(READINESS_PATH)
    readiness["early_warning_quality"] = readiness.apply(early_warning_quality, axis=1).round(3)
    readiness["review_priority"] = readiness.apply(classify_review_priority, axis=1)
    readiness = readiness.sort_values(["review_priority", "early_warning_quality"])

    readiness_output = OUTPUT_DIR / "early_warning_readiness_scores.csv"
    readiness.to_csv(readiness_output, index=False)

    lead_time = summarize_warning_lead_time()
    lead_time_output = OUTPUT_DIR / "early_warning_lead_time_summary.csv"
    lead_time.to_csv(lead_time_output, index=False)

    channel_coverage = summarize_channel_coverage()
    channel_output = OUTPUT_DIR / "early_warning_channel_coverage_summary.csv"
    channel_coverage.to_csv(channel_output, index=False)

    inclusion_gaps = summarize_inclusion_gaps()
    inclusion_output = OUTPUT_DIR / "early_warning_inclusion_gap_summary.csv"
    inclusion_gaps.to_csv(inclusion_output, index=False)

    print("Early warning readiness and protective lead-time review")
    print(readiness.to_string(index=False))
    print(f"\nWrote: {readiness_output}")

    print("\nWarning lead-time summary")
    print(lead_time.to_string(index=False))
    print(f"\nWrote: {lead_time_output}")

    print("\nCommunication channel coverage summary")
    print(channel_coverage.to_string(index=False))
    print(f"\nWrote: {channel_output}")

    print("\nInclusion gap summary")
    print(inclusion_gaps.to_string(index=False))
    print(f"\nWrote: {inclusion_output}")

if __name__ == "__main__":
    main()
