DROP TABLE IF EXISTS air_quality_sensor_registry;
DROP TABLE IF EXISTS pollutant_observation_records;
DROP TABLE IF EXISTS calibration_collocation_log;
DROP TABLE IF EXISTS air_quality_qc_flags;
DROP TABLE IF EXISTS meteorological_context;
DROP TABLE IF EXISTS exposure_equity_layer;
DROP TABLE IF EXISTS dashboard_alert_records;
DROP TABLE IF EXISTS air_quality_monitoring_readiness_scores;
DROP TABLE IF EXISTS air_quality_governance_log;

CREATE TABLE air_quality_sensor_registry (
  sensor_id TEXT PRIMARY KEY,
  sensor_name TEXT,
  platform_type TEXT,
  instrument_class TEXT,
  owner TEXT,
  latitude REAL,
  longitude REAL,
  height_m TEXT,
  pollutants TEXT,
  update_frequency_minutes INTEGER,
  operational_status TEXT,
  valid_use TEXT,
  notes TEXT
);

CREATE TABLE pollutant_observation_records (
  observation_id TEXT PRIMARY KEY,
  sensor_id TEXT,
  observation_time TEXT,
  arrival_time TEXT,
  pollutant TEXT,
  value REAL,
  unit TEXT,
  averaging_period_minutes INTEGER,
  qc_flag TEXT,
  calibration_status TEXT,
  meteorological_context_id TEXT
);

CREATE TABLE calibration_collocation_log (
  calibration_id TEXT PRIMARY KEY,
  sensor_id TEXT,
  event_date TEXT,
  event_type TEXT,
  reference_sensor TEXT,
  result TEXT,
  correction_method TEXT,
  status TEXT,
  notes TEXT
);

CREATE TABLE air_quality_qc_flags (
  qc_id TEXT PRIMARY KEY,
  observation_id TEXT,
  sensor_id TEXT,
  check_type TEXT,
  check_result TEXT,
  flag TEXT,
  severity TEXT,
  review_note TEXT
);

CREATE TABLE meteorological_context (
  meteorological_context_id TEXT PRIMARY KEY,
  timestamp TEXT,
  wind_speed_m_s REAL,
  wind_direction_deg REAL,
  temperature_c REAL,
  relative_humidity_percent REAL,
  boundary_layer_context TEXT,
  dispersion_condition TEXT,
  notes TEXT
);

CREATE TABLE exposure_equity_layer (
  exposure_id TEXT PRIMARY KEY,
  program_id TEXT,
  geography TEXT,
  population_group TEXT,
  source_context TEXT,
  exposure_relevance_score REAL,
  vulnerability_score REAL,
  monitoring_coverage_score REAL,
  priority TEXT,
  notes TEXT
);

CREATE TABLE dashboard_alert_records (
  alert_id TEXT PRIMARY KEY,
  program_id TEXT,
  pollutant TEXT,
  threshold_type TEXT,
  threshold_value REAL,
  unit TEXT,
  geography TEXT,
  message_type TEXT,
  status TEXT,
  public_caveat TEXT
);

CREATE TABLE air_quality_monitoring_readiness_scores (
  program_id TEXT PRIMARY KEY,
  monitoring_purpose TEXT,
  geography TEXT,
  pollutant_focus TEXT,
  calibration_quality REAL,
  data_completeness REAL,
  spatial_coverage REAL,
  temporal_coverage REAL,
  meteorological_context REAL,
  exposure_relevance REAL,
  uncertainty_communication REAL,
  governance_readiness REAL,
  high_stakes_use INTEGER
);

CREATE TABLE air_quality_governance_log (
  governance_id TEXT PRIMARY KEY,
  date TEXT,
  program_id TEXT,
  decision TEXT,
  owner TEXT,
  status TEXT,
  public_note_required INTEGER
);

INSERT INTO air_quality_monitoring_readiness_scores VALUES
('reference-regulatory-network','compliance_and_long_term_trends','regional_air_district','PM2.5_O3_NO2_SO2_CO',0.92,0.88,0.70,0.86,0.78,0.72,0.82,0.86,1),
('community-sensor-network','neighborhood_hotspot_visibility','near_road_and_industrial_corridors','PM2.5_NO2',0.72,0.80,0.86,0.78,0.72,0.82,0.74,0.76,1),
('mobile-monitoring-program','spatial_gradient_mapping','urban_freight_and_port_corridors','NO2_black_carbon_PM2.5',0.78,0.70,0.88,0.66,0.76,0.84,0.72,0.74,1),
('wildfire-smoke-monitoring','public_health_advisory','regional_smoke_exposure_zone','PM2.5',0.80,0.76,0.74,0.82,0.84,0.76,0.78,0.80,1),
('satellite-regional-monitoring','regional_context_and_smoke_tracking','regional_domain','AOD_PM2.5_proxy',0.76,0.74,0.84,0.72,0.80,0.66,0.74,0.78,1),
('industrial-corridor-screening','industrial_oversight_and_hotspot_detection','industrial_corridor','SO2_NO2_PM2.5',0.74,0.72,0.78,0.70,0.74,0.82,0.72,0.76,1);

INSERT INTO pollutant_observation_records VALUES
('obs-001','aq-001','2026-05-01T12:00:00Z','2026-05-01T12:05:00Z','PM2.5',11.4,'ug_m3',60,'pass','current','met-001'),
('obs-002','aq-002','2026-05-01T12:00:00Z','2026-05-01T12:05:00Z','O3',58,'ppb',60,'pass','current','met-001'),
('obs-003','aq-003','2026-05-01T12:05:00Z','2026-05-01T12:07:00Z','NO2',41,'ppb',5,'pass','current','met-002'),
('obs-004','aq-004','2026-05-01T12:05:00Z','2026-05-01T12:06:00Z','PM2.5',18.8,'ug_m3',1,'review_required','collocation_pending','met-002'),
('obs-005','aq-005','2026-05-01T12:10:00Z','2026-05-01T12:11:00Z','black_carbon',2.8,'ug_m3',1,'pass','current','met-003'),
('obs-006','aq-006','2026-05-01T00:00:00Z','2026-05-01T03:00:00Z','AOD_PM2.5_proxy',0.42,'index',1440,'pass','retrieval_validated','met-004'),
('obs-007','aq-007','2026-05-01T12:05:00Z','2026-05-01T12:06:00Z','PM2.5',36.5,'ug_m3',1,'pass','current','met-005');

INSERT INTO calibration_collocation_log VALUES
('cal-001','aq-001','2026-01-15','annual_calibration','reference_lab','within_tolerance','none','pass','Reference station calibration current'),
('cal-002','aq-002','2026-01-20','annual_calibration','reference_lab','within_tolerance','none','pass','Ozone station calibration current'),
('cal-003','aq-003','2026-02-01','quarterly_audit','reference_lab','within_tolerance','none','pass','Near-road monitor audit passed'),
('cal-004','aq-004','2026-04-01','collocation','aq-001','bias_detected','linear_correction','review_required','Community sensor correction still under review'),
('cal-005','aq-005','2026-03-15','field_validation','aq-003','within_tolerance','route_normalization','pass','Mobile platform validated for transect work'),
('cal-006','aq-006','2026-03-30','satellite_surface_validation','aq-001','moderate_agreement','regional_bias_correction','pass','Satellite proxy valid for regional context'),
('cal-007','aq-007','2026-04-20','smoke_event_collocation','aq-001','within_tolerance','smoke_specific_correction','pass','Supplemental smoke sensor validated for event guidance');
