suppressPackageStartupMessages({
  library(dplyr)
  library(readr)
})

article_dir <- normalizePath(file.path(dirname(sys.frame(1)$ofile), ".."))
data_path <- file.path(article_dir, "data", "edge_readiness_scores.csv")
output_dir <- file.path(article_dir, "outputs")

dir.create(output_dir, showWarnings = FALSE, recursive = TRUE)

edge_components <- read_csv(data_path, show_col_types = FALSE)

edge_summary <- edge_components %>%
  mutate(
    latency_readiness = pmax(0, 1 - pmin(observed_latency_seconds / target_latency_seconds, 1)),
    bandwidth_reduction = pmax(0, pmin(1, 1 - transmitted_data_mb / raw_data_mb)),
    loss_penalty = pmax(0, pmin(1, discarded_without_audit_mb / raw_data_mb)),
    edge_evidence_quality = round(
      0.16 * latency_readiness +
      0.16 * edge_traceability +
      0.16 * retained_context_score +
      0.16 * qc_readiness +
      0.14 * inference_transparency +
      0.14 * decision_fit +
      0.08 * bandwidth_reduction -
      0.12 * loss_penalty,
      3
    ),
    review_priority = case_when(
      high_stakes_use & qc_readiness < 0.80 ~ "high_stakes_qc_review",
      latency_readiness < 0.20 ~ "latency_readiness_review",
      edge_traceability < 0.75 ~ "edge_traceability_review",
      retained_context_score < 0.70 ~ "retained_context_review",
      inference_transparency < 0.75 ~ "inference_transparency_review",
      loss_penalty > 0.30 ~ "loss_policy_review",
      decision_fit < 0.75 ~ "decision_fit_review",
      edge_evidence_quality < 0.75 ~ "edge_quality_review",
      TRUE ~ "routine_monitoring"
    )
  ) %>%
  arrange(review_priority, edge_evidence_quality)

print(edge_summary)

write_csv(
  edge_summary,
  file.path(output_dir, "edge_readiness_summary.csv")
)
