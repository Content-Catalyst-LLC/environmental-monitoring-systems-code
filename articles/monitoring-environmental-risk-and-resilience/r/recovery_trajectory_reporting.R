suppressPackageStartupMessages({
  library(dplyr)
  library(readr)
})

article_dir <- normalizePath(file.path(dirname(sys.frame(1)$ofile), ".."))
data_path <- file.path(article_dir, "data", "recovery_trajectories.csv")
output_dir <- file.path(article_dir, "outputs")

dir.create(output_dir, showWarnings = FALSE, recursive = TRUE)

recovery <- read_csv(data_path, show_col_types = FALSE)

recovery_summary <- recovery %>%
  mutate(
    recovery_ratio = function_restored / target_function,
    delayed_recovery = recovery_ratio < 0.60 & days_after_event >= 30
  ) %>%
  group_by(unit_id, domain) %>%
  summarise(
    latest_day = max(days_after_event),
    latest_recovery_ratio = recovery_ratio[which.max(days_after_event)],
    highest_vulnerability = max(vulnerability_score),
    recovery_status = case_when(
      latest_recovery_ratio >= 0.85 ~ "substantial_recovery",
      latest_recovery_ratio >= 0.60 ~ "partial_recovery",
      TRUE ~ "delayed_recovery"
    ),
    equity_review_priority = case_when(
      highest_vulnerability >= 0.70 & latest_recovery_ratio < 0.75 ~ "high",
      highest_vulnerability >= 0.55 & latest_recovery_ratio < 0.70 ~ "medium",
      TRUE ~ "routine"
    ),
    .groups = "drop"
  ) %>%
  arrange(desc(equity_review_priority), latest_recovery_ratio)

print(recovery_summary)

write_csv(
  recovery_summary,
  file.path(output_dir, "recovery_trajectory_summary.csv")
)
