from pathlib import Path
import pandas as pd

ARTICLE_DIR = Path(__file__).resolve().parents[1]
DATA_PATH = ARTICLE_DIR / "data" / "ecosystem_monitoring_readiness_scores.csv"
OUTPUT_DIR = ARTICLE_DIR / "outputs"
OUTPUT_DIR.mkdir(exist_ok=True)

def as_bool(value) -> bool:
    if isinstance(value, bool):
        return value
    return str(value).strip().lower() in {"true", "1", "yes", "y"}

def ecosystem_evidence_quality(row: pd.Series) -> float:
    return (
        0.11 * row["extent_visibility"]
        + 0.14 * row["condition_evidence"]
        + 0.11 * row["structure_evidence"]
        + 0.12 * row["function_evidence"]
        + 0.13 * row["integrity_evidence"]
        + 0.12 * row["resilience_evidence"]
        + 0.10 * row["baseline_strength"]
        + 0.08 * row["uncertainty_communication"]
        + 0.09 * row["governance_readiness"]
    )

def classify_review_priority(row: pd.Series) -> str:
    if as_bool(row["high_stakes_use"]) and row["condition_evidence"] < 0.75:
        return "high_stakes_condition_review"
    if row["extent_visibility"] < 0.70:
        return "extent_visibility_review"
    if row["condition_evidence"] < 0.75:
        return "condition_evidence_review"
    if row["function_evidence"] < 0.70:
        return "function_evidence_review"
    if row["integrity_evidence"] < 0.70:
        return "integrity_evidence_review"
    if row["resilience_evidence"] < 0.70:
        return "resilience_evidence_review"
    if row["baseline_strength"] < 0.75:
        return "baseline_reference_review"
    if row["uncertainty_communication"] < 0.75:
        return "uncertainty_communication_review"
    if row["governance_readiness"] < 0.75:
        return "governance_readiness_review"
    if row["ecosystem_evidence_quality"] < 0.75:
        return "ecosystem_evidence_quality_review"
    return "routine_monitoring"

def main() -> None:
    df = pd.read_csv(DATA_PATH)
    df["ecosystem_evidence_quality"] = df.apply(ecosystem_evidence_quality, axis=1).round(3)
    df["review_priority"] = df.apply(classify_review_priority, axis=1)

    ranked = df.sort_values(["review_priority", "ecosystem_evidence_quality"])
    output_path = OUTPUT_DIR / "ecosystem_monitoring_readiness_scores.csv"
    ranked.to_csv(output_path, index=False)

    print("Ecosystem monitoring readiness and ecological evidence-quality review")
    print(ranked[[
        "program_id",
        "ecosystem_type",
        "geography",
        "extent_visibility",
        "condition_evidence",
        "structure_evidence",
        "function_evidence",
        "integrity_evidence",
        "resilience_evidence",
        "baseline_strength",
        "uncertainty_communication",
        "governance_readiness",
        "ecosystem_evidence_quality",
        "review_priority"
    ]].to_string(index=False))
    print(f"\nWrote: {output_path}")

if __name__ == "__main__":
    main()
