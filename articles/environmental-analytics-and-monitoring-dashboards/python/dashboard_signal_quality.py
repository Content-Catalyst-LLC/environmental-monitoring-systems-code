from pathlib import Path
import pandas as pd

ARTICLE_DIR = Path(__file__).resolve().parents[1]
DATA_PATH = ARTICLE_DIR / "data" / "dashboard_indicators.csv"
OUTPUT_DIR = ARTICLE_DIR / "outputs"
OUTPUT_DIR.mkdir(exist_ok=True)

def as_bool(value) -> bool:
    if isinstance(value, bool):
        return value
    return str(value).strip().lower() in {"true", "1", "yes", "y"}

def alert_burden(row: pd.Series) -> float:
    if row["actionable_alert_count"] == 0:
        return float(row["alert_count"])
    return float(row["alert_count"]) / float(row["actionable_alert_count"])

def decision_support_score(row: pd.Series) -> float:
    freshness = 1.0 if as_bool(row["is_fresh"]) else 0.0
    provenance = 1.0 if as_bool(row["has_provenance"]) else 0.0
    modeled = as_bool(row["is_modeled_or_estimated"])
    uncertainty_labeled = as_bool(row["uncertainty_labeled"])
    uncertainty_visibility = 1.0 if (not modeled or uncertainty_labeled) else 0.0
    role_fit = 1.0 if as_bool(row["supports_priority_task"]) else 0.0
    burden = min(alert_burden(row) / 10.0, 1.0)

    return (
        0.25 * freshness
        + 0.25 * provenance
        + 0.20 * uncertainty_visibility
        + 0.20 * role_fit
        - 0.10 * burden
    )

def classify_review_priority(row: pd.Series) -> str:
    if not as_bool(row["has_provenance"]):
        return "provenance_review"
    if as_bool(row["is_modeled_or_estimated"]) and not as_bool(row["uncertainty_labeled"]):
        return "uncertainty_visibility_review"
    if row["alert_burden"] > 5:
        return "alert_burden_review"
    if not as_bool(row["supports_priority_task"]):
        return "user_role_fit_review"
    if row["decision_support_score"] < 0.70:
        return "dashboard_quality_review"
    return "routine_monitoring"

def main() -> None:
    df = pd.read_csv(DATA_PATH)
    df["alert_burden"] = df.apply(alert_burden, axis=1).round(3)
    df["decision_support_score"] = df.apply(decision_support_score, axis=1).round(3)
    df["review_priority"] = df.apply(classify_review_priority, axis=1)

    ranked = df.sort_values(["review_priority", "decision_support_score"])
    output_path = OUTPUT_DIR / "dashboard_signal_quality_scores.csv"
    ranked.to_csv(output_path, index=False)

    print("Dashboard signal quality and alert review")
    print(ranked[[
        "indicator_id",
        "domain",
        "user_role",
        "decision_support_score",
        "alert_burden",
        "is_fresh",
        "has_provenance",
        "uncertainty_labeled",
        "supports_priority_task",
        "review_priority"
    ]].to_string(index=False))
    print(f"\nWrote: {output_path}")

if __name__ == "__main__":
    main()
