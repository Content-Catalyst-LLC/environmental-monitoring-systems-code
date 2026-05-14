DROP TABLE IF EXISTS dashboard_indicators;
DROP TABLE IF EXISTS user_role_matrix;
DROP TABLE IF EXISTS dashboard_source_inventory;
DROP TABLE IF EXISTS alert_log;
DROP TABLE IF EXISTS dashboard_change_log;

CREATE TABLE dashboard_indicators (
  indicator_id TEXT PRIMARY KEY,
  domain TEXT NOT NULL,
  user_role TEXT NOT NULL,
  is_fresh INTEGER NOT NULL,
  has_provenance INTEGER NOT NULL,
  is_modeled_or_estimated INTEGER NOT NULL,
  uncertainty_labeled INTEGER NOT NULL,
  supports_priority_task INTEGER NOT NULL,
  alert_count INTEGER NOT NULL,
  actionable_alert_count INTEGER NOT NULL,
  notes TEXT
);

CREATE TABLE user_role_matrix (
  role TEXT PRIMARY KEY,
  primary_need TEXT NOT NULL,
  decision_horizon TEXT NOT NULL,
  priority_task TEXT NOT NULL,
  evidence_depth_required TEXT NOT NULL,
  public_facing INTEGER NOT NULL
);

CREATE TABLE dashboard_source_inventory (
  source_id TEXT PRIMARY KEY,
  domain TEXT NOT NULL,
  source_type TEXT NOT NULL,
  update_cadence TEXT NOT NULL,
  owner TEXT NOT NULL,
  has_quality_flags INTEGER NOT NULL,
  has_provenance INTEGER NOT NULL,
  notes TEXT
);

CREATE TABLE alert_log (
  alert_id TEXT PRIMARY KEY,
  indicator_id TEXT NOT NULL,
  severity TEXT NOT NULL,
  alert_time TEXT NOT NULL,
  actionable INTEGER NOT NULL,
  action_owner TEXT NOT NULL,
  status TEXT NOT NULL,
  notes TEXT,
  FOREIGN KEY (indicator_id) REFERENCES dashboard_indicators(indicator_id)
);

CREATE TABLE dashboard_change_log (
  change_id TEXT PRIMARY KEY,
  change_date TEXT NOT NULL,
  component TEXT NOT NULL,
  change_type TEXT NOT NULL,
  description TEXT NOT NULL,
  review_owner TEXT NOT NULL,
  public_note_required INTEGER NOT NULL
);

INSERT INTO dashboard_indicators VALUES
('river-stage-current','water','responder',1,1,0,1,1,4,3,'Real-time river-stage status for response'),
('flood-inundation-model','flood','planner',1,1,1,0,1,3,2,'Modeled inundation layer needs uncertainty labeling'),
('compliance-summary','regulatory','regulator',1,1,0,1,1,8,2,'High alert burden in comparative compliance view'),
('habitat-condition-map','biodiversity','analyst',0,0,1,0,0,1,1,'Stale modeled habitat layer lacks provenance'),
('air-quality-exposure','air_quality','community',1,1,1,1,1,5,4,'Community-facing exposure view with uncertainty labels');
