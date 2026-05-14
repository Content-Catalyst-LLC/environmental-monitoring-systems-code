suppressPackageStartupMessages({
  library(dplyr)
  library(readr)
})

args <- commandArgs(trailingOnly = FALSE)
file_arg <- "--file="
script_path <- sub(file_arg, "", args[grep(file_arg, args)])
article_dir <- normalizePath(file.path(dirname(script_path), ".."))
data_path <- file.path(article_dir, "data", "smart_water_readiness_scores.csv")
output_dir <- file.path(article_dir, "outputs")

dir.create(output_dir, showWarnings = FALSE, recursive = TRUE)

programs <- read_csv(data_path, show_col_types = FALSE)

summary <- programs %>%
  mutate(
    smart_water_quality = round(
      0.11 * sensing_coverage +
      0.13 * data_quality_validity +
      0.12 * telemetry_completeness +
      0.10 * latency_readiness +
      0.10 * anomaly_confidence +
      0.13 * response_capacity +
      0.10 * model_readiness +
      0.10 * control_safety +
      0.11 * governance_readiness,
      3
    ),
    review_priority = case_when(
      high_stakes_use & data_quality_validity < 0.75 ~ "high_stakes_data_quality_review",
      telemetry_completeness < 0.80 ~ "telemetry_completeness_review",
      response_capacity < 0.75 ~ "response_capacity_review",
      control_safety < 0.75 ~ "control_safety_review",
      model_readiness < 0.70 ~ "model_readiness_review",
      governance_readiness < 0.75 ~ "governance_readiness_review",
      smart_water_quality < 0.75 ~ "smart_water_quality_review",
      TRUE ~ "routine_monitoring"
    )
  ) %>%
  arrange(review_priority, smart_water_quality)

print(summary)
write_csv(summary, file.path(output_dir, "smart_water_readiness_summary.csv"))
