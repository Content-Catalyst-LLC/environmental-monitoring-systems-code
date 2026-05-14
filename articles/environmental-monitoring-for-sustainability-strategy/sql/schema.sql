DROP TABLE IF EXISTS indicator_registry;
DROP TABLE IF EXISTS baselines_targets_thresholds;
DROP TABLE IF EXISTS tradeoff_register;
DROP TABLE IF EXISTS accountability_log;
DROP TABLE IF EXISTS feedback_rules;

CREATE TABLE indicator_registry (
  indicator_id TEXT PRIMARY KEY,
  domain TEXT NOT NULL,
  indicator_type TEXT NOT NULL,
  current_value REAL NOT NULL,
  baseline_value REAL NOT NULL,
  target_value REAL NOT NULL,
  threshold_value REAL NOT NULL,
  unit TEXT NOT NULL,
  metadata_score REAL NOT NULL,
  validation_score REAL NOT NULL,
  lineage_score REAL NOT NULL,
  uncertainty_score REAL NOT NULL,
  conceptual_relevance_score REAL NOT NULL,
  material_finding INTEGER NOT NULL,
  corrective_action_taken INTEGER NOT NULL,
  publicly_reviewable INTEGER NOT NULL,
  notes TEXT
);

CREATE TABLE baselines_targets_thresholds (
  indicator_id TEXT PRIMARY KEY,
  baseline_year INTEGER NOT NULL,
  baseline_value REAL NOT NULL,
  target_year INTEGER NOT NULL,
  target_value REAL NOT NULL,
  threshold_value REAL NOT NULL,
  threshold_type TEXT NOT NULL,
  threshold_rationale TEXT NOT NULL,
  FOREIGN KEY (indicator_id) REFERENCES indicator_registry(indicator_id)
);

CREATE TABLE tradeoff_register (
  tradeoff_id TEXT PRIMARY KEY,
  primary_domain TEXT NOT NULL,
  affected_domain TEXT NOT NULL,
  description TEXT NOT NULL,
  severity TEXT NOT NULL,
  review_status TEXT NOT NULL
);

CREATE TABLE accountability_log (
  finding_id TEXT PRIMARY KEY,
  indicator_id TEXT NOT NULL,
  material_finding INTEGER NOT NULL,
  decision_owner TEXT NOT NULL,
  corrective_action TEXT NOT NULL,
  status TEXT NOT NULL,
  publicly_reviewable INTEGER NOT NULL,
  follow_up_date TEXT NOT NULL,
  FOREIGN KEY (indicator_id) REFERENCES indicator_registry(indicator_id)
);

CREATE TABLE feedback_rules (
  rule_id TEXT PRIMARY KEY,
  condition_name TEXT NOT NULL,
  required_action TEXT NOT NULL
);

INSERT INTO indicator_registry VALUES
('ghg-absolute-001','climate','pressure',72,100,40,50,'ktCO2e',0.90,0.86,0.88,0.82,0.92,1,1,1,'Absolute emissions remain above target but corrective action exists'),
('water-withdrawal-001','water','pressure',88,100,70,75,'ML',0.82,0.78,0.75,0.72,0.88,1,0,1,'Water withdrawals exceed threshold and lack corrective action'),
('biodiversity-habitat-001','biodiversity','state',0.58,0.72,0.80,0.65,'index',0.68,0.62,0.58,0.55,0.90,1,0,0,'Habitat condition indicator has weak lineage and accountability gap'),
('waste-diversion-001','waste','response',0.61,0.30,0.75,0.90,'fraction',0.86,0.80,0.84,0.76,0.70,0,0,1,'Response indicator requiring outcome supplement'),
('air-quality-exposure-001','air_quality','equity',38,52,20,35,'ug_m3',0.84,0.80,0.82,0.78,0.91,1,0,1,'Exposure above threshold in vulnerable areas');
