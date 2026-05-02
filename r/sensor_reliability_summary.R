library(readr)
library(dplyr)

project_root <- normalizePath(file.path(dirname(sys.frame(1)$ofile), ".."))
input_path <- file.path(project_root, "data", "processed", "environmental_observations.csv")
output_tables_dir <- file.path(project_root, "outputs", "tables")

dir.create(output_tables_dir, recursive = TRUE, showWarnings = FALSE)

observations <- read_csv(input_path, show_col_types = FALSE)

reliability <- observations |>
  mutate(valid_record = !is.na(calibrated_value) & battery_voltage >= 3.3 & signal_quality >= 0.80) |>
  group_by(sensor_id, domain) |>
  summarise(
    records = n(),
    valid_record_rate = mean(valid_record),
    lowest_battery_voltage = min(battery_voltage, na.rm = TRUE),
    lowest_signal_quality = min(signal_quality, na.rm = TRUE),
    .groups = "drop"
  )

write_csv(reliability, file.path(output_tables_dir, "sensor_reliability_summary.csv"))
print(reliability)
