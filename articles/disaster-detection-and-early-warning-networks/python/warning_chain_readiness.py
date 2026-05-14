from pathlib import Path
import pandas as pd

ARTICLE_DIR = Path(__file__).resolve().parents[1]
DATA_PATH = ARTICLE_DIR / "data" / "warning_scenarios.csv"
OUTPUT_DIR = ARTICLE_DIR / "outputs"
OUTPUT_DIR.mkdir(exist_ok=True)

def warning_effectiveness(row: pd.Series) -> float:
    """Estimate end-to-end warning effectiveness from visible warning-chain dimensions."""
    return (
        0.18 * row["detection_confidence"]
        + 0.16 * row["usable_lead_time_score"]
        + 0.16 * row["reach_score"]
        + 0.14 * row["trust_score"]
        + 0.14 * row["response_capacity_score"]
        + 0.14 * row["protective_action_score"]
        - 0.04 * row["missed_event_penalty"]
        - 0.04 * row["equity_gap_score"]
    )

def classify_review_priority(row: pd.Series) -> str:
    if row["equity_gap_score"] >= 0.30:
        return "equity_and_last_mile_review"
    if row["usable_lead_time_score"] < 0.50:
        return "lead_time_review"
    if row["reach_score"] < 0.60:
        return "communication_reach_review"
    if row["response_capacity_score"] < 0.55:
        return "preparedness_capacity_review"
    if row["warning_effectiveness"] < 0.65:
        return "end_to_end_warning_review"
    return "routine_monitoring"

def main() -> None:
    df = pd.read_csv(DATA_PATH)
    df["warning_effectiveness"] = df.apply(warning_effectiveness, axis=1).round(3)
    df["review_priority"] = df.apply(classify_review_priority, axis=1)

    ranked = df.sort_values(["review_priority", "warning_effectiveness"])
    output_path = OUTPUT_DIR / "warning_chain_readiness_scores.csv"
    ranked.to_csv(output_path, index=False)

    print("Warning chain readiness scores")
    print(ranked[[
        "scenario_id",
        "hazard_type",
        "warning_effectiveness",
        "usable_lead_time_score",
        "reach_score",
        "response_capacity_score",
        "equity_gap_score",
        "review_priority"
    ]].to_string(index=False))
    print(f"\nWrote: {output_path}")

if __name__ == "__main__":
    main()
