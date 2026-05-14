DROP TABLE IF EXISTS climate_observation_platform_registry;
DROP TABLE IF EXISTS metadata_provenance_registry;
DROP TABLE IF EXISTS calibration_intercomparison_log;
DROP TABLE IF EXISTS climate_observation_records;
DROP TABLE IF EXISTS homogenization_adjustment_log;
DROP TABLE IF EXISTS climate_data_record_manifest;
DROP TABLE IF EXISTS climate_indicator_anomaly_table;
DROP TABLE IF EXISTS coverage_continuity_audit;
DROP TABLE IF EXISTS climate_monitoring_readiness_scores;
DROP TABLE IF EXISTS climate_monitoring_governance_log;

CREATE TABLE climate_observation_platform_registry (
  platform_id TEXT PRIMARY KEY,
  platform_name TEXT,
  platform_type TEXT,
  domain TEXT,
  owner TEXT,
  latitude REAL,
  longitude REAL,
  start_year INTEGER,
  end_year TEXT,
  variables TEXT,
  operational_status TEXT,
  continuity_role TEXT,
  notes TEXT
);

CREATE TABLE metadata_provenance_registry (
  metadata_id TEXT PRIMARY KEY,
  platform_id TEXT,
  metadata_type TEXT,
  metadata_status TEXT,
  record_owner TEXT,
  last_reviewed TEXT,
  critical_gap INTEGER,
  notes TEXT
);

CREATE TABLE calibration_intercomparison_log (
  calibration_id TEXT PRIMARY KEY,
  platform_id TEXT,
  event_date TEXT,
  event_type TEXT,
  reference_standard_or_overlap TEXT,
  result TEXT,
  status TEXT,
  notes TEXT
);

CREATE TABLE climate_observation_records (
  observation_id TEXT PRIMARY KEY,
  platform_id TEXT,
  observation_date TEXT,
  domain TEXT,
  climate_variable TEXT,
  value REAL,
  unit TEXT,
  qc_flag TEXT,
  record_stage TEXT,
  provenance_id TEXT
);

CREATE TABLE homogenization_adjustment_log (
  adjustment_id TEXT PRIMARY KEY,
  platform_id TEXT,
  climate_variable TEXT,
  breakpoint_date TEXT,
  breakpoint_type TEXT,
  adjustment_method TEXT,
  adjustment_value REAL,
  unit TEXT,
  uncertainty_effect TEXT,
  status TEXT,
  notes TEXT
);

CREATE TABLE climate_data_record_manifest (
  record_id TEXT PRIMARY KEY,
  record_title TEXT,
  domain TEXT,
  climate_variable TEXT,
  version TEXT,
  baseline_start INTEGER,
  baseline_end INTEGER,
  record_start INTEGER,
  record_end INTEGER,
  processing_status TEXT,
  uncertainty_statement TEXT,
  citation_required INTEGER
);

CREATE TABLE climate_indicator_anomaly_table (
  indicator_id TEXT PRIMARY KEY,
  record_id TEXT,
  year INTEGER,
  climate_variable TEXT,
  value REAL,
  baseline_mean REAL,
  anomaly REAL,
  unit TEXT,
  trend_ready INTEGER,
  notes TEXT
);

CREATE TABLE coverage_continuity_audit (
  audit_id TEXT PRIMARY KEY,
  program_id TEXT,
  domain TEXT,
  coverage_dimension TEXT,
  target_zone_or_record TEXT,
  coverage_score REAL,
  evidence_gap TEXT,
  priority TEXT,
  notes TEXT
);

CREATE TABLE climate_monitoring_readiness_scores (
  program_id TEXT PRIMARY KEY,
  domain TEXT,
  climate_variable TEXT,
  record_continuity REAL,
  metadata_completeness REAL,
  calibration_quality REAL,
  homogenization_readiness REAL,
  spatial_coverage REAL,
  version_control REAL,
  uncertainty_communication REAL,
  governance_readiness REAL,
  high_stakes_use INTEGER
);

CREATE TABLE climate_monitoring_governance_log (
  governance_id TEXT PRIMARY KEY,
  date TEXT,
  program_id TEXT,
  decision TEXT,
  owner TEXT,
  status TEXT,
  public_note_required INTEGER
);

INSERT INTO climate_monitoring_readiness_scores VALUES
('surface-temperature-reference-network','atmosphere','surface_temperature',0.92,0.88,0.90,0.86,0.78,0.84,0.82,0.86,1),
('historical-surface-temperature-network','atmosphere','surface_temperature',0.82,0.70,0.78,0.72,0.76,0.78,0.74,0.78,1),
('ocean-heat-content-network','ocean','ocean_heat_content',0.78,0.80,0.84,0.76,0.68,0.82,0.78,0.80,1),
('coastal-sea-level-network','ocean','sea_level',0.84,0.74,0.76,0.70,0.72,0.76,0.74,0.76,1),
('cryosphere-mass-balance-program','cryosphere','glacier_mass_balance',0.72,0.76,0.78,0.74,0.62,0.76,0.74,0.78,1),
('land-biosphere-carbon-observation','land_biosphere','vegetation_carbon_flux',0.70,0.72,0.74,0.70,0.66,0.72,0.70,0.74,1),
('satellite-land-temperature-record','land','land_surface_temperature',0.86,0.82,0.80,0.78,0.88,0.84,0.76,0.80,1);

INSERT INTO climate_indicator_anomaly_table VALUES
('ind-001','cdr-001',2021,'surface_temperature',12.8,11.9,0.9,'degC',1,'Reference record anomaly'),
('ind-002','cdr-001',2022,'surface_temperature',13.1,11.9,1.2,'degC',1,'Reference record anomaly'),
('ind-003','cdr-001',2023,'surface_temperature',13.4,11.9,1.5,'degC',1,'Reference record anomaly'),
('ind-004','cdr-003',2023,'ocean_heat_content',13.2,10.8,2.4,'relative_index',1,'Ocean heat index anomaly'),
('ind-005','cdr-004',2023,'sea_level',0.38,0.21,0.17,'m',0,'Datum review pending'),
('ind-006','cdr-005',2025,'glacier_mass_balance',-0.82,-0.34,-0.48,'m_water_equivalent',0,'Method transition caveat'),
('ind-007','cdr-006',2023,'land_surface_temperature',15.6,14.2,1.4,'degC',1,'Satellite land-surface anomaly');

INSERT INTO homogenization_adjustment_log VALUES
('adj-001','clim-002','surface_temperature','1984-06-01','station_relocation','neighbor_reference_adjustment',0.18,'degC','increases_uncertainty','review_required','Station move detected'),
('adj-002','clim-002','surface_temperature','1999-09-01','instrument_change','pairwise_homogenization',-0.08,'degC','minor','pass','Instrument transition adjusted'),
('adj-003','clim-004','sea_level','2007-01-01','datum_change','datum_reconciliation',0.012,'m','increases_uncertainty','review_required','Datum shift needs documentation'),
('adj-004','clim-005','glacier_mass_balance','2018-08-01','method_change','method_transition_caveat',0.00,'m_water_equivalent','increases_uncertainty','review_required','Field method changed'),
('adj-005','clim-007','land_surface_temperature','2012-01-01','satellite_mission_transition','cross_mission_intercalibration',0.05,'degC','minor','pass','Satellite mission overlap correction');
