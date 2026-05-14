suppressPackageStartupMessages({
  library(dplyr)
  library(readr)
})

args <- commandArgs(trailingOnly = FALSE)
file_arg <- "--file="
script_path <- sub(file_arg, "", args[grep(file_arg, args)])
article_dir <- normalizePath(file.path(dirname(script_path), ".."))
data_path <- file.path(article_dir, "data", "soil_monitoring_readiness_scores.csv")
output_dir <- file.path(article_dir, "outputs")

dir.create(output_dir, showWarnings = FALSE, recursive = TRUE)

soil_programs <- read_csv(data_path, show_col_types = FALSE)

soil_summary <- soil_programs %>%
  mutate(
    soil_evidence_quality = round(
      0.14 * spatial_representativeness +
      0.14 * depth_representation +
      0.14 * calibration_quality +
      0.12 * telemetry_completeness +
      0.12 * laboratory_support +
      0.10 * remote_product_agreement +
      0.10 * uncertainty_communication +
      0.14 * decision_readiness,
      3
    ),
    review_priority = case_when(
      high_stakes_use & calibration_quality < 0.75 ~ "high_stakes_calibration_review",
      spatial_representativeness < 0.70 ~ "spatial_representativeness_review",
      depth_representation < 0.70 ~ "depth_representation_review",
      calibration_quality < 0.75 ~ "calibration_review",
      telemetry_completeness < 0.80 ~ "telemetry_completeness_review",
      laboratory_support < 0.70 ~ "laboratory_support_review",
      remote_product_agreement < 0.70 ~ "remote_product_validation_review",
      uncertainty_communication < 0.75 ~ "uncertainty_communication_review",
      decision_readiness < 0.75 ~ "decision_readiness_review",
      soil_evidence_quality < 0.75 ~ "soil_evidence_quality_review",
      TRUE ~ "routine_monitoring"
    )
  ) %>%
  arrange(review_priority, soil_evidence_quality)

print(soil_summary)
write_csv(soil_summary, file.path(output_dir, "soil_monitoring_readiness_summary.csv"))
