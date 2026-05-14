suppressPackageStartupMessages({
  library(dplyr)
  library(readr)
})

article_dir <- normalizePath(file.path(dirname(sys.frame(1)$ofile), ".."))
data_path <- file.path(article_dir, "data", "warning_reach_response.csv")
output_dir <- file.path(article_dir, "outputs")

dir.create(output_dir, showWarnings = FALSE, recursive = TRUE)

warning_reach <- read_csv(data_path, show_col_types = FALSE)

reach_summary <- warning_reach %>%
  mutate(
    reach_rate = reached / exposed,
    protective_action_rate = acted / reached,
    last_mile_gap = 1 - reach_rate
  ) %>%
  group_by(scenario_id, hazard_type) %>%
  summarise(
    total_exposed = sum(exposed),
    total_reached = sum(reached),
    total_acted = sum(acted),
    overall_reach_rate = round(total_reached / total_exposed, 3),
    overall_action_rate = round(total_acted / total_reached, 3),
    largest_group_gap = round(max(last_mile_gap), 3),
    review_priority = case_when(
      largest_group_gap >= 0.40 ~ "high_last_mile_gap",
      overall_reach_rate < 0.70 ~ "communication_review",
      overall_action_rate < 0.50 ~ "response_capacity_review",
      TRUE ~ "routine_monitoring"
    ),
    .groups = "drop"
  )

print(reach_summary)

write_csv(
  reach_summary,
  file.path(output_dir, "warning_reach_response_summary.csv")
)
