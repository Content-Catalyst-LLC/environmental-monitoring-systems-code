suppressPackageStartupMessages({
  library(dplyr)
  library(readr)
})

args <- commandArgs(trailingOnly = FALSE)
file_arg <- "--file="
script_path <- sub(file_arg, "", args[grep(file_arg, args)])
article_dir <- normalizePath(file.path(dirname(script_path), ".."))
data_path <- file.path(article_dir, "data", "ecosystem_monitoring_readiness_scores.csv")
output_dir <- file.path(article_dir, "outputs")

dir.create(output_dir, showWarnings = FALSE, recursive = TRUE)

ecosystem_programs <- read_csv(data_path, show_col_types = FALSE)

ecosystem_summary <- ecosystem_programs %>%
  mutate(
    ecosystem_evidence_quality = round(
      0.11 * extent_visibility +
      0.14 * condition_evidence +
      0.11 * structure_evidence +
      0.12 * function_evidence +
      0.13 * integrity_evidence +
      0.12 * resilience_evidence +
      0.10 * baseline_strength +
      0.08 * uncertainty_communication +
      0.09 * governance_readiness,
      3
    ),
    review_priority = case_when(
      high_stakes_use & condition_evidence < 0.75 ~ "high_stakes_condition_review",
      extent_visibility < 0.70 ~ "extent_visibility_review",
      condition_evidence < 0.75 ~ "condition_evidence_review",
      function_evidence < 0.70 ~ "function_evidence_review",
      integrity_evidence < 0.70 ~ "integrity_evidence_review",
      resilience_evidence < 0.70 ~ "resilience_evidence_review",
      baseline_strength < 0.75 ~ "baseline_reference_review",
      uncertainty_communication < 0.75 ~ "uncertainty_communication_review",
      governance_readiness < 0.75 ~ "governance_readiness_review",
      ecosystem_evidence_quality < 0.75 ~ "ecosystem_evidence_quality_review",
      TRUE ~ "routine_monitoring"
    )
  ) %>%
  arrange(review_priority, ecosystem_evidence_quality)

print(ecosystem_summary)

write_csv(
  ecosystem_summary,
  file.path(output_dir, "ecosystem_monitoring_readiness_summary.csv")
)
