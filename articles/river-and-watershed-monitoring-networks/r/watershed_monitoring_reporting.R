suppressPackageStartupMessages({
  library(dplyr)
  library(readr)
})

args <- commandArgs(trailingOnly = FALSE)
file_arg <- "--file="
script_path <- sub(file_arg, "", args[grep(file_arg, args)])
article_dir <- normalizePath(file.path(dirname(script_path), ".."))
readiness_path <- file.path(article_dir, "data", "watershed_monitoring_readiness_scores.csv")
load_path <- file.path(article_dir, "data", "water_quality_load_records.csv")
output_dir <- file.path(article_dir, "outputs")

dir.create(output_dir, showWarnings = FALSE, recursive = TRUE)

watershed_networks <- read_csv(readiness_path, show_col_types = FALSE)

watershed_summary <- watershed_networks %>%
  mutate(
    watershed_evidence_quality = round(
      0.12 * gauge_coverage +
      0.12 * water_quality_coverage +
      0.10 * ecological_coverage +
      0.13 * network_representativeness +
      0.12 * temporal_continuity +
      0.12 * event_capture +
      0.09 * uncertainty_communication +
      0.10 * interoperability +
      0.10 * governance_readiness,
      3
    ),
    review_priority = case_when(
      high_stakes_use & network_representativeness < 0.70 ~ "high_stakes_representativeness_review",
      gauge_coverage < 0.70 ~ "gauge_coverage_review",
      water_quality_coverage < 0.70 ~ "water_quality_coverage_review",
      ecological_coverage < 0.65 ~ "ecological_coverage_review",
      temporal_continuity < 0.70 ~ "temporal_continuity_review",
      event_capture < 0.70 ~ "event_capture_review",
      interoperability < 0.75 ~ "interoperability_review",
      governance_readiness < 0.75 ~ "governance_readiness_review",
      watershed_evidence_quality < 0.75 ~ "watershed_evidence_quality_review",
      TRUE ~ "routine_monitoring"
    )
  ) %>%
  arrange(review_priority, watershed_evidence_quality)

print(watershed_summary)

write_csv(
  watershed_summary,
  file.path(output_dir, "watershed_monitoring_readiness_summary.csv")
)

loads <- read_csv(load_path, show_col_types = FALSE)

load_summary <- loads %>%
  group_by(station_id, constituent, event_flag) %>%
  summarise(
    records = n(),
    mean_concentration_mg_L = mean(concentration_mg_L, na.rm = TRUE),
    total_instantaneous_load_kg_day = sum(instantaneous_load_kg_day, na.rm = TRUE),
    review_records = sum(quality_flag != "pass"),
    .groups = "drop"
  )

print(load_summary)

write_csv(
  load_summary,
  file.path(output_dir, "watershed_load_summary.csv")
)
