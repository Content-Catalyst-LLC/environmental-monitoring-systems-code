DROP TABLE IF EXISTS gauge_sensor_registry;
DROP TABLE IF EXISTS hydrometeorological_driver_matrix;
DROP TABLE IF EXISTS telemetry_status_records;
DROP TABLE IF EXISTS flood_observation_records;
DROP TABLE IF EXISTS threshold_impact_registry;
DROP TABLE IF EXISTS inundation_map_linkage;
DROP TABLE IF EXISTS warning_response_log;
DROP TABLE IF EXISTS coverage_equity_audit;
DROP TABLE IF EXISTS flood_monitoring_readiness_scores;
DROP TABLE IF EXISTS flood_monitoring_governance_log;

CREATE TABLE gauge_sensor_registry (
  station_id TEXT PRIMARY KEY,
  station_name TEXT,
  station_type TEXT,
  water_body_or_basin TEXT,
  geography TEXT,
  latitude REAL,
  longitude REAL,
  observed_variable TEXT,
  unit TEXT,
  telemetry_interval_minutes INTEGER,
  rating_status TEXT,
  owner TEXT
);

CREATE TABLE hydrometeorological_driver_matrix (
  driver_id TEXT PRIMARY KEY,
  driver_name TEXT,
  flood_mechanism TEXT,
  measurement_sources TEXT,
  decision_relevance TEXT,
  primary_uncertainty TEXT
);

CREATE TABLE telemetry_status_records (
  telemetry_id TEXT PRIMARY KEY,
  station_id TEXT,
  window_start TEXT,
  window_end TEXT,
  expected_observations INTEGER,
  received_observations INTEGER,
  median_latency_seconds REAL,
  max_latency_seconds REAL,
  outage_minutes REAL,
  status TEXT
);

CREATE TABLE flood_observation_records (
  record_id TEXT PRIMARY KEY,
  station_id TEXT,
  timestamp TEXT,
  observed_variable TEXT,
  value REAL,
  unit TEXT,
  quality_flag TEXT,
  event_context TEXT
);

CREATE TABLE threshold_impact_registry (
  threshold_id TEXT PRIMARY KEY,
  station_id TEXT,
  threshold_name TEXT,
  stage_ft REAL,
  impact_description TEXT,
  response_action TEXT,
  severity TEXT,
  review_status TEXT
);

CREATE TABLE inundation_map_linkage (
  map_id TEXT PRIMARY KEY,
  station_id TEXT,
  stage_ft REAL,
  map_product TEXT,
  exposed_assets TEXT,
  known_caveat TEXT,
  readiness_score REAL
);

CREATE TABLE warning_response_log (
  response_id TEXT PRIMARY KEY,
  event_id TEXT,
  warning_time TEXT,
  expected_impact_time TEXT,
  warning_type TEXT,
  channel TEXT,
  response_action TEXT,
  owner TEXT,
  status TEXT,
  notes TEXT
);

CREATE TABLE coverage_equity_audit (
  audit_id TEXT PRIMARY KEY,
  program_id TEXT,
  coverage_dimension TEXT,
  target_group_or_zone TEXT,
  coverage_score REAL,
  evidence_gap TEXT,
  priority TEXT,
  notes TEXT
);

CREATE TABLE flood_monitoring_readiness_scores (
  program_id TEXT PRIMARY KEY,
  flood_type TEXT,
  geography TEXT,
  gauge_coverage REAL,
  rainfall_coverage REAL,
  telemetry_completeness REAL,
  forecast_confidence REAL,
  inundation_map_readiness REAL,
  protective_lead_time REAL,
  communication_readiness REAL,
  response_capacity REAL,
  governance_readiness REAL,
  high_stakes_use INTEGER
);

CREATE TABLE flood_monitoring_governance_log (
  governance_id TEXT PRIMARY KEY,
  date TEXT,
  program_id TEXT,
  decision TEXT,
  owner TEXT,
  status TEXT,
  public_note_required INTEGER
);

INSERT INTO flood_monitoring_readiness_scores VALUES
('mainstem-river-forecast-system','riverine','large_river_basin',0.86,0.80,0.91,0.82,0.78,0.84,0.80,0.82,0.84,1),
('urban-flash-flood-warning','flash_flood','urban_catchments',0.64,0.78,0.82,0.68,0.62,0.58,0.76,0.70,0.74,1),
('reservoir-regulated-river-monitoring','regulated_river','reservoir_downstream_reach',0.80,0.76,0.88,0.78,0.74,0.80,0.78,0.76,0.80,1),
('rural-ungauged-basin-screening','flash_flood','rural_tributaries',0.52,0.66,0.70,0.62,0.50,0.54,0.68,0.62,0.66,1),
('compound-coastal-river-monitoring','compound_flood','coastal_river_zone',0.70,0.74,0.82,0.70,0.68,0.66,0.72,0.70,0.74,1);

INSERT INTO telemetry_status_records VALUES
('tel-001','gage-001','2026-05-01T00:00:00Z','2026-05-01T12:00:00Z',48,48,40,75,0,'pass'),
('tel-002','gage-002','2026-05-01T00:00:00Z','2026-05-01T12:00:00Z',48,45,55,210,15,'review_required'),
('tel-003','rain-001','2026-05-01T00:00:00Z','2026-05-01T12:00:00Z',144,140,25,95,0,'pass'),
('tel-004','rain-002','2026-05-01T00:00:00Z','2026-05-01T12:00:00Z',48,40,80,600,60,'review_required');

INSERT INTO threshold_impact_registry VALUES
('thr-001','gage-001','action_stage',18.0,'Low-lying roads begin monitoring status','activate_monitoring','medium','approved'),
('thr-002','gage-001','flood_stage',20.0,'Minor flooding near riverfront roads','issue_public_warning','high','approved'),
('thr-003','gage-001','major_flood_stage',25.0,'Residential evacuation zones at risk','evacuation_support','extreme','approved'),
('thr-004','gage-002','tributary_flash_threshold',9.0,'Rapid tributary flooding possible near low-water crossings','road_closure_review','high','review_required');
