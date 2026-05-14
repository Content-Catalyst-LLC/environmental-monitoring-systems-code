suppressPackageStartupMessages({
  library(dplyr)
  library(readr)
})

article_dir <- normalizePath(file.path(dirname(sys.frame(1)$ofile), ".."))
data_path <- file.path(article_dir, "data", "dashboard_indicators.csv")
output_dir <- file.path(article_dir, "outputs")

dir.create(output_dir, showWarnings = FALSE, recursive = TRUE)

dashboard_indicators <- read_csv(data_path, show_col_types = FALSE)

dashboard_summary <- dashboard_indicators %>%
  mutate(
    alert_burden = if_else(actionable_alert_count == 0, alert_count, alert_count / actionable_alert_count),
    freshness_score = if_else(is_fresh, 1, 0),
    provenance_score = if_else(has_provenance, 1, 0),
    uncertainty_score = if_else(!is_modeled_or_estimated | uncertainty_labeled, 1, 0),
    role_fit_score = if_else(supports_priority_task, 1, 0),
    decision_support_score = round(
      0.25 * freshness_score +
      0.25 * provenance_score +
      0.20 * uncertainty_score +
      0.20 * role_fit_score -
      0.10 * pmin(alert_burden / 10, 1),
      3
    ),
    review_priority = case_when(
      !has_provenance ~ "provenance_review",
      is_modeled_or_estimated & !uncertainty_labeled ~ "uncertainty_visibility_review",
      alert_burden > 5 ~ "alert_burden_review",
      !supports_priority_task ~ "user_role_fit_review",
      decision_support_score < 0.70 ~ "dashboard_quality_review",
      TRUE ~ "routine_monitoring"
    )
  ) %>%
  arrange(review_priority, decision_support_score)

print(dashboard_summary)

write_csv(
  dashboard_summary,
  file.path(output_dir, "dashboard_indicator_review_summary.csv")
)
