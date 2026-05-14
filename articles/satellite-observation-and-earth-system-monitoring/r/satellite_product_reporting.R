suppressPackageStartupMessages({
  library(dplyr)
  library(readr)
})

article_dir <- normalizePath(file.path(dirname(sys.frame(1)$ofile), ".."))
data_path <- file.path(article_dir, "data", "product_readiness_scores.csv")
output_dir <- file.path(article_dir, "outputs")

dir.create(output_dir, showWarnings = FALSE, recursive = TRUE)

satellite_products <- read_csv(data_path, show_col_types = FALSE)

satellite_summary <- satellite_products %>%
  mutate(
    retrieval_quality = round(
      0.25 * calibration_score +
      0.30 * validation_score +
      0.25 * uncertainty_characterized +
      0.20 * domain_suitability,
      3
    ),
    satellite_evidence_quality = round(
      0.20 * usable_coverage +
      0.22 * retrieval_quality +
      0.18 * continuity_score +
      0.15 * proxy_transparency +
      0.15 * in_situ_validation +
      0.10 * decision_fit,
      3
    ),
    review_priority = case_when(
      high_stakes_use & uncertainty_characterized < 0.80 ~ "high_stakes_uncertainty_review",
      continuity_score < 0.70 ~ "continuity_review",
      proxy_transparency < 0.75 ~ "proxy_transparency_review",
      retrieval_quality < 0.75 ~ "retrieval_quality_review",
      in_situ_validation < 0.70 ~ "validation_review",
      decision_fit < 0.70 ~ "decision_fit_review",
      satellite_evidence_quality < 0.75 ~ "satellite_product_quality_review",
      TRUE ~ "routine_monitoring"
    )
  ) %>%
  arrange(review_priority, satellite_evidence_quality)

print(satellite_summary)

write_csv(
  satellite_summary,
  file.path(output_dir, "satellite_product_readiness_summary.csv")
)
