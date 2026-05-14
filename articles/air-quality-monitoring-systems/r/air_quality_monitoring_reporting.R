suppressPackageStartupMessages({
  library(dplyr)
  library(readr)
})

args <- commandArgs(trailingOnly = FALSE)
file_arg <- "--file="
script_path <- sub(file_arg, "", args[grep(file_arg, args)])
article_dir <- normalizePath(file.path(dirname(script_path), ".."))

readiness_path <- file.path(article_dir, "data", "air_quality_monitoring_readiness_scores.csv")
obs_path <- file.path(article_dir, "data", "pollutant_observation_records.csv")
cal_path <- file.path(article_dir, "data", "calibration_collocation_log.csv")
exposure_path <- file.path(article_dir, "data", "exposure_equity_layer.csv")
output_dir <- file.path(article_dir, "outputs")

dir.create(output_dir, showWarnings = FALSE, recursive = TRUE)

programs <- read_csv(readiness_path, show_col_types = FALSE)

readiness_summary <- programs %>%
  mutate(
    air_evidence_quality = round(
      0.15 * calibration_quality +
      0.14 * data_completeness +
      0.13 * spatial_coverage +
      0.12 * temporal_coverage +
      0.12 * meteorological_context +
      0.13 * exposure_relevance +
      0.10 * uncertainty_communication +
      0.11 * governance_readiness,
      3
    ),
    review_priority = case_when(
      high_stakes_use & calibration_quality < 0.75 ~ "high_stakes_calibration_review",
      data_completeness < 0.75 ~ "data_completeness_review",
      spatial_coverage < 0.70 ~ "spatial_coverage_review",
      temporal_coverage < 0.75 ~ "temporal_coverage_review",
      meteorological_context < 0.70 ~ "meteorological_context_review",
      exposure_relevance < 0.70 ~ "exposure_relevance_review",
      uncertainty_communication < 0.75 ~ "uncertainty_communication_review",
      governance_readiness < 0.75 ~ "governance_readiness_review",
      air_evidence_quality < 0.75 ~ "air_evidence_quality_review",
      TRUE ~ "routine_monitoring"
    )
  ) %>%
  arrange(review_priority, air_evidence_quality)

print(readiness_summary)
write_csv(readiness_summary, file.path(output_dir, "air_quality_monitoring_readiness_summary.csv"))

pollutants <- read_csv(obs_path, show_col_types = FALSE) %>%
  group_by(pollutant, unit) %>%
  summarise(
    observations = n(),
    mean_value = round(mean(value, na.rm = TRUE), 3),
    max_value = round(max(value, na.rm = TRUE), 3),
    review_required = sum(qc_flag != "pass"),
    .groups = "drop"
  ) %>%
  arrange(desc(review_required), pollutant)

print(pollutants)
write_csv(pollutants, file.path(output_dir, "air_quality_pollutant_summary.csv"))

calibration <- read_csv(cal_path, show_col_types = FALSE) %>%
  group_by(sensor_id, status) %>%
  summarise(
    calibration_events = n(),
    review_items = sum(status != "pass"),
    .groups = "drop"
  ) %>%
  arrange(desc(review_items), sensor_id)

print(calibration)
write_csv(calibration, file.path(output_dir, "air_quality_calibration_summary.csv"))

exposure <- read_csv(exposure_path, show_col_types = FALSE) %>%
  arrange(priority, monitoring_coverage_score)

print(exposure)
write_csv(exposure, file.path(output_dir, "air_quality_exposure_equity_summary.csv"))
