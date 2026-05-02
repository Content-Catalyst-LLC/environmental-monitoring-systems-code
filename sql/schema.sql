CREATE TABLE IF NOT EXISTS monitoring_devices (
    device_id TEXT PRIMARY KEY,
    device_type TEXT NOT NULL,
    hardware_platform TEXT NOT NULL,
    firmware_version TEXT NOT NULL,
    deployment_site TEXT NOT NULL,
    latitude REAL,
    longitude REAL,
    installed_at TEXT NOT NULL,
    active INTEGER NOT NULL CHECK (active IN (0, 1))
);

CREATE TABLE IF NOT EXISTS environmental_sensors (
    sensor_id TEXT PRIMARY KEY,
    device_id TEXT NOT NULL,
    sensor_type TEXT NOT NULL,
    environmental_domain TEXT NOT NULL,
    unit TEXT NOT NULL,
    sampling_interval_seconds INTEGER NOT NULL,
    FOREIGN KEY (device_id) REFERENCES monitoring_devices(device_id)
);

CREATE TABLE IF NOT EXISTS calibration_records (
    calibration_id INTEGER PRIMARY KEY AUTOINCREMENT,
    sensor_id TEXT NOT NULL,
    calibrated_at TEXT NOT NULL,
    calibration_method TEXT NOT NULL,
    scale_factor REAL NOT NULL,
    offset_value REAL NOT NULL,
    reference_standard TEXT,
    FOREIGN KEY (sensor_id) REFERENCES environmental_sensors(sensor_id)
);

CREATE TABLE IF NOT EXISTS environmental_observations (
    observation_id INTEGER PRIMARY KEY AUTOINCREMENT,
    sensor_id TEXT NOT NULL,
    observed_at TEXT NOT NULL,
    raw_value REAL NOT NULL,
    calibrated_value REAL NOT NULL,
    battery_voltage REAL,
    signal_quality REAL,
    quality_flag TEXT NOT NULL,
    transmitted INTEGER NOT NULL CHECK (transmitted IN (0, 1)),
    FOREIGN KEY (sensor_id) REFERENCES environmental_sensors(sensor_id)
);

CREATE TABLE IF NOT EXISTS environmental_alerts (
    alert_id INTEGER PRIMARY KEY AUTOINCREMENT,
    sensor_id TEXT NOT NULL,
    observed_at TEXT NOT NULL,
    alert_type TEXT NOT NULL,
    severity TEXT NOT NULL,
    calibrated_value REAL NOT NULL,
    threshold_value REAL NOT NULL,
    handled_locally INTEGER NOT NULL CHECK (handled_locally IN (0, 1)),
    FOREIGN KEY (sensor_id) REFERENCES environmental_sensors(sensor_id)
);
