DROP TABLE IF EXISTS smart_water_readiness_scores;
DROP TABLE IF EXISTS sensor_asset_registry;
DROP TABLE IF EXISTS telemetry_status_records;
DROP TABLE IF EXISTS water_observation_records;
DROP TABLE IF EXISTS threshold_alert_registry;
DROP TABLE IF EXISTS response_work_order_log;
DROP TABLE IF EXISTS control_failsafe_log;

CREATE TABLE sensor_asset_registry (
  sensor_id TEXT PRIMARY KEY,
  asset_id TEXT,
  water_domain TEXT,
  location TEXT,
  parameter TEXT,
  unit TEXT,
  latitude REAL,
  longitude REAL,
  installation_date TEXT,
  calibration_status TEXT,
  owner TEXT
);

CREATE TABLE telemetry_status_records (
  telemetry_id TEXT PRIMARY KEY,
  sensor_id TEXT,
  window_start TEXT,
  window_end TEXT,
  expected_readings INTEGER,
  received_readings INTEGER,
  median_latency_seconds REAL,
  max_latency_seconds REAL,
  outage_minutes REAL,
  status TEXT
);

CREATE TABLE water_observation_records (
  record_id TEXT PRIMARY KEY,
  sensor_id TEXT,
  timestamp TEXT,
  parameter TEXT,
  value TEXT,
  unit TEXT,
  quality_flag TEXT,
  operational_context TEXT
);

CREATE TABLE threshold_alert_registry (
  alert_id TEXT PRIMARY KEY,
  program_id TEXT,
  water_domain TEXT,
  parameter TEXT,
  threshold_type TEXT,
  threshold_value REAL,
  unit TEXT,
  severity TEXT,
  response_owner TEXT,
  valid_use TEXT,
  review_status TEXT
);

CREATE TABLE response_work_order_log (
  response_id TEXT PRIMARY KEY,
  alert_id TEXT,
  detection_time TEXT,
  action_time TEXT,
  response_type TEXT,
  owner TEXT,
  outcome TEXT,
  status TEXT,
  notes TEXT
);

CREATE TABLE control_failsafe_log (
  control_id TEXT PRIMARY KEY,
  program_id TEXT,
  control_action TEXT,
  automation_level TEXT,
  allowed_conditions TEXT,
  override_required INTEGER,
  fail_safe_state TEXT,
  review_status TEXT
);

CREATE TABLE smart_water_readiness_scores (
  program_id TEXT PRIMARY KEY,
  water_domain TEXT,
  service_goal TEXT,
  sensing_coverage REAL,
  data_quality_validity REAL,
  telemetry_completeness REAL,
  latency_readiness REAL,
  anomaly_confidence REAL,
  response_capacity REAL,
  model_readiness REAL,
  control_safety REAL,
  governance_readiness REAL,
  high_stakes_use INTEGER
);

INSERT INTO smart_water_readiness_scores VALUES
('distribution-online-quality','distribution_system','water_quality_surveillance',0.78,0.82,0.91,0.86,0.78,0.80,0.72,0.76,0.84,1),
('ami-leak-detection','customer_metering','demand_visibility_and_leak_detection',0.84,0.80,0.88,0.82,0.76,0.70,0.68,0.74,0.78,1),
('wet-weather-smart-sewer','sewer_stormwater','overflow_risk_reduction',0.72,0.76,0.82,0.78,0.74,0.68,0.76,0.70,0.74,1),
('treatment-digital-twin','treatment_process','process_optimization',0.80,0.84,0.90,0.88,0.82,0.82,0.86,0.80,0.86,1),
('source-water-surveillance','source_water','early_quality_detection',0.76,0.78,0.86,0.82,0.74,0.76,0.70,0.72,0.80,1);
