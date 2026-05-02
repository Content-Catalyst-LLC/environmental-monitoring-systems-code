use std::collections::HashSet;

fn main() {
    let required_fields: HashSet<&str> = [
        "sensor_id",
        "domain",
        "raw_value",
        "battery_voltage",
        "signal_quality",
        "observed_at",
    ]
    .into_iter()
    .collect();

    let observed_fields: HashSet<&str> = [
        "sensor_id",
        "domain",
        "raw_value",
        "battery_voltage",
        "signal_quality",
        "observed_at",
    ]
    .into_iter()
    .collect();

    let missing: Vec<&&str> = required_fields.difference(&observed_fields).collect();

    if missing.is_empty() {
        println!("Telemetry schema validation passed.");
    } else {
        println!("Missing fields: {:?}", missing);
    }
}
