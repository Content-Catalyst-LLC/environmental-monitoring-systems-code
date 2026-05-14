DROP TABLE IF EXISTS soil_monitoring_readiness_scores;
DROP TABLE IF EXISTS sensor_sampling_registry;
DROP TABLE IF EXISTS soil_profile_registry;
DROP TABLE IF EXISTS soil_observation_records;
DROP TABLE IF EXISTS threshold_decision_registry;

CREATE TABLE soil_profile_registry (
  field_id TEXT,
  management_zone TEXT,
  soil_texture TEXT,
  rooting_depth_cm INTEGER,
  drainage_class TEXT,
  organic_matter_percent REAL,
  available_water_capacity REAL,
  notes TEXT
);

CREATE TABLE sensor_sampling_registry (
  sensor_id TEXT PRIMARY KEY,
  field_id TEXT,
  management_zone TEXT,
  parameter TEXT,
  unit TEXT,
  depth_cm TEXT,
  latitude REAL,
  longitude REAL,
  installation_date TEXT,
  calibration_status TEXT,
  owner TEXT
);

CREATE TABLE soil_observation_records (
  record_id TEXT PRIMARY KEY,
  sensor_id TEXT,
  timestamp TEXT,
  parameter TEXT,
  value REAL,
  unit TEXT,
  quality_flag TEXT,
  telemetry_status TEXT
);

CREATE TABLE threshold_decision_registry (
  threshold_id TEXT PRIMARY KEY,
  program_id TEXT,
  decision_use TEXT,
  parameter TEXT,
  threshold_value REAL,
  unit TEXT,
  soil_context TEXT,
  crop_or_system TEXT,
  response_action TEXT,
  review_status TEXT
);

CREATE TABLE soil_monitoring_readiness_scores (
  program_id TEXT PRIMARY KEY,
  crop_or_system TEXT,
  geography TEXT,
  spatial_representativeness REAL,
  depth_representation REAL,
  calibration_quality REAL,
  telemetry_completeness REAL,
  laboratory_support REAL,
  remote_product_agreement REAL,
  uncertainty_communication REAL,
  decision_readiness REAL,
  high_stakes_use INTEGER
);

INSERT INTO soil_monitoring_readiness_scores VALUES
('irrigated-maize-profile-monitoring','maize','irrigated_field_block',0.76,0.86,0.82,0.92,0.70,0.72,0.78,0.86,1),
('orchard-salinity-moisture-monitoring','orchard','salinity_risk_zone',0.72,0.80,0.76,0.88,0.78,0.68,0.76,0.82,1),
('regional-drought-soil-moisture-network','mixed_agriculture','regional_network',0.68,0.72,0.78,0.84,0.66,0.82,0.78,0.76,1),
('soil-health-stewardship-program','soil_health','conservation_fields',0.70,0.64,0.74,0.76,0.86,0.62,0.70,0.72,0);
