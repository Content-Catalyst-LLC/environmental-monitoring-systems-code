suppressPackageStartupMessages({
  library(dplyr)
  library(readr)
})

article_dir <- normalizePath(file.path(dirname(sys.frame(1)$ofile), ".."))
data_path <- file.path(article_dir, "data", "iot_architecture_readiness_scores.csv")
output_dir <- file.path(article_dir, "outputs")
dir.create(output_dir, showWarnings = FALSE, recursive = TRUE)

iot_components <- read_csv(data_path, show_col_types = FALSE)

iot_summary <- iot_components %>%
  mutate(
    latency_penalty = pmin(pmax((end_to_end_latency_minutes / target_latency_minutes) - 1, 0), 1),
    iot_evidence_quality = round(
      0.18 * device_availability +
      0.18 * delivery_completeness +
      0.18 * semantic_completeness +
      0.16 * qc_readiness +
      0.14 * edge_traceability +
      0.16 * decision_fit -
      0.10 * latency_penalty,
      3
    ),
    review_priority = case_when(
      high_stakes_use & qc_readiness < 0.80 ~ "high_stakes_qc_review",
      device_availability < 0.75 ~ "device_reliability_review",
      delivery_completeness < 0.80 ~ "connectivity_delivery_review",
      semantic_completeness < 0.80 ~ "semantic_completeness_review",
      edge_traceability < 0.75 ~ "edge_traceability_review",
      end_to_end_latency_minutes > target_latency_minutes ~ "latency_review",
      decision_fit < 0.75 ~ "decision_fit_review",
      iot_evidence_quality < 0.75 ~ "architecture_quality_review",
      TRUE ~ "routine_monitoring"
    )
  ) %>%
  arrange(review_priority, iot_evidence_quality)

print(iot_summary)
write_csv(iot_summary, file.path(output_dir, "iot_architecture_readiness_summary.csv"))
