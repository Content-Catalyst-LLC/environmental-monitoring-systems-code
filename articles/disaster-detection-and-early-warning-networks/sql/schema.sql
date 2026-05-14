DROP TABLE IF EXISTS warning_scenarios;
DROP TABLE IF EXISTS hazard_signal_inventory;
DROP TABLE IF EXISTS message_templates;
DROP TABLE IF EXISTS communication_channel_matrix;
DROP TABLE IF EXISTS warning_reach_response;
DROP TABLE IF EXISTS warning_event_log;

CREATE TABLE warning_scenarios (
  scenario_id TEXT PRIMARY KEY,
  hazard_type TEXT NOT NULL,
  detection_confidence REAL NOT NULL,
  usable_lead_time_score REAL NOT NULL,
  reach_score REAL NOT NULL,
  trust_score REAL NOT NULL,
  response_capacity_score REAL NOT NULL,
  protective_action_score REAL NOT NULL,
  missed_event_penalty REAL NOT NULL,
  equity_gap_score REAL NOT NULL,
  notes TEXT
);

CREATE TABLE hazard_signal_inventory (
  signal_id TEXT PRIMARY KEY,
  hazard_type TEXT NOT NULL,
  source_type TEXT NOT NULL,
  observed_property TEXT NOT NULL,
  unit TEXT NOT NULL,
  current_value REAL NOT NULL,
  warning_threshold REAL NOT NULL,
  critical_threshold REAL NOT NULL,
  latency_minutes REAL NOT NULL,
  source_name TEXT NOT NULL
);

CREATE TABLE message_templates (
  template_id TEXT PRIMARY KEY,
  hazard_type TEXT NOT NULL,
  severity TEXT NOT NULL,
  audience TEXT NOT NULL,
  message_goal TEXT NOT NULL,
  action_text TEXT NOT NULL
);

CREATE TABLE communication_channel_matrix (
  channel_id TEXT PRIMARY KEY,
  channel_type TEXT NOT NULL,
  coverage_group TEXT NOT NULL,
  redundant INTEGER NOT NULL,
  accessibility_notes TEXT,
  failure_mode TEXT
);

CREATE TABLE warning_reach_response (
  record_id INTEGER PRIMARY KEY AUTOINCREMENT,
  scenario_id TEXT NOT NULL,
  hazard_type TEXT NOT NULL,
  population_group TEXT NOT NULL,
  exposed INTEGER NOT NULL,
  reached INTEGER NOT NULL,
  acted INTEGER NOT NULL,
  FOREIGN KEY (scenario_id) REFERENCES warning_scenarios(scenario_id)
);

CREATE TABLE warning_event_log (
  event_id TEXT PRIMARY KEY,
  scenario_id TEXT NOT NULL,
  event_stage TEXT NOT NULL,
  event_time TEXT NOT NULL,
  evidence_record TEXT NOT NULL,
  FOREIGN KEY (scenario_id) REFERENCES warning_scenarios(scenario_id)
);

INSERT INTO warning_scenarios VALUES
('flood-urban-001','flood',0.84,0.72,0.68,0.61,0.57,0.52,0.12,0.28,'Urban flood warning with moderate last-mile gaps'),
('heat-city-002','heat',0.88,0.80,0.74,0.66,0.48,0.46,0.10,0.36,'Heat warning with capacity limitations'),
('tsunami-coast-003','tsunami',0.91,0.62,0.82,0.76,0.70,0.64,0.08,0.18,'Coastal tsunami warning with strong reach but limited lead time'),
('wildfire-smoke-004','wildfire_smoke',0.79,0.58,0.55,0.60,0.52,0.45,0.16,0.32,'Wildfire smoke warning with reach and equity concerns');
