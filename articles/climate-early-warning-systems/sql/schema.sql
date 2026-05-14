DROP TABLE IF EXISTS hazard_monitoring_registry;
DROP TABLE IF EXISTS forecast_records;
DROP TABLE IF EXISTS exposure_vulnerability_matrix;
DROP TABLE IF EXISTS impact_threshold_registry;
DROP TABLE IF EXISTS warning_decision_log;
DROP TABLE IF EXISTS communication_channel_registry;
DROP TABLE IF EXISTS preparedness_action_log;
DROP TABLE IF EXISTS coverage_inclusion_audit;
DROP TABLE IF EXISTS early_warning_readiness_scores;
DROP TABLE IF EXISTS early_warning_governance_log;

CREATE TABLE hazard_monitoring_registry (
  source_id TEXT PRIMARY KEY,
  hazard_type TEXT,
  source_name TEXT,
  monitoring_type TEXT,
  geography TEXT,
  update_frequency_minutes INTEGER,
  lead_indicator TEXT,
  quality_status TEXT,
  owner TEXT,
  notes TEXT
);

CREATE TABLE forecast_records (
  forecast_id TEXT PRIMARY KEY,
  hazard_type TEXT,
  program_id TEXT,
  forecast_issue_time TEXT,
  valid_start TEXT,
  valid_end TEXT,
  forecast_horizon_hours REAL,
  forecast_confidence REAL,
  expected_impact_time TEXT,
  uncertainty_note TEXT,
  status TEXT
);

CREATE TABLE exposure_vulnerability_matrix (
  risk_id TEXT PRIMARY KEY,
  program_id TEXT,
  hazard_type TEXT,
  geography TEXT,
  at_risk_population INTEGER,
  critical_assets TEXT,
  vulnerability_factors TEXT,
  response_constraints TEXT,
  exposure_score REAL,
  vulnerability_score REAL
);

CREATE TABLE impact_threshold_registry (
  threshold_id TEXT PRIMARY KEY,
  program_id TEXT,
  hazard_type TEXT,
  indicator TEXT,
  threshold_value REAL,
  unit TEXT,
  warning_level TEXT,
  impact_statement TEXT,
  response_action TEXT,
  review_status TEXT
);

CREATE TABLE warning_decision_log (
  decision_id TEXT PRIMARY KEY,
  program_id TEXT,
  hazard_type TEXT,
  forecast_id TEXT,
  decision_time TEXT,
  expected_impact_time TEXT,
  warning_level TEXT,
  authority TEXT,
  protective_lead_time_hours REAL,
  uncertainty_statement TEXT,
  issued INTEGER,
  status TEXT
);

CREATE TABLE communication_channel_registry (
  channel_id TEXT PRIMARY KEY,
  program_id TEXT,
  channel_type TEXT,
  channel_name TEXT,
  coverage_estimate REAL,
  language_access TEXT,
  accessibility_support TEXT,
  fallback_available INTEGER,
  status TEXT,
  notes TEXT
);

CREATE TABLE preparedness_action_log (
  action_id TEXT PRIMARY KEY,
  program_id TEXT,
  warning_id TEXT,
  action_time TEXT,
  action_type TEXT,
  owner TEXT,
  target_population TEXT,
  status TEXT,
  notes TEXT
);

CREATE TABLE coverage_inclusion_audit (
  audit_id TEXT PRIMARY KEY,
  program_id TEXT,
  coverage_dimension TEXT,
  target_group_or_zone TEXT,
  coverage_score REAL,
  evidence_gap TEXT,
  priority TEXT,
  notes TEXT
);

CREATE TABLE early_warning_readiness_scores (
  program_id TEXT PRIMARY KEY,
  hazard_type TEXT,
  geography TEXT,
  forecast_confidence REAL,
  risk_knowledge REAL,
  protective_lead_time REAL,
  communication_reach REAL,
  action_capacity REAL,
  trust_readiness REAL,
  inclusion_capacity REAL,
  governance_readiness REAL,
  high_stakes_use INTEGER
);

CREATE TABLE early_warning_governance_log (
  governance_id TEXT PRIMARY KEY,
  date TEXT,
  program_id TEXT,
  decision TEXT,
  owner TEXT,
  status TEXT,
  public_note_required INTEGER
);

INSERT INTO early_warning_readiness_scores VALUES
('flash-flood-early-warning','flood','urban_and_riverine_basins',0.80,0.76,0.72,0.82,0.78,0.76,0.74,0.78,1),
('heat-health-warning-system','heat','metropolitan_region',0.84,0.78,0.86,0.80,0.70,0.72,0.68,0.76,1),
('drought-anticipatory-action','drought','agricultural_livelihood_zone',0.74,0.72,0.82,0.68,0.66,0.70,0.72,0.70,1),
('coastal-compound-risk-warning','compound_coastal','coastal_communities',0.76,0.68,0.70,0.74,0.72,0.70,0.66,0.72,1),
('wildfire-readiness-warning','wildfire','forest_interface',0.78,0.74,0.76,0.76,0.70,0.72,0.70,0.74,1);

INSERT INTO warning_decision_log VALUES
('warn-001','flash-flood-early-warning','flood','fcst-001','2026-05-01T08:20:00Z','2026-05-01T10:00:00Z','warning','emergency_management',1.67,'Placement uncertainty but high consequence near underpasses',1,'open'),
('warn-002','heat-health-warning-system','heat','fcst-002','2026-05-02T09:00:00Z','2026-05-02T18:00:00Z','warning','public_health_department',9.0,'Neighborhood exposure and cooling access vary',1,'open'),
('warn-003','drought-anticipatory-action','drought','fcst-003','2026-05-05T00:00:00Z','2026-06-01T00:00:00Z','early_action','climate_risk_committee',648.0,'Slow-onset risk with seasonal forecast uncertainty',1,'open'),
('warn-004','coastal-compound-risk-warning','compound_coastal','fcst-004','2026-05-04T12:00:00Z','2026-05-04T22:00:00Z','watch','coastal_emergency_team',10.0,'Compound timing uncertainty remains',1,'open');

INSERT INTO communication_channel_registry VALUES
('chan-001','flash-flood-early-warning','mobile','wireless_emergency_alerts',0.78,'english_spanish','basic_text',1,'active','Fast public alert channel'),
('chan-002','flash-flood-early-warning','broadcast','local_radio_and_tv',0.72,'english_spanish','audio_captioning',1,'active','Broadcast redundancy'),
('chan-003','heat-health-warning-system','community','public_health_outreach_network',0.64,'multilingual','phone_and_door_to_door',1,'active','Supports older adults and isolated residents'),
('chan-004','drought-anticipatory-action','institutional','agricultural_extension_sms',0.60,'local_languages','text_and_field_agent',1,'review_required','Needs stronger registration coverage'),
('chan-005','coastal-compound-risk-warning','siren','coastal_siren_network',0.58,'not_language_specific','audible_only',1,'review_required','Accessibility limitations for hearing impaired residents');
