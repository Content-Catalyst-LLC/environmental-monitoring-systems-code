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

def retrieval_quality(row: pd.Series) -> float:
    """Evaluate retrieval quality from calibration, validation, uncertainty, and domain suitability."""
    return (
        0.25 * row["calibration_score"]
        + 0.30 * row["validation_score"]
        + 0.25 * row["uncertainty_characterized"]
        + 0.20 * row["domain_suitability"]
    )

def satellite_evidence_quality(row: pd.Series) -> float:
    """Evaluate satellite product quality as an orbital evidence object."""
    return (
        0.20 * row["usable_coverage"]
        + 0.22 * row["retrieval_quality"]
        + 0.18 * row["continuity_score"]
        + 0.15 * row["proxy_transparency"]
        + 0.15 * row["in_situ_validation"]
        + 0.10 * row["decision_fit"]
    )

def classify_review_priority(row: pd.Series) -> str:
    if as_bool(row["high_stakes_use"]) and row["uncertainty_characterized"] < 0.80:
        return "high_stakes_uncertainty_review"
    if row["continuity_score"] < 0.70:
        return "continuity_review"
    if row["proxy_transparency"] < 0.75:
        return "proxy_transparency_review"
    if row["retrieval_quality"] < 0.75:
        return "retrieval_quality_review"
    if row["in_situ_validation"] < 0.70:
        return "validation_review"
    if row["decision_fit"] < 0.70:
        return "decision_fit_review"
    if row["satellite_evidence_quality"] < 0.75:
        return "satellite_product_quality_review"
    return "routine_monitoring"

def main() -> None:
    df = pd.read_csv(DATA_PATH)
    df["retrieval_quality"] = df.apply(retrieval_quality, axis=1).round(3)
    df["satellite_evidence_quality"] = df.apply(satellite_evidence_quality, axis=1).round(3)
    df["review_priority"] = df.apply(classify_review_priority, axis=1)

    ranked = df.sort_values(["review_priority", "satellite_evidence_quality"])
    output_path = OUTPUT_DIR / "satellite_product_readiness_scores.csv"
    ranked.to_csv(output_path, index=False)

    print("Satellite product readiness and Earth-system evidence review")
    print(ranked[[
        "product_id",
        "domain",
        "sensing_mode",
        "retrieval_quality",
        "satellite_evidence_quality",
        "usable_coverage",
        "continuity_score",
        "proxy_transparency",
        "in_situ_validation",
        "decision_fit",
        "review_priority"
    ]].to_string(index=False))
    print(f"\nWrote: {output_path}")

if __name__ == "__main__":
    main()
