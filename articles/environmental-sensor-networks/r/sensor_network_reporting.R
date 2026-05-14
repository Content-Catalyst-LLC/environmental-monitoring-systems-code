suppressPackageStartupMessages({
  library(dplyr)
  library(readr)
})

args <- commandArgs(trailingOnly = FALSE)
file_arg <- "--file="
script_path <- sub(file_arg, "", args[grep(file_arg, args)])
article_dir <- normalizePath(file.path(dirname(script_path), ".."))
data_path <- file.path(article_dir, "data", "network_readiness_scores.csv")
output_dir <- file.path(article_dir, "outputs")

dir.create(output_dir, showWarnings = FALSE, recursive = TRUE)

sensor_networks <- read_csv(data_path, show_col_types = FALSE)

network_summary <- sensor_networks %>%
  mutate(
    spatial_coverage = pmax(0, pmin(1, monitored_area_km2 / target_area_km2)),
    temporal_completeness = pmax(0, pmin(1, valid_time_steps / expected_time_steps)),
    network_availability = pmax(0, pmin(1, active_nodes / deployed_nodes)),
    latency_readiness = pmax(0, 1 - pmin(observed_latency_minutes / target_latency_minutes, 1)),
    network_evidence_quality = round(
      0.14 * spatial_coverage +
      0.14 * temporal_completeness +
      0.14 * network_availability +
      0.14 * representativeness +
      0.14 * valid_data_share +
      0.12 * metadata_maturity +
      0.10 * latency_readiness +
      0.08 * action_fit,
      3
    ),
    review_priority = case_when(
      high_stakes_use & valid_data_share < 0.80 ~ "high_stakes_quality_review",
      spatial_coverage < 0.70 ~ "coverage_review",
      temporal_completeness < 0.80 ~ "temporal_completeness_review",
      network_availability < 0.80 ~ "node_availability_review",
      representativeness < 0.75 ~ "representativeness_review",
      metadata_maturity < 0.75 ~ "metadata_interoperability_review",
      latency_readiness < 0.25 ~ "latency_readiness_review",
      action_fit < 0.75 ~ "action_fit_review",
      network_evidence_quality < 0.75 ~ "network_evidence_quality_review",
      TRUE ~ "routine_monitoring"
    )
  ) %>%
  arrange(review_priority, network_evidence_quality)

print(network_summary)

write_csv(
  network_summary,
  file.path(output_dir, "sensor_network_readiness_summary.csv")
)
