DROP TABLE IF EXISTS observation_platform_registry;
DROP TABLE IF EXISTS atmospheric_observations;
DROP TABLE IF EXISTS telemetry_latency_log;
DROP TABLE IF EXISTS quality_control_flags;
DROP TABLE IF EXISTS assimilation_readiness_records;
DROP TABLE IF EXISTS coverage_blindspot_audit;
DROP TABLE IF EXISTS forecast_use_log;
DROP TABLE IF EXISTS weather_sensing_readiness_scores;
DROP TABLE IF EXISTS weather_sensing_governance_log;

CREATE TABLE observation_platform_registry (
  platform_id TEXT PRIMARY KEY,
  platform_name TEXT,
  platform_type TEXT,
  owner TEXT,
  latitude REAL,
  longitude REAL,
  elevation_m TEXT,
  variables TEXT,
  update_frequency_minutes INTEGER,
  operational_status TEXT,
  assimilation_relevance TEXT,
  notes TEXT
);

CREATE TABLE atmospheric_observations (
  observation_id TEXT PRIMARY KEY,
  platform_id TEXT,
  observation_time TEXT,
  arrival_time TEXT,
  variable TEXT,
  value REAL,
  unit TEXT,
  latitude REAL,
  longitude REAL,
  platform_type TEXT,
  qc_flag TEXT,
  assimilation_eligible INTEGER
);

CREATE TABLE telemetry_latency_log (
  latency_id TEXT PRIMARY KEY,
  platform_id TEXT,
  window_start TEXT,
  window_end TEXT,
  expected_reports INTEGER,
  received_reports INTEGER,
  median_latency_minutes REAL,
  max_latency_minutes REAL,
  outage_minutes REAL,
  freshness_status TEXT
);

CREATE TABLE quality_control_flags (
  qc_id TEXT PRIMARY KEY,
  observation_id TEXT,
  platform_id TEXT,
  check_type TEXT,
  check_result TEXT,
  flag TEXT,
  severity TEXT,
  review_note TEXT
);

CREATE TABLE assimilation_readiness_records (
  assimilation_id TEXT PRIMARY KEY,
  observation_id TEXT,
  platform_id TEXT,
  cycle_time TEXT,
  metadata_complete INTEGER,
  qc_passed INTEGER,
  latency_within_budget INTEGER,
  format_supported INTEGER,
  error_model_available INTEGER,
  assimilable INTEGER,
  reason TEXT
);

CREATE TABLE coverage_blindspot_audit (
  audit_id TEXT PRIMARY KEY,
  program_id TEXT,
  coverage_dimension TEXT,
  target_zone_or_structure TEXT,
  coverage_score REAL,
  evidence_gap TEXT,
  priority TEXT,
  notes TEXT
);

CREATE TABLE forecast_use_log (
  forecast_use_id TEXT PRIMARY KEY,
  program_id TEXT,
  platform_id TEXT,
  workflow TEXT,
  forecast_cycle TEXT,
  decision_context TEXT,
  used INTEGER,
  status TEXT,
  notes TEXT
);

CREATE TABLE weather_sensing_readiness_scores (
  program_id TEXT PRIMARY KEY,
  operational_use TEXT,
  geography TEXT,
  observation_freshness REAL,
  spatial_coverage REAL,
  vertical_coverage REAL,
  qc_completeness REAL,
  assimilation_readiness REAL,
  representativeness REAL,
  uncertainty_communication REAL,
  governance_readiness REAL,
  high_stakes_use INTEGER
);

CREATE TABLE weather_sensing_governance_log (
  governance_id TEXT PRIMARY KEY,
  date TEXT,
  program_id TEXT,
  decision TEXT,
  owner TEXT,
  status TEXT,
  public_note_required INTEGER
);

INSERT INTO weather_sensing_readiness_scores VALUES
('surface-weather-network','public_forecast_and_aviation','regional_land_network',0.88,0.82,0.58,0.86,0.78,0.80,0.76,0.80,1),
('upper-air-profile-network','model_initialization_and_convective_forecasting','synoptic_profile_sites',0.78,0.70,0.82,0.84,0.80,0.72,0.78,0.76,1),
('radar-nowcasting-network','severe_weather_nowcasting','convective_risk_region',0.86,0.76,0.64,0.82,0.74,0.70,0.76,0.78,1),
('satellite-atmospheric-feed','remote_sensing_and_assimilation','broad_regional_domain',0.84,0.86,0.68,0.80,0.82,0.74,0.72,0.78,1),
('aircraft-observation-network','aviation_and_model_support','flight_corridors',0.80,0.74,0.72,0.78,0.76,0.68,0.72,0.74,1),
('marine-observation-network','marine_forecast_and_storm_tracking','coastal_and_ocean_region',0.72,0.62,0.52,0.76,0.68,0.64,0.72,0.74,1);

INSERT INTO telemetry_latency_log VALUES
('lat-001','met-001','2026-05-01T12:00:00Z','2026-05-01T13:00:00Z',12,12,2,3,0,'pass'),
('lat-002','met-002','2026-05-01T12:00:00Z','2026-05-01T13:00:00Z',60,59,1,4,1,'pass'),
('lat-003','met-003','2026-05-01T00:00:00Z','2026-05-01T12:00:00Z',1,1,24,24,0,'pass'),
('lat-004','met-004','2026-05-01T12:00:00Z','2026-05-01T13:00:00Z',12,11,3,9,5,'review_required'),
('lat-005','met-005','2026-05-01T12:00:00Z','2026-05-01T13:00:00Z',6,6,8,10,0,'pass'),
('lat-006','met-007','2026-05-01T12:00:00Z','2026-05-01T13:00:00Z',2,1,45,45,30,'review_required');

INSERT INTO assimilation_readiness_records VALUES
('assim-001','obs-001','met-001','2026-05-01T12:00:00Z',1,1,1,1,1,1,'Surface observation ready'),
('assim-002','obs-002','met-001','2026-05-01T12:00:00Z',1,1,1,1,1,1,'Wind observation ready'),
('assim-003','obs-003','met-002','2026-05-01T12:00:00Z',1,1,1,1,1,1,'Aviation observation ready'),
('assim-004','obs-004','met-003','2026-05-01T12:00:00Z',1,1,1,1,1,1,'Upper-air profile ready'),
('assim-005','obs-005','met-004','2026-05-01T12:00:00Z',1,1,1,1,1,1,'Radar feature ready for nowcast use'),
('assim-006','obs-006','met-005','2026-05-01T12:00:00Z',1,1,1,1,1,1,'Satellite retrieval ready with uncertainty caveat'),
('assim-007','obs-007','met-007','2026-05-01T12:00:00Z',1,0,0,1,1,0,'Stale buoy report flagged for review');
