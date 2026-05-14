suppressPackageStartupMessages({
  library(dplyr)
  library(readr)
})

args <- commandArgs(trailingOnly = FALSE)
file_arg <- "--file="
script_path <- sub(file_arg, "", args[grep(file_arg, args)])
article_dir <- normalizePath(file.path(dirname(script_path), ".."))

readiness_path <- file.path(article_dir, "data", "early_warning_readiness_scores.csv")
warning_path <- file.path(article_dir, "data", "warning_decision_log.csv")
channel_path <- file.path(article_dir, "data", "communication_channel_registry.csv")
audit_path <- file.path(article_dir, "data", "coverage_inclusion_audit.csv")
output_dir <- file.path(article_dir, "outputs")

dir.create(output_dir, showWarnings = FALSE, recursive = TRUE)

programs <- read_csv(readiness_path, show_col_types = FALSE)

readiness_summary <- programs %>%
  mutate(
    early_warning_quality = round(
      0.14 * forecast_confidence +
      0.14 * risk_knowledge +
      0.14 * protective_lead_time +
      0.13 * communication_reach +
      0.13 * action_capacity +
      0.10 * trust_readiness +
      0.11 * inclusion_capacity +
      0.11 * governance_readiness,
      3
    ),
    review_priority = case_when(
      high_stakes_use & protective_lead_time < 0.70 ~ "high_stakes_lead_time_review",
      forecast_confidence < 0.70 ~ "forecast_confidence_review",
      risk_knowledge < 0.70 ~ "risk_knowledge_review",
      communication_reach < 0.75 ~ "communication_reach_review",
      action_capacity < 0.75 ~ "action_capacity_review",
      trust_readiness < 0.70 ~ "trust_readiness_review",
      inclusion_capacity < 0.75 ~ "inclusion_capacity_review",
      governance_readiness < 0.75 ~ "governance_readiness_review",
      early_warning_quality < 0.75 ~ "early_warning_quality_review",
      TRUE ~ "routine_monitoring"
    )
  ) %>%
  arrange(review_priority, early_warning_quality)

print(readiness_summary)
write_csv(readiness_summary, file.path(output_dir, "early_warning_readiness_summary.csv"))

warnings <- read_csv(warning_path, show_col_types = FALSE)

lead_time_summary <- warnings %>%
  group_by(program_id, hazard_type, warning_level) %>%
  summarise(
    warnings = n(),
    mean_protective_lead_time_hours = round(mean(protective_lead_time_hours, na.rm = TRUE), 3),
    min_protective_lead_time_hours = round(min(protective_lead_time_hours, na.rm = TRUE), 3),
    .groups = "drop"
  )

print(lead_time_summary)
write_csv(lead_time_summary, file.path(output_dir, "early_warning_lead_time_summary.csv"))

channels <- read_csv(channel_path, show_col_types = FALSE)

channel_summary <- channels %>%
  mutate(fallback_bool = fallback_available %in% c(TRUE, "true", "TRUE", "1", 1)) %>%
  group_by(program_id) %>%
  summarise(
    channels = n(),
    mean_coverage = round(mean(coverage_estimate, na.rm = TRUE), 3),
    fallback_channels = sum(fallback_bool),
    review_channels = sum(status != "active"),
    .groups = "drop"
  )

print(channel_summary)
write_csv(channel_summary, file.path(output_dir, "early_warning_channel_coverage_summary.csv"))

inclusion <- read_csv(audit_path, show_col_types = FALSE) %>%
  arrange(priority, coverage_score)

print(inclusion)
write_csv(inclusion, file.path(output_dir, "early_warning_inclusion_gap_summary.csv"))
