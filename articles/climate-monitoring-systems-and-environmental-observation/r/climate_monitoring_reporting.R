suppressPackageStartupMessages({
  library(dplyr)
  library(readr)
})

args <- commandArgs(trailingOnly = FALSE)
file_arg <- "--file="
script_path <- sub(file_arg, "", args[grep(file_arg, args)])
article_dir <- normalizePath(file.path(dirname(script_path), ".."))

readiness_path <- file.path(article_dir, "data", "climate_monitoring_readiness_scores.csv")
indicator_path <- file.path(article_dir, "data", "climate_indicator_anomaly_table.csv")
audit_path <- file.path(article_dir, "data", "coverage_continuity_audit.csv")
adjustment_path <- file.path(article_dir, "data", "homogenization_adjustment_log.csv")
output_dir <- file.path(article_dir, "outputs")

dir.create(output_dir, showWarnings = FALSE, recursive = TRUE)

programs <- read_csv(readiness_path, show_col_types = FALSE)

readiness_summary <- programs %>%
  mutate(
    climate_record_quality = round(
      0.15 * record_continuity +
      0.13 * metadata_completeness +
      0.14 * calibration_quality +
      0.13 * homogenization_readiness +
      0.13 * spatial_coverage +
      0.11 * version_control +
      0.10 * uncertainty_communication +
      0.11 * governance_readiness,
      3
    ),
    review_priority = case_when(
      high_stakes_use & record_continuity < 0.75 ~ "high_stakes_record_continuity_review",
      metadata_completeness < 0.75 ~ "metadata_completeness_review",
      calibration_quality < 0.75 ~ "calibration_quality_review",
      homogenization_readiness < 0.75 ~ "homogenization_readiness_review",
      spatial_coverage < 0.70 ~ "spatial_coverage_review",
      version_control < 0.75 ~ "version_control_review",
      uncertainty_communication < 0.75 ~ "uncertainty_communication_review",
      governance_readiness < 0.75 ~ "governance_readiness_review",
      climate_record_quality < 0.75 ~ "climate_record_quality_review",
      TRUE ~ "routine_monitoring"
    )
  ) %>%
  arrange(review_priority, climate_record_quality)

print(readiness_summary)
write_csv(readiness_summary, file.path(output_dir, "climate_monitoring_readiness_summary.csv"))

indicators <- read_csv(indicator_path, show_col_types = FALSE) %>%
  mutate(trend_ready_bool = trend_ready %in% c(TRUE, "true", "TRUE", "1", 1))

indicator_summary <- indicators %>%
  group_by(record_id, climate_variable) %>%
  summarise(
    records = n(),
    mean_anomaly = round(mean(anomaly, na.rm = TRUE), 3),
    max_anomaly = round(max(anomaly, na.rm = TRUE), 3),
    trend_ready_records = sum(trend_ready_bool),
    .groups = "drop"
  )

print(indicator_summary)
write_csv(indicator_summary, file.path(output_dir, "climate_indicator_anomaly_summary.csv"))

coverage <- read_csv(audit_path, show_col_types = FALSE) %>%
  arrange(priority, coverage_score)

print(coverage)
write_csv(coverage, file.path(output_dir, "climate_monitoring_coverage_gap_summary.csv"))

adjustments <- read_csv(adjustment_path, show_col_types = FALSE) %>%
  group_by(platform_id, climate_variable, status) %>%
  summarise(
    adjustments = n(),
    review_items = sum(status != "pass"),
    .groups = "drop"
  )

print(adjustments)
write_csv(adjustments, file.path(output_dir, "climate_homogenization_adjustment_summary.csv"))
