suppressPackageStartupMessages({
  library(dplyr)
  library(readr)
})

args <- commandArgs(trailingOnly = FALSE)
file_arg <- "--file="
script_path <- sub(file_arg, "", args[grep(file_arg, args)])
article_dir <- normalizePath(file.path(dirname(script_path), ".."))
data_path <- file.path(article_dir, "data", "land_monitoring_readiness_scores.csv")
output_dir <- file.path(article_dir, "outputs")

dir.create(output_dir, showWarnings = FALSE, recursive = TRUE)

land_products <- read_csv(data_path, show_col_types = FALSE)

land_summary <- land_products %>%
  mutate(
    change_confidence = pmax(0, pmin(1, validated_change_samples / detected_change_samples)),
    land_evidence_quality = round(
      0.16 * classification_accuracy +
      0.14 * temporal_consistency +
      0.14 * change_confidence +
      0.14 * reference_data_strength +
      0.12 * condition_sensitivity +
      0.10 * fragmentation_visibility +
      0.10 * uncertainty_communication +
      0.10 * reporting_readiness,
      3
    ),
    review_priority = case_when(
      high_stakes_use & classification_accuracy < 0.80 ~ "high_stakes_accuracy_review",
      temporal_consistency < 0.75 ~ "temporal_consistency_review",
      change_confidence < 0.75 ~ "change_validation_review",
      reference_data_strength < 0.75 ~ "reference_data_review",
      condition_sensitivity < 0.70 ~ "condition_monitoring_review",
      fragmentation_visibility < 0.70 ~ "fragmentation_visibility_review",
      uncertainty_communication < 0.75 ~ "uncertainty_communication_review",
      reporting_readiness < 0.75 ~ "reporting_readiness_review",
      land_evidence_quality < 0.75 ~ "land_evidence_quality_review",
      TRUE ~ "routine_monitoring"
    )
  ) %>%
  arrange(review_priority, land_evidence_quality)

print(land_summary)

write_csv(
  land_summary,
  file.path(output_dir, "land_monitoring_readiness_summary.csv")
)
