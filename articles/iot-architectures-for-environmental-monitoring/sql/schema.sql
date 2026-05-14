DROP TABLE IF EXISTS device_sensor_registry;
DROP TABLE IF EXISTS gateway_edge_registry;
DROP TABLE IF EXISTS iot_architecture_readiness_scores;
DROP TABLE IF EXISTS alert_rule_registry;
DROP TABLE IF EXISTS environmental_observations_sample;
DROP TABLE IF EXISTS iot_governance_log;

CREATE TABLE device_sensor_registry (
  device_id TEXT PRIMARY KEY,
  domain TEXT NOT NULL,
  site_id TEXT NOT NULL,
  device_type TEXT NOT NULL,
  observed_property TEXT NOT NULL,
  unit TEXT NOT NULL,
  calibration_status TEXT NOT NULL,
  firmware_version TEXT NOT NULL,
  power_mode TEXT NOT NULL,
  owner TEXT NOT NULL,
  high_stakes_use INTEGER NOT NULL,
  notes TEXT
);

CREATE TABLE gateway_edge_registry (
  gateway_id TEXT PRIMARY KEY,
  site_id TEXT NOT NULL,
  connected_devices TEXT NOT NULL,
  transport_mode TEXT NOT NULL,
  edge_rules_enabled INTEGER NOT NULL,
  buffer_policy TEXT NOT NULL,
  failover_policy TEXT NOT NULL,
  edge_traceability REAL NOT NULL,
  notes TEXT
);

CREATE TABLE iot_architecture_readiness_scores (
  component_id TEXT PRIMARY KEY,
  domain TEXT NOT NULL,
  component_type TEXT NOT NULL,
  device_availability REAL NOT NULL,
  delivery_completeness REAL NOT NULL,
  semantic_completeness REAL NOT NULL,
  qc_readiness REAL NOT NULL,
  edge_traceability REAL NOT NULL,
  decision_fit REAL NOT NULL,
  end_to_end_latency_minutes REAL NOT NULL,
  target_latency_minutes REAL NOT NULL,
  high_stakes_use INTEGER NOT NULL
);

CREATE TABLE alert_rule_registry (
  alert_rule_id TEXT PRIMARY KEY,
  domain TEXT NOT NULL,
  observed_property TEXT NOT NULL,
  threshold_type TEXT NOT NULL,
  threshold_value REAL NOT NULL,
  severity TEXT NOT NULL,
  owner TEXT NOT NULL,
  suppression_window_minutes INTEGER NOT NULL,
  action_pathway TEXT NOT NULL,
  review_status TEXT NOT NULL
);

CREATE TABLE environmental_observations_sample (
  observation_id TEXT PRIMARY KEY,
  device_id TEXT NOT NULL,
  observed_property TEXT NOT NULL,
  value REAL NOT NULL,
  unit TEXT NOT NULL,
  phenomenon_time TEXT NOT NULL,
  result_time TEXT NOT NULL,
  ingested_at TEXT NOT NULL,
  quality_flag TEXT NOT NULL,
  edge_rule_id TEXT
);

CREATE TABLE iot_governance_log (
  governance_id TEXT PRIMARY KEY,
  date TEXT NOT NULL,
  component_id TEXT NOT NULL,
  decision TEXT NOT NULL,
  owner TEXT NOT NULL,
  status TEXT NOT NULL,
  public_note_required INTEGER NOT NULL
);

INSERT INTO device_sensor_registry VALUES
('river-node-001','water','river-station-a','water_level_sensor','water_level','m','valid','v1.4.2','solar_battery','hydrology_team',1,'Operational river-level node'),
('coastal-buoy-002','coastal','coastal-bay-b','multiparameter_buoy','water_temperature','celsius','valid','v2.1.0','solar_battery','coastal_team',1,'Coastal buoy with intermittent connectivity'),
('soil-node-003','soil','ag-field-c','soil_moisture_probe','soil_moisture','percent','review_required','v0.9.8','battery_lpwan','agroecology_team',0,'Low-power soil cluster sensor'),
('air-node-004','air_quality','urban-site-d','pm_sensor','pm25','ug_m3','valid','v3.2.1','mains_backup','air_quality_team',1,'Urban air-quality node'),
('storm-drain-006','infrastructure','stormwater-site-f','flow_sensor','flow_rate','l_s','expired','v1.2.0','mains','stormwater_team',1,'Calibration expired and needs review');

INSERT INTO gateway_edge_registry VALUES
('gateway-river-a','river-station-a','river-node-001','cellular',1,'store_and_forward_72h','local_buffer_then_retry',0.82,'River gateway with threshold and buffering rules'),
('gateway-coastal-b','coastal-bay-b','coastal-buoy-002','satellite',1,'store_and_forward_168h','batch_retry',0.72,'Satellite gateway needs stronger edge event logging'),
('gateway-ag-c','ag-field-c','soil-node-003','lpwan',1,'store_and_forward_48h','lpwan_retry',0.80,'Low-power gateway for soil cluster'),
('gateway-urban-d','urban-site-d','air-node-004','wired_cellular_backup',1,'store_and_forward_24h','backup_link',0.86,'Urban gateway with redundant transport'),
('gateway-storm-f','stormwater-site-f','storm-drain-006','wired',1,'store_and_forward_24h','local_alarm',0.74,'Stormwater gateway requires traceability review');

INSERT INTO iot_architecture_readiness_scores VALUES
('river-level-node-network','water','sensor_network',0.92,0.88,0.86,0.84,0.78,0.90,8,10,1),
('coastal-buoy-gateway','coastal','gateway',0.82,0.76,0.82,0.80,0.72,0.84,25,15,1),
('soil-moisture-lpwan-cluster','soil','low_power_sensor_cluster',0.78,0.84,0.74,0.72,0.80,0.76,90,120,0),
('urban-air-quality-platform','air_quality','platform_service',0.88,0.90,0.92,0.86,0.82,0.88,12,15,1),
('stormwater-flow-alert-system','infrastructure','alert_system',0.74,0.82,0.80,0.76,0.74,0.86,6,5,1);

INSERT INTO alert_rule_registry VALUES
('alert-water-level-high','water','water_level','greater_than',3.2,'high','hydrology_team',30,'field_response_and_public_notice','approved'),
('alert-coastal-temp-anomaly','coastal','water_temperature','z_score',2.5,'medium','coastal_team',60,'scientist_review','review_required'),
('alert-soil-moisture-low','soil','soil_moisture','less_than',18,'medium','agroecology_team',120,'irrigation_review','approved'),
('alert-pm25-high','air_quality','pm25','greater_than',35,'high','air_quality_team',30,'public_health_review','approved'),
('alert-stormwater-flow','infrastructure','flow_rate','greater_than',750,'high','stormwater_team',15,'maintenance_dispatch','review_required');
