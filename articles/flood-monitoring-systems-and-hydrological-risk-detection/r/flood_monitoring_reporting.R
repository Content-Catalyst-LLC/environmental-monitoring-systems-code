suppressPackageStartupMessages({
  library(dplyr)
  library(readr)
})

args <- commandArgs(trailingOnly = FALSE)
file_arg <- "--file="
script_path <- sub(file_arg, "", args[grep(file_arg, args)])
article_dir <- normalizePath(file.path(dirname(script_path), ".."))
data_path <- file.path(article_dir, "data", "flood_monitoring_readiness_scores.csv")
output_dir <- file.path(article_dir, "outputs")

dir.create(output_dir, showWarnings = FALSE, recursive = TRUE)

flood_programs <- read_csv(data_path, show_col_types = FALSE)

flood_summary <- flood_programs %>%
  mutate(
    flood_warning_quality = round(
      0.12 * gauge_coverage +
      0.11 * rainfall_coverage +
      0.12 * telemetry_completeness +
      0.12 * forecast_confidence +
      0.11 * inundation_map_readiness +
      0.12 * protective_lead_time +
      0.10 * communication_readiness +
      0.10 * response_capacity +
      0.10 * governance_readiness,
      3
    ),
    review_priority = case_when(
      high_stakes_use & telemetry_completeness < 0.80 ~ "high_stakes_telemetry_review",
      gauge_coverage < 0.70 ~ "gauge_coverage_review",
      rainfall_coverage < 0.70 ~ "rainfall_coverage_review",
      forecast_confidence < 0.70 ~ "forecast_confidence_review",
      inundation_map_readiness < 0.70 ~ "inundation_mapping_review",
      protective_lead_time < 0.70 ~ "lead_time_review",
      communication_readiness < 0.75 ~ "communication_readiness_review",
      response_capacity < 0.75 ~ "response_capacity_review",
      governance_readiness < 0.75 ~ "governance_readiness_review",
      flood_warning_quality < 0.75 ~ "flood_warning_quality_review",
      TRUE ~ "routine_monitoring"
    )
  ) %>%
  arrange(review_priority, flood_warning_quality)

print(flood_summary)

write_csv(
  flood_summary,
  file.path(output_dir, "flood_monitoring_readiness_summary.csv")
)
