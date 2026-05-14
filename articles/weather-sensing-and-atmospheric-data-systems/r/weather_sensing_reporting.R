suppressPackageStartupMessages({
  library(dplyr)
  library(readr)
})

args <- commandArgs(trailingOnly = FALSE)
file_arg <- "--file="
script_path <- sub(file_arg, "", args[grep(file_arg, args)])
article_dir <- normalizePath(file.path(dirname(script_path), ".."))

readiness_path <- file.path(article_dir, "data", "weather_sensing_readiness_scores.csv")
latency_path <- file.path(article_dir, "data", "telemetry_latency_log.csv")
assimilation_path <- file.path(article_dir, "data", "assimilation_readiness_records.csv")
audit_path <- file.path(article_dir, "data", "coverage_blindspot_audit.csv")
output_dir <- file.path(article_dir, "outputs")

dir.create(output_dir, showWarnings = FALSE, recursive = TRUE)

programs <- read_csv(readiness_path, show_col_types = FALSE)

readiness_summary <- programs %>%
  mutate(
    weather_evidence_quality = round(
      0.15 * observation_freshness +
      0.13 * spatial_coverage +
      0.13 * vertical_coverage +
      0.14 * qc_completeness +
      0.14 * assimilation_readiness +
      0.11 * representativeness +
      0.10 * uncertainty_communication +
      0.10 * governance_readiness,
      3
    ),
    review_priority = case_when(
      high_stakes_use & observation_freshness < 0.75 ~ "high_stakes_latency_review",
      spatial_coverage < 0.70 ~ "spatial_coverage_review",
      vertical_coverage < 0.70 ~ "vertical_coverage_review",
      qc_completeness < 0.75 ~ "quality_control_review",
      assimilation_readiness < 0.75 ~ "assimilation_readiness_review",
      representativeness < 0.70 ~ "representativeness_review",
      uncertainty_communication < 0.75 ~ "uncertainty_communication_review",
      governance_readiness < 0.75 ~ "governance_readiness_review",
      weather_evidence_quality < 0.75 ~ "weather_evidence_quality_review",
      TRUE ~ "routine_monitoring"
    )
  ) %>%
  arrange(review_priority, weather_evidence_quality)

print(readiness_summary)
write_csv(readiness_summary, file.path(output_dir, "weather_sensing_readiness_summary.csv"))

latency <- read_csv(latency_path, show_col_types = FALSE) %>%
  mutate(fresh_report_ratio = round(received_reports / expected_reports, 3)) %>%
  arrange(freshness_status, fresh_report_ratio)

print(latency)
write_csv(latency, file.path(output_dir, "weather_sensing_latency_summary.csv"))

assimilation <- read_csv(assimilation_path, show_col_types = FALSE) %>%
  mutate(
    metadata_complete = metadata_complete %in% c(TRUE, "true", "TRUE", "1", 1),
    qc_passed = qc_passed %in% c(TRUE, "true", "TRUE", "1", 1),
    latency_within_budget = latency_within_budget %in% c(TRUE, "true", "TRUE", "1", 1),
    format_supported = format_supported %in% c(TRUE, "true", "TRUE", "1", 1),
    error_model_available = error_model_available %in% c(TRUE, "true", "TRUE", "1", 1),
    assimilable = assimilable %in% c(TRUE, "true", "TRUE", "1", 1)
  ) %>%
  group_by(platform_id) %>%
  summarise(
    observations = n(),
    assimilable_observations = sum(assimilable),
    metadata_complete = sum(metadata_complete),
    qc_passed = sum(qc_passed),
    latency_within_budget = sum(latency_within_budget),
    assimilation_ready_ratio = round(assimilable_observations / observations, 3),
    .groups = "drop"
  ) %>%
  arrange(assimilation_ready_ratio)

print(assimilation)
write_csv(assimilation, file.path(output_dir, "weather_sensing_assimilation_summary.csv"))

coverage <- read_csv(audit_path, show_col_types = FALSE) %>%
  arrange(priority, coverage_score)

print(coverage)
write_csv(coverage, file.path(output_dir, "weather_sensing_coverage_gap_summary.csv"))
