suppressPackageStartupMessages({
  library(dplyr)
  library(readr)
})

article_dir <- normalizePath(file.path(dirname(sys.frame(1)$ofile), ".."))
data_path <- file.path(article_dir, "data", "indicator_registry.csv")
output_dir <- file.path(article_dir, "outputs")

dir.create(output_dir, showWarnings = FALSE, recursive = TRUE)

indicators <- read_csv(data_path, show_col_types = FALSE)

summary_table <- indicators %>%
  mutate(
    target_gap = if_else(
      baseline_value == target_value,
      0,
      (current_value - target_value) / (baseline_value - target_value)
    ),
    threshold_distance = if_else(
      threshold_value == 0,
      0,
      (threshold_value - current_value) / threshold_value
    ),
    integrity_score = round(
      0.20 * metadata_score +
      0.20 * validation_score +
      0.20 * lineage_score +
      0.20 * uncertainty_score +
      0.20 * conceptual_relevance_score,
      3
    ),
    review_priority = case_when(
      threshold_distance <= 0.10 ~ "threshold_proximity_review",
      integrity_score < 0.70 ~ "indicator_integrity_review",
      material_finding & !corrective_action_taken ~ "feedback_failure_review",
      material_finding & !publicly_reviewable ~ "accountability_review",
      indicator_type == "response" & material_finding ~ "response_outcome_review",
      TRUE ~ "routine_monitoring"
    )
  ) %>%
  arrange(review_priority, threshold_distance, integrity_score)

print(summary_table %>%
  select(
    indicator_id,
    domain,
    indicator_type,
    integrity_score,
    target_gap,
    threshold_distance,
    material_finding,
    corrective_action_taken,
    publicly_reviewable,
    review_priority
  ))

write_csv(
  summary_table,
  file.path(output_dir, "sustainability_indicator_review_summary.csv")
)
