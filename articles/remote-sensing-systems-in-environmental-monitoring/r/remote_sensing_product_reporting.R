suppressPackageStartupMessages({
  library(dplyr)
  library(readr)
})

article_dir <- normalizePath(file.path(dirname(sys.frame(1)$ofile), ".."))
data_path <- file.path(article_dir, "data", "product_readiness_scores.csv")
output_dir <- file.path(article_dir, "outputs")

dir.create(output_dir, showWarnings = FALSE, recursive = TRUE)

remote_products <- read_csv(data_path, show_col_types = FALSE)

remote_summary <- remote_products %>%
  mutate(
    inference_quality = round(
      0.25 * correction_quality +
      0.30 * validation_score +
      0.25 * uncertainty_characterized +
      0.20 * domain_suitability,
      3
    ),
    remote_evidence_quality = round(
      0.20 * valid_coverage +
      0.22 * inference_quality +
      0.18 * time_series_continuity +
      0.15 * proxy_transparency +
      0.15 * field_validation +
      0.10 * decision_fit,
      3
    ),
    review_priority = case_when(
      high_stakes_use & uncertainty_characterized < 0.80 ~ "high_stakes_uncertainty_review",
      valid_coverage < 0.70 ~ "valid_coverage_review",
      proxy_transparency < 0.75 ~ "proxy_transparency_review",
      inference_quality < 0.75 ~ "inference_quality_review",
      field_validation < 0.70 ~ "field_validation_review",
      time_series_continuity < 0.70 ~ "time_series_continuity_review",
      decision_fit < 0.70 ~ "decision_fit_review",
      remote_evidence_quality < 0.75 ~ "remote_sensing_product_quality_review",
      TRUE ~ "routine_monitoring"
    )
  ) %>%
  arrange(review_priority, remote_evidence_quality)

print(remote_summary)

write_csv(
  remote_summary,
  file.path(output_dir, "remote_sensing_product_readiness_summary.csv")
)
