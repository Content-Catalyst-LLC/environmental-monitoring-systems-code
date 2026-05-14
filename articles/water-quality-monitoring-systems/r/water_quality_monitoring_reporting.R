suppressPackageStartupMessages({
  library(dplyr)
  library(readr)
})

args <- commandArgs(trailingOnly = FALSE)
file_arg <- "--file="
script_path <- sub(file_arg, "", args[grep(file_arg, args)])
article_dir <- normalizePath(file.path(dirname(script_path), ".."))

readiness_path <- file.path(article_dir, "data", "water_quality_monitoring_readiness_scores.csv")
load_path <- file.path(article_dir, "data", "hydrology_load_linkage.csv")
lab_path <- file.path(article_dir, "data", "laboratory_results.csv")
threshold_path <- file.path(article_dir, "data", "assessment_threshold_registry.csv")
output_dir <- file.path(article_dir, "outputs")

dir.create(output_dir, showWarnings = FALSE, recursive = TRUE)

programs <- read_csv(readiness_path, show_col_types = FALSE)

readiness_summary <- programs %>%
  mutate(
    water_quality_evidence_score = round(
      0.13 * sampling_representativeness +
      0.13 * analytical_validity +
      0.12 * hydrological_context +
      0.13 * qaqc_completeness +
      0.11 * load_readiness +
      0.11 * threshold_alignment +
      0.09 * uncertainty_communication +
      0.09 * data_interoperability +
      0.09 * governance_readiness,
      3
    ),
    review_priority = case_when(
      high_stakes_use & analytical_validity < 0.75 ~ "high_stakes_analytical_validity_review",
      sampling_representativeness < 0.70 ~ "sampling_representativeness_review",
      hydrological_context < 0.70 ~ "hydrological_context_review",
      qaqc_completeness < 0.75 ~ "qaqc_completeness_review",
      load_readiness < 0.70 ~ "load_readiness_review",
      threshold_alignment < 0.75 ~ "threshold_alignment_review",
      uncertainty_communication < 0.75 ~ "uncertainty_communication_review",
      data_interoperability < 0.75 ~ "data_interoperability_review",
      governance_readiness < 0.75 ~ "governance_readiness_review",
      water_quality_evidence_score < 0.75 ~ "water_quality_evidence_review",
      TRUE ~ "routine_monitoring"
    )
  ) %>%
  arrange(review_priority, water_quality_evidence_score)

print(readiness_summary)
write_csv(readiness_summary, file.path(output_dir, "water_quality_monitoring_readiness_summary.csv"))

loads <- read_csv(load_path, show_col_types = FALSE)

load_summary <- loads %>%
  filter(!is.na(instantaneous_load_kg_day)) %>%
  group_by(site_id, concentration_parameter, event_flag) %>%
  summarise(
    records = n(),
    mean_concentration = mean(concentration_value, na.rm = TRUE),
    total_instantaneous_load_kg_day = sum(instantaneous_load_kg_day, na.rm = TRUE),
    review_records = sum(quality_flag != "pass"),
    .groups = "drop"
  )

print(load_summary)
write_csv(load_summary, file.path(output_dir, "water_quality_load_summary.csv"))

lab <- read_csv(lab_path, show_col_types = FALSE)
thresholds <- read_csv(threshold_path, show_col_types = FALSE)

exceedance_summary <- lab %>%
  inner_join(thresholds, by = "parameter_id") %>%
  mutate(
    exceeds = case_when(
      threshold_type == "above" ~ result_value > threshold_value,
      threshold_type == "below" ~ result_value < threshold_value,
      TRUE ~ FALSE
    )
  ) %>%
  group_by(parameter_id, decision_use) %>%
  summarise(
    valid_observations = n(),
    exceedances = sum(exceeds),
    review_records = sum(lab_qaqc_flag != "pass"),
    exceedance_ratio = round(exceedances / valid_observations, 3),
    .groups = "drop"
  )

print(exceedance_summary)
write_csv(exceedance_summary, file.path(output_dir, "water_quality_exceedance_summary.csv"))
