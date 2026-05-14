from pathlib import Path
import pandas as pd

ARTICLE_DIR = Path(__file__).resolve().parents[1]
DATA_PATH = ARTICLE_DIR / "data" / "product_readiness_scores.csv"
OUTPUT_DIR = ARTICLE_DIR / "outputs"
OUTPUT_DIR.mkdir(exist_ok=True)

def as_bool(value) -> bool:
    if isinstance(value, bool):
        return value
    return str(value).strip().lower() in {"true", "1", "yes", "y"}

def inference_quality(row: pd.Series) -> float:
    """Evaluate inference quality from correction, validation, uncertainty, and domain suitability."""
    return (
        0.25 * row["correction_quality"]
        + 0.30 * row["validation_score"]
        + 0.25 * row["uncertainty_characterized"]
        + 0.20 * row["domain_suitability"]
    )

def remote_evidence_quality(row: pd.Series) -> float:
    """Evaluate remote-sensing product quality as a signal-to-claim evidence object."""
    return (
        0.20 * row["valid_coverage"]
        + 0.22 * row["inference_quality"]
        + 0.18 * row["time_series_continuity"]
        + 0.15 * row["proxy_transparency"]
        + 0.15 * row["field_validation"]
        + 0.10 * row["decision_fit"]
    )

def classify_review_priority(row: pd.Series) -> str:
    if as_bool(row["high_stakes_use"]) and row["uncertainty_characterized"] < 0.80:
        return "high_stakes_uncertainty_review"
    if row["valid_coverage"] < 0.70:
        return "valid_coverage_review"
    if row["proxy_transparency"] < 0.75:
        return "proxy_transparency_review"
    if row["inference_quality"] < 0.75:
        return "inference_quality_review"
    if row["field_validation"] < 0.70:
        return "field_validation_review"
    if row["time_series_continuity"] < 0.70:
        return "time_series_continuity_review"
    if row["decision_fit"] < 0.70:
        return "decision_fit_review"
    if row["remote_evidence_quality"] < 0.75:
        return "remote_sensing_product_quality_review"
    return "routine_monitoring"

def main() -> None:
    df = pd.read_csv(DATA_PATH)
    df["inference_quality"] = df.apply(inference_quality, axis=1).round(3)
    df["remote_evidence_quality"] = df.apply(remote_evidence_quality, axis=1).round(3)
    df["review_priority"] = df.apply(classify_review_priority, axis=1)

    ranked = df.sort_values(["review_priority", "remote_evidence_quality"])
    output_path = OUTPUT_DIR / "remote_sensing_product_readiness_scores.csv"
    ranked.to_csv(output_path, index=False)

    print("Remote-sensing product readiness and evidence review")
    print(ranked[[
        "product_id",
        "domain",
        "sensing_mode",
        "inference_quality",
        "remote_evidence_quality",
        "valid_coverage",
        "time_series_continuity",
        "proxy_transparency",
        "field_validation",
        "decision_fit",
        "review_priority"
    ]].to_string(index=False))
    print(f"\nWrote: {output_path}")

if __name__ == "__main__":
    main()
