suppressPackageStartupMessages({
  library(dplyr)
  library(readr)
})

args <- commandArgs(trailingOnly = FALSE)
file_arg <- "--file="
script_path <- sub(file_arg, "", args[grep(file_arg, args)])
article_dir <- normalizePath(file.path(dirname(script_path), ".."))
data_path <- file.path(article_dir, "data", "biodiversity_monitoring_readiness_scores.csv")
output_dir <- file.path(article_dir, "outputs")

dir.create(output_dir, showWarnings = FALSE, recursive = TRUE)

programs <- read_csv(data_path, show_col_types = FALSE)

summary <- programs %>%
  mutate(
    biodiversity_evidence_quality = round(
      0.12 * taxonomic_coverage +
      0.12 * spatial_representativeness +
      0.10 * method_diversity +
      0.12 * detectability_adjustment +
      0.12 * observation_quality +
      0.12 * indicator_readiness +
      0.10 * habitat_context_linkage +
      0.09 * uncertainty_communication +
      0.11 * governance_readiness,
      3
    ),
    review_priority = case_when(
      high_stakes_use & detectability_adjustment < 0.70 ~ "high_stakes_detectability_review",
      taxonomic_coverage < 0.65 ~ "taxonomic_coverage_review",
      spatial_representativeness < 0.65 ~ "spatial_representativeness_review",
      method_diversity < 0.65 ~ "method_diversity_review",
      detectability_adjustment < 0.70 ~ "detectability_review",
      indicator_readiness < 0.70 ~ "indicator_readiness_review",
      habitat_context_linkage < 0.70 ~ "habitat_context_review",
      uncertainty_communication < 0.75 ~ "uncertainty_communication_review",
      governance_readiness < 0.75 ~ "governance_readiness_review",
      biodiversity_evidence_quality < 0.75 ~ "biodiversity_evidence_quality_review",
      TRUE ~ "routine_monitoring"
    )
  ) %>%
  arrange(review_priority, biodiversity_evidence_quality)

print(summary)

write_csv(
  summary,
  file.path(output_dir, "biodiversity_monitoring_readiness_summary.csv")
)
