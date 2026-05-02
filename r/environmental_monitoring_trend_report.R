library(readr)
library(dplyr)
library(ggplot2)

project_root <- normalizePath(file.path(dirname(sys.frame(1)$ofile), ".."))
input_path <- file.path(project_root, "data", "processed", "environmental_observations.csv")
output_tables_dir <- file.path(project_root, "outputs", "tables")
output_figures_dir <- file.path(project_root, "outputs", "figures")

dir.create(output_tables_dir, recursive = TRUE, showWarnings = FALSE)
dir.create(output_figures_dir, recursive = TRUE, showWarnings = FALSE)

observations <- read_csv(input_path, show_col_types = FALSE)

domain_summary <- observations |>
  group_by(domain) |>
  summarise(
    records = n(),
    missing_values = sum(is.na(calibrated_value)),
    mean_calibrated_value = mean(calibrated_value, na.rm = TRUE),
    mean_battery_voltage = mean(battery_voltage, na.rm = TRUE),
    mean_signal_quality = mean(signal_quality, na.rm = TRUE),
    .groups = "drop"
  )

write_csv(
  domain_summary,
  file.path(output_tables_dir, "environmental_monitoring_domain_summary.csv")
)

quality_plot <- ggplot(domain_summary, aes(x = domain, y = mean_signal_quality)) +
  geom_col() +
  labs(
    title = "Mean Signal Quality by Environmental Monitoring Domain",
    x = "Monitoring domain",
    y = "Mean signal quality"
  ) +
  theme_minimal()

ggsave(
  filename = file.path(output_figures_dir, "mean_signal_quality_by_domain.png"),
  plot = quality_plot,
  width = 8,
  height = 5,
  dpi = 300
)

print(domain_summary)
