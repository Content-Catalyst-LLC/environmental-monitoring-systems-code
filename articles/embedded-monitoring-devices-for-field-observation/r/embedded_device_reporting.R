suppressPackageStartupMessages({
  library(dplyr)
  library(readr)
})

args <- commandArgs(trailingOnly = FALSE)
file_arg <- "--file="
script_path <- sub(file_arg, "", args[grep(file_arg, args)])
article_dir <- normalizePath(file.path(dirname(script_path), ".."))
data_path <- file.path(article_dir, "data", "embedded_device_readiness_scores.csv")
output_dir <- file.path(article_dir, "outputs")

dir.create(output_dir, showWarnings = FALSE, recursive = TRUE)

embedded_devices <- read_csv(data_path, show_col_types = FALSE)

device_summary <- embedded_devices %>%
  mutate(
    device_availability = pmax(0, pmin(1, valid_operation_hours / deployment_hours)),
    record_completeness = pmax(0, pmin(1, valid_records / expected_records)),
    power_margin_score = pmax(0, pmin(1, 0.5 + ((energy_available_wh - energy_required_wh) / energy_required_wh))),
    timing_consistency = pmax(0, 1 - pmin(abs(clock_drift_seconds) / allowed_clock_drift_seconds, 1)),
    field_evidence_quality = round(
      0.16 * device_availability +
      0.16 * record_completeness +
      0.14 * power_margin_score +
      0.16 * calibration_validity +
      0.12 * timing_consistency +
      0.14 * qc_readiness +
      0.12 * health_visibility +
      0.10 * decision_fit,
      3
    ),
    review_priority = case_when(
      high_stakes_use & calibration_validity < 0.80 ~ "high_stakes_calibration_review",
      device_availability < 0.75 ~ "device_availability_review",
      record_completeness < 0.80 ~ "record_completeness_review",
      power_margin_score < 0.50 ~ "power_budget_review",
      timing_consistency < 0.75 ~ "timing_integrity_review",
      qc_readiness < 0.75 ~ "qaqc_readiness_review",
      health_visibility < 0.75 ~ "device_health_visibility_review",
      decision_fit < 0.75 ~ "decision_fit_review",
      field_evidence_quality < 0.75 ~ "field_evidence_quality_review",
      TRUE ~ "routine_monitoring"
    )
  ) %>%
  arrange(review_priority, field_evidence_quality)

print(device_summary)

write_csv(
  device_summary,
  file.path(output_dir, "embedded_device_readiness_summary.csv")
)
