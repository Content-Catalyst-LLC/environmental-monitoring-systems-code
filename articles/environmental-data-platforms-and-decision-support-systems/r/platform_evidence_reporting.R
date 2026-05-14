suppressPackageStartupMessages({
  library(dplyr)
  library(readr)
})

article_dir <- normalizePath(file.path(dirname(sys.frame(1)$ofile), ".."))
data_path <- file.path(article_dir, "data", "platform_assets.csv")
output_dir <- file.path(article_dir, "outputs")

dir.create(output_dir, showWarnings = FALSE, recursive = TRUE)

platform_assets <- read_csv(data_path, show_col_types = FALSE)

platform_summary <- platform_assets %>%
  mutate(
    platform_evidence_quality = round(
      0.22 * metadata_complete +
      0.20 * semantic_compatibility +
      0.22 * lineage_complete +
      0.18 * uncertainty_visible +
      0.18 * decision_fit,
      3
    ),
    review_priority = case_when(
      is_high_stakes & lineage_complete < 0.85 ~ "high_stakes_lineage_review",
      metadata_complete < 0.75 ~ "metadata_completeness_review",
      semantic_compatibility < 0.70 ~ "semantic_integration_review",
      uncertainty_visible < 0.70 ~ "uncertainty_visibility_review",
      decision_fit < 0.70 ~ "decision_support_fit_review",
      platform_evidence_quality < 0.75 ~ "platform_quality_review",
      TRUE ~ "routine_monitoring"
    )
  ) %>%
  arrange(review_priority, platform_evidence_quality)

print(platform_summary)

write_csv(
  platform_summary,
  file.path(output_dir, "platform_evidence_quality_summary.csv")
)
