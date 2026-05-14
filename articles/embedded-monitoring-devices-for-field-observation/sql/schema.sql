DROP TABLE IF EXISTS device_sensor_registry;
DROP TABLE IF EXISTS calibration_maintenance_log;
DROP TABLE IF EXISTS device_health_records;
DROP TABLE IF EXISTS embedded_device_readiness_scores;
DROP TABLE IF EXISTS field_observation_records;
DROP TABLE IF EXISTS embedded_device_governance_log;

CREATE TABLE device_sensor_registry (
  device_id TEXT PRIMARY KEY,
  domain TEXT NOT NULL,
  site_id TEXT NOT NULL,
  device_type TEXT NOT NULL,
  sensor_type TEXT NOT NULL,
  observed_property TEXT NOT NULL,
  unit TEXT NOT NULL,
  firmware_version TEXT NOT NULL,
  calibration_status TEXT NOT NULL,
  power_mode TEXT NOT NULL,
  telemetry_mode TEXT NOT NULL,
  owner TEXT NOT NULL,
  high_stakes_use INTEGER NOT NULL,
  notes TEXT
);

CREATE TABLE calibration_maintenance_log (
  record_id TEXT PRIMARY KEY,
  device_id TEXT NOT NULL,
  date TEXT NOT NULL,
  event_type TEXT NOT NULL,
  technician TEXT NOT NULL,
  calibration_status TEXT NOT NULL,
  drift_observed REAL NOT NULL,
  maintenance_action TEXT NOT NULL,
  notes TEXT
);

CREATE TABLE device_health_records (
  health_id TEXT PRIMARY KEY,
  device_id TEXT NOT NULL,
  timestamp TEXT NOT NULL,
  battery_voltage REAL NOT NULL,
  storage_percent_used REAL NOT NULL,
  internal_humidity_percent REAL NOT NULL,
  internal_temperature_c REAL NOT NULL,
  reboot_count INTEGER NOT NULL,
  clock_drift_seconds REAL NOT NULL,
  telemetry_latency_seconds REAL NOT NULL,
  health_status TEXT NOT NULL
);

CREATE TABLE embedded_device_readiness_scores (
  device_id TEXT PRIMARY KEY,
  domain TEXT NOT NULL,
  device_type TEXT NOT NULL,
  valid_operation_hours REAL NOT NULL,
  deployment_hours REAL NOT NULL,
  valid_records INTEGER NOT NULL,
  expected_records INTEGER NOT NULL,
  energy_available_wh REAL NOT NULL,
  energy_required_wh REAL NOT NULL,
  calibration_validity REAL NOT NULL,
  clock_drift_seconds REAL NOT NULL,
  allowed_clock_drift_seconds REAL NOT NULL,
  qc_readiness REAL NOT NULL,
  health_visibility REAL NOT NULL,
  decision_fit REAL NOT NULL,
  high_stakes_use INTEGER NOT NULL
);

CREATE TABLE field_observation_records (
  observation_id TEXT PRIMARY KEY,
  device_id TEXT NOT NULL,
  observed_property TEXT NOT NULL,
  value REAL NOT NULL,
  unit TEXT NOT NULL,
  phenomenon_time TEXT NOT NULL,
  result_time TEXT NOT NULL,
  ingested_at TEXT NOT NULL,
  quality_flag TEXT NOT NULL,
  calibration_status TEXT NOT NULL,
  firmware_version TEXT NOT NULL
);

CREATE TABLE embedded_device_governance_log (
  governance_id TEXT PRIMARY KEY,
  date TEXT NOT NULL,
  device_id TEXT NOT NULL,
  decision TEXT NOT NULL,
  owner TEXT NOT NULL,
  status TEXT NOT NULL,
  public_note_required INTEGER NOT NULL
);

INSERT INTO device_sensor_registry VALUES
('river-stage-logger-001','water','river-station-a','pressure_stage_logger','pressure_transducer','water_level','m','v1.4.2','valid','solar_battery','cellular','hydrology_team',1,'River stage logger with local storage and telemetry'),
('community-air-node-002','air_quality','urban-site-b','pm_sensor_pod','optical_particle_sensor','pm25','ug_m3','v2.3.1','review_required','mains_backup','wifi_cellular','air_quality_team',1,'Community air monitoring node requiring calibration review'),
('soil-moisture-node-003','soil','ag-field-c','low_power_soil_node','capacitance_probe','soil_moisture','percent','v0.9.7','valid','battery_lpwan','lpwan','agroecology_team',0,'Low-power soil monitoring node'),
('wetland-camera-trap-004','biodiversity','wetland-site-d','camera_trap','image_sensor','habitat_activity','count','v1.1.0','valid','battery_solar','local_storage','ecology_team',0,'Camera trap with local storage and delayed retrieval'),
('water-quality-sonde-005','water_quality','reservoir-site-e','multiparameter_sonde','optical_and_electrochemical','turbidity','ntu','v2.2.0','valid','solar_battery','cellular','water_quality_team',1,'Water-quality sonde with local QC'),
('stormwater-flow-node-006','infrastructure','stormwater-site-f','flow_monitor','ultrasonic_flow','flow_rate','l_s','v1.2.0','expired','mains','wired','stormwater_team',1,'Stormwater node with expired calibration');

INSERT INTO embedded_device_readiness_scores VALUES
('river-stage-logger-001','water','pressure_stage_logger',690,720,2840,2880,140,112,0.92,3,10,0.88,0.84,0.90,1),
('community-air-node-002','air_quality','pm_sensor_pod',610,720,2440,2880,95,110,0.74,12,10,0.78,0.82,0.84,1),
('soil-moisture-node-003','soil','low_power_soil_node',700,720,1420,1440,55,48,0.86,5,30,0.76,0.72,0.78,0),
('wetland-camera-trap-004','biodiversity','camera_trap',560,720,860,1440,180,150,0.82,20,60,0.70,0.68,0.74,0),
('water-quality-sonde-005','water_quality','multiparameter_sonde',680,720,2710,2880,132,118,0.88,4,10,0.84,0.80,0.86,1),
('stormwater-flow-node-006','infrastructure','flow_monitor',650,720,2620,2880,210,190,0.62,8,10,0.74,0.78,0.86,1);

INSERT INTO field_observation_records VALUES
('obs-001','river-stage-logger-001','water_level',2.74,'m','2026-05-14T12:00:00Z','2026-05-14T12:00:05Z','2026-05-14T12:00:17Z','pass','valid','v1.4.2'),
('obs-002','community-air-node-002','pm25',31.5,'ug_m3','2026-05-14T12:00:00Z','2026-05-14T12:00:04Z','2026-05-14T12:00:52Z','review_required','review_required','v2.3.1'),
('obs-003','soil-moisture-node-003','soil_moisture',17.4,'percent','2026-05-14T12:00:00Z','2026-05-14T12:00:04Z','2026-05-14T12:10:00Z','pass','valid','v0.9.7'),
('obs-004','wetland-camera-trap-004','habitat_activity',1,'count','2026-05-14T04:32:00Z','2026-05-14T04:32:05Z','2026-05-15T12:00:00Z','delayed_local_storage','valid','v1.1.0'),
('obs-005','water-quality-sonde-005','turbidity',12.8,'ntu','2026-05-14T12:00:00Z','2026-05-14T12:00:03Z','2026-05-14T12:00:21Z','pass','valid','v2.2.0'),
('obs-006','stormwater-flow-node-006','flow_rate',810,'l_s','2026-05-14T12:00:00Z','2026-05-14T12:00:02Z','2026-05-14T12:00:09Z','calibration_expired','expired','v1.2.0');
