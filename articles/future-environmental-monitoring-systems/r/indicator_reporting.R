suppressPackageStartupMessages({
  library(dplyr)
  library(readr)
})

article_dir <- normalizePath(file.path(dirname(sys.frame(1)$ofile), ".."))
data_path <- file.path(article_dir, "data", "observation_source_inventory.csv")
output_dir <- file.path(article_dir, "outputs")

dir.create(output_dir, showWarnings = FALSE, recursive = TRUE)

sources <- read_csv(data_path, show_col_types = FALSE)

indicator_summary <- sources %>%
  mutate(
    evidence_strength = round(
      0.20 * quality_score +
      0.15 * coverage_score +
      0.15 * freshness_score +
      0.15 * interoperability_score +
      0.15 * provenance_score +
      0.10 * governance_score -
      0.10 * uncertainty_score,
      3
    ),
    review_priority = case_when(
      uncertainty_score > 0.35 ~ "High uncertainty review",
      evidence_strength < 0.65 ~ "Evidence-strength review",
      provenance_score < 0.70 ~ "Provenance review",
      interoperability_score < 0.70 ~ "Interoperability review",
      TRUE ~ "Routine monitoring"
    )
  ) %>%
  arrange(desc(evidence_strength))

print(indicator_summary %>%
  select(source_id, domain, source_type, evidence_strength, review_priority))

write_csv(
  indicator_summary,
  file.path(output_dir, "environmental_intelligence_indicator_summary.csv")
)
