DROP TABLE IF EXISTS site_station_registry;
DROP TABLE IF EXISTS parameter_method_registry;
DROP TABLE IF EXISTS sensor_calibration_log;
DROP TABLE IF EXISTS sampling_event_log;
DROP TABLE IF EXISTS laboratory_results;
DROP TABLE IF EXISTS hydrology_load_linkage;
DROP TABLE IF EXISTS assessment_threshold_registry;
DROP TABLE IF EXISTS water_quality_monitoring_readiness_scores;
DROP TABLE IF EXISTS water_quality_governance_log;

CREATE TABLE site_station_registry (
  site_id TEXT PRIMARY KEY,
  station_name TEXT,
  waterbody_type TEXT,
  waterbody_name TEXT,
  watershed_position TEXT,
  latitude REAL,
  longitude REAL,
  depth_m REAL,
  designated_use TEXT,
  agency TEXT,
  telemetry_status TEXT,
  notes TEXT
);

CREATE TABLE parameter_method_registry (
  parameter_id TEXT PRIMARY KEY,
  parameter_name TEXT,
  unit TEXT,
  method_type TEXT,
  method_or_instrument TEXT,
  detection_limit TEXT,
  valid_use TEXT,
  proxy_status TEXT,
  confirmation_required INTEGER
);

CREATE TABLE sensor_calibration_log (
  calibration_id TEXT PRIMARY KEY,
  site_id TEXT,
  parameter_id TEXT,
  event_date TEXT,
  event_type TEXT,
  standard_or_method TEXT,
  result TEXT,
  technician TEXT,
  notes TEXT
);

CREATE TABLE sampling_event_log (
  sample_id TEXT PRIMARY KEY,
  site_id TEXT,
  sample_datetime TEXT,
  sample_type TEXT,
  event_context TEXT,
  depth_m REAL,
  preservation TEXT,
  chain_of_custody INTEGER,
  collector TEXT,
  quality_flag TEXT
);

CREATE TABLE laboratory_results (
  lab_result_id TEXT PRIMARY KEY,
  sample_id TEXT,
  site_id TEXT,
  parameter_id TEXT,
  result_value REAL,
  unit TEXT,
  method_code TEXT,
  detection_limit REAL,
  qualifier TEXT,
  lab_qaqc_flag TEXT,
  result_status TEXT
);

CREATE TABLE hydrology_load_linkage (
  link_id TEXT PRIMARY KEY,
  site_id TEXT,
  sample_id TEXT,
  timestamp TEXT,
  flow_m3_s REAL,
  stage_m REAL,
  event_flag TEXT,
  concentration_parameter TEXT,
  concentration_value REAL,
  concentration_unit TEXT,
  instantaneous_load_kg_day REAL,
  load_method TEXT,
  quality_flag TEXT
);

CREATE TABLE assessment_threshold_registry (
  threshold_id TEXT PRIMARY KEY,
  parameter_id TEXT,
  waterbody_type TEXT,
  decision_use TEXT,
  threshold_value REAL,
  unit TEXT,
  threshold_type TEXT,
  source_or_basis TEXT,
  response_action TEXT,
  review_status TEXT
);

CREATE TABLE water_quality_monitoring_readiness_scores (
  program_id TEXT PRIMARY KEY,
  waterbody_type TEXT,
  decision_use TEXT,
  sampling_representativeness REAL,
  analytical_validity REAL,
  hydrological_context REAL,
  qaqc_completeness REAL,
  load_readiness REAL,
  threshold_alignment REAL,
  uncertainty_communication REAL,
  data_interoperability REAL,
  governance_readiness REAL,
  high_stakes_use INTEGER
);

CREATE TABLE water_quality_governance_log (
  governance_id TEXT PRIMARY KEY,
  date TEXT,
  program_id TEXT,
  decision TEXT,
  owner TEXT,
  status TEXT,
  public_note_required INTEGER
);

INSERT INTO water_quality_monitoring_readiness_scores VALUES
('ambient-river-quality-network','river','ambient_condition_and_trends',0.78,0.84,0.82,0.88,0.76,0.80,0.78,0.82,0.80,1),
('storm-event-nutrient-program','watershed','event_load_estimation',0.72,0.82,0.86,0.80,0.68,0.76,0.74,0.72,0.76,1),
('recreational-microbial-advisory','recreational_water','public_health_advisory',0.70,0.78,0.66,0.82,0.52,0.84,0.76,0.74,0.78,1),
('continuous-source-water-sensors','source_water','treatment_operations',0.76,0.74,0.80,0.70,0.62,0.72,0.70,0.78,0.76,1),
('groundwater-emerging-contaminant-screening','groundwater','source_water_and_public_health_screening',0.68,0.76,0.60,0.74,0.50,0.70,0.68,0.70,0.72,1);

INSERT INTO hydrology_load_linkage VALUES
('load-001','wq-001','samp-001','2026-05-01T09:00:00Z',42.0,3.2,'baseflow','no3',2.4,'mg_L',8709.12,'paired_sample_flow','pass'),
('load-002','wq-001','samp-001','2026-05-01T09:00:00Z',42.0,3.2,'baseflow','tp',0.06,'mg_L',217.73,'paired_sample_flow','pass'),
('load-003','wq-002','samp-002','2026-05-01T13:00:00Z',18.0,1.4,'storm_event','no3',5.8,'mg_L',9020.16,'autosampler_flow_paired','pass'),
('load-004','wq-002','samp-002','2026-05-01T13:00:00Z',18.0,1.4,'storm_event','tp',0.22,'mg_L',342.14,'autosampler_flow_paired','review_required');

INSERT INTO laboratory_results VALUES
('lab-001','samp-001','wq-001','no3',2.4,'mg_L','IC_NO3_300',0.05,'','pass','final'),
('lab-002','samp-001','wq-001','tp',0.06,'mg_L','TP_COLOR_365',0.01,'','pass','final'),
('lab-003','samp-002','wq-002','no3',5.8,'mg_L','IC_NO3_300',0.05,'','pass','final'),
('lab-004','samp-002','wq-002','tp',0.22,'mg_L','TP_COLOR_365',0.01,'','review_required','provisional'),
('lab-006','samp-004','wq-005','ecoli',420,'CFU_100mL','ECOLI_METHOD',1,'','pass','final'),
('lab-007','samp-005','wq-006','no3',8.7,'mg_L','IC_NO3_300',0.05,'','review_required','provisional');

INSERT INTO assessment_threshold_registry VALUES
('thr-001','do','river','aquatic_life',5.0,'mg_L','below','illustrative_aquatic_life_screen','review_habitat_stress','approved'),
('thr-002','turb','stream','stormwater_assessment',100,'NTU','above','local_screening_threshold','trigger_storm_event_review','review_required'),
('thr-003','no3','groundwater','drinking_water_source',10.0,'mg_L','above','drinking_water_screening_value','source_water_review','approved'),
('thr-004','ecoli','recreational_water','public_health_advisory',235,'CFU_100mL','above','recreational_single_sample_screen','issue_or_review_advisory','approved');
