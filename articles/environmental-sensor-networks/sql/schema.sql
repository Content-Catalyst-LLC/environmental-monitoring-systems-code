DROP TABLE IF EXISTS node_site_registry;
DROP TABLE IF EXISTS network_readiness_scores;
DROP TABLE IF EXISTS network_observation_records;
DROP TABLE IF EXISTS telemetry_delivery_records;
DROP TABLE IF EXISTS coverage_equity_audit;
DROP TABLE IF EXISTS alert_rule_registry;
DROP TABLE IF EXISTS network_governance_log;

CREATE TABLE node_site_registry (
  node_id TEXT PRIMARY KEY,
  network_id TEXT NOT NULL,
  domain TEXT NOT NULL,
  site_id TEXT NOT NULL,
  latitude REAL NOT NULL,
  longitude REAL NOT NULL,
  node_type TEXT NOT NULL,
  observed_property TEXT NOT NULL,
  unit TEXT NOT NULL,
  calibration_status TEXT NOT NULL,
  telemetry_mode TEXT NOT NULL,
  owner TEXT NOT NULL,
  high_stakes_use INTEGER NOT NULL,
  notes TEXT
);

CREATE TABLE network_readiness_scores (
  network_id TEXT PRIMARY KEY,
  domain TEXT NOT NULL,
  network_type TEXT NOT NULL,
  monitored_area_km2 REAL NOT NULL,
  target_area_km2 REAL NOT NULL,
  valid_time_steps INTEGER NOT NULL,
  expected_time_steps INTEGER NOT NULL,
  active_nodes INTEGER NOT NULL,
  deployed_nodes INTEGER NOT NULL,
  representativeness REAL NOT NULL,
  valid_data_share REAL NOT NULL,
  metadata_maturity REAL NOT NULL,
  observed_latency_minutes REAL NOT NULL,
  target_latency_minutes REAL NOT NULL,
  action_fit REAL NOT NULL,
  high_stakes_use INTEGER NOT NULL
);

CREATE TABLE network_observation_records (
  observation_id TEXT PRIMARY KEY,
  node_id TEXT NOT NULL,
  network_id TEXT NOT NULL,
  observed_property TEXT NOT NULL,
  value REAL NOT NULL,
  unit TEXT NOT NULL,
  phenomenon_time TEXT NOT NULL,
  result_time TEXT NOT NULL,
  ingested_at TEXT NOT NULL,
  quality_flag TEXT NOT NULL,
  calibration_status TEXT NOT NULL
);

CREATE TABLE telemetry_delivery_records (
  delivery_id TEXT PRIMARY KEY,
  node_id TEXT NOT NULL,
  network_id TEXT NOT NULL,
  window_start TEXT NOT NULL,
  window_end TEXT NOT NULL,
  expected_records INTEGER NOT NULL,
  delivered_records INTEGER NOT NULL,
  delayed_records INTEGER NOT NULL,
  dropped_records INTEGER NOT NULL,
  median_latency_minutes REAL NOT NULL,
  delivery_status TEXT NOT NULL
);

CREATE TABLE coverage_equity_audit (
  audit_id TEXT PRIMARY KEY,
  network_id TEXT NOT NULL,
  coverage_dimension TEXT NOT NULL,
  target_group_or_zone TEXT NOT NULL,
  coverage_score REAL NOT NULL,
  evidence_gap TEXT NOT NULL,
  priority TEXT NOT NULL,
  notes TEXT
);

CREATE TABLE alert_rule_registry (
  alert_rule_id TEXT PRIMARY KEY,
  network_id TEXT NOT NULL,
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

CREATE TABLE network_governance_log (
  governance_id TEXT PRIMARY KEY,
  date TEXT NOT NULL,
  network_id TEXT NOT NULL,
  decision TEXT NOT NULL,
  owner TEXT NOT NULL,
  status TEXT NOT NULL,
  public_note_required INTEGER NOT NULL
);

INSERT INTO node_site_registry VALUES
('node-river-001','river-watershed-network','water','river-mainstem-a',38.6270,-90.1994,'stage_sensor','water_level','m','valid','cellular','hydrology_team',1,'Mainstem river stage node'),
('node-river-002','river-watershed-network','water','tributary-b',38.7390,-90.2380,'turbidity_sensor','turbidity','ntu','valid','cellular','hydrology_team',1,'Tributary turbidity node'),
('node-air-001','urban-air-community-network','air_quality','urban-core-a',38.6350,-90.2200,'pm_sensor','pm25','ug_m3','review_required','wifi_cellular','air_quality_team',1,'Community PM sensor requiring calibration review'),
('node-coastal-001','coastal-buoy-network','coastal','coastal-bay-a',29.7604,-95.3698,'buoy','water_temperature','celsius','valid','satellite','coastal_team',1,'Coastal buoy with satellite telemetry'),
('node-eco-001','restoration-ecology-network','biodiversity','wetland-restoration-a',38.5700,-90.3000,'camera_trap','habitat_activity','count','valid','local_storage','ecology_team',0,'Wetland camera trap node');

INSERT INTO network_readiness_scores VALUES
('river-watershed-network','water','hydrological_sensor_network',820,1000,2740,2880,18,20,0.82,0.88,0.84,8,15,0.88,1),
('urban-air-community-network','air_quality','community_air_sensor_network',120,200,2540,2880,42,50,0.72,0.78,0.76,22,30,0.84,1),
('coastal-buoy-network','coastal','marine_observing_network',3100,5000,2200,2880,11,15,0.68,0.82,0.80,45,60,0.80,1),
('restoration-ecology-network','biodiversity','ecological_monitoring_network',45,60,1280,1440,24,30,0.74,0.76,0.70,240,360,0.72,0),
('stormwater-overflow-network','infrastructure','stormwater_sensor_network',60,100,2600,2880,15,22,0.64,0.74,0.72,6,10,0.86,1);

INSERT INTO network_observation_records VALUES
('obs-001','node-river-001','river-watershed-network','water_level',2.74,'m','2026-05-14T12:00:00Z','2026-05-14T12:00:05Z','2026-05-14T12:00:17Z','pass','valid'),
('obs-002','node-river-002','river-watershed-network','turbidity',18.2,'ntu','2026-05-14T12:00:00Z','2026-05-14T12:00:04Z','2026-05-14T12:00:19Z','pass','valid'),
('obs-003','node-air-001','urban-air-community-network','pm25',31.5,'ug_m3','2026-05-14T12:00:00Z','2026-05-14T12:00:04Z','2026-05-14T12:00:52Z','review_required','review_required'),
('obs-004','node-coastal-001','coastal-buoy-network','water_temperature',21.6,'celsius','2026-05-14T12:00:00Z','2026-05-14T12:00:08Z','2026-05-14T12:45:00Z','delayed','valid'),
('obs-005','node-eco-001','restoration-ecology-network','habitat_activity',1,'count','2026-05-14T04:32:00Z','2026-05-14T04:32:06Z','2026-05-15T12:00:00Z','delayed_local_storage','valid');

INSERT INTO telemetry_delivery_records VALUES
('del-001','node-river-001','river-watershed-network','2026-05-14T00:00:00Z','2026-05-15T00:00:00Z',288,286,2,0,0.25,'healthy'),
('del-002','node-air-001','urban-air-community-network','2026-05-14T00:00:00Z','2026-05-15T00:00:00Z',288,244,18,26,0.85,'review_required'),
('del-003','node-coastal-001','coastal-buoy-network','2026-05-14T00:00:00Z','2026-05-15T00:00:00Z',144,109,28,7,42.0,'delayed'),
('del-004','node-eco-001','restoration-ecology-network','2026-05-14T00:00:00Z','2026-05-15T00:00:00Z',24,12,12,0,1440.0,'local_storage_only');

INSERT INTO coverage_equity_audit VALUES
('audit-001','river-watershed-network','hydrological_gradient','ungauged_headwaters',0.62,'Headwater tributaries underrepresented','high','Add reference nodes or mobile survey support'),
('audit-002','urban-air-community-network','environmental_justice','near-road_low-income_corridors',0.58,'Street-level exposure gradients underrepresented','high','Expand community co-location and calibration support'),
('audit-003','coastal-buoy-network','estuarine_transition','shallow_estuary_zones',0.55,'Estuary transition zones weakly covered','medium','Add shallow-zone nodes'),
('audit-004','stormwater-overflow-network','infrastructure','underserved_neighborhoods',0.46,'Overflow and drainage monitoring uneven','high','Prioritize additional monitoring in underserved catchments');
