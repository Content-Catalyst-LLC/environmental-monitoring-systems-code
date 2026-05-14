DROP TABLE IF EXISTS platform_assets;
DROP TABLE IF EXISTS source_inventory;
DROP TABLE IF EXISTS semantic_crosswalk;
DROP TABLE IF EXISTS workflow_registry;
DROP TABLE IF EXISTS model_scenario_registry;
DROP TABLE IF EXISTS decision_support_matrix;
DROP TABLE IF EXISTS platform_governance_log;

CREATE TABLE platform_assets (
  asset_id TEXT PRIMARY KEY,
  domain TEXT NOT NULL,
  asset_type TEXT NOT NULL,
  metadata_complete REAL NOT NULL,
  semantic_compatibility REAL NOT NULL,
  lineage_complete REAL NOT NULL,
  uncertainty_visible REAL NOT NULL,
  decision_fit REAL NOT NULL,
  is_high_stakes INTEGER NOT NULL,
  notes TEXT
);

CREATE TABLE source_inventory (
  source_id TEXT PRIMARY KEY,
  domain TEXT NOT NULL,
  source_type TEXT NOT NULL,
  owner TEXT NOT NULL,
  update_cadence TEXT NOT NULL,
  has_metadata INTEGER NOT NULL,
  has_quality_flags INTEGER NOT NULL,
  has_lineage INTEGER NOT NULL,
  access_level TEXT NOT NULL,
  notes TEXT
);

CREATE TABLE semantic_crosswalk (
  crosswalk_id TEXT PRIMARY KEY,
  source_field TEXT NOT NULL,
  target_concept TEXT NOT NULL,
  source_unit TEXT NOT NULL,
  target_unit TEXT NOT NULL,
  semantic_status TEXT NOT NULL,
  notes TEXT
);

CREATE TABLE workflow_registry (
  workflow_id TEXT PRIMARY KEY,
  workflow_name TEXT NOT NULL,
  input_sources TEXT NOT NULL,
  output_asset TEXT NOT NULL,
  update_cadence TEXT NOT NULL,
  has_lineage INTEGER NOT NULL,
  has_uncertainty_label INTEGER NOT NULL,
  owner TEXT NOT NULL
);

CREATE TABLE model_scenario_registry (
  model_id TEXT PRIMARY KEY,
  domain TEXT NOT NULL,
  model_type TEXT NOT NULL,
  version TEXT NOT NULL,
  scenario_name TEXT NOT NULL,
  inputs_documented INTEGER NOT NULL,
  assumptions_documented INTEGER NOT NULL,
  validation_documented INTEGER NOT NULL,
  uncertainty_documented INTEGER NOT NULL,
  intended_use TEXT NOT NULL
);

CREATE TABLE decision_support_matrix (
  role TEXT NOT NULL,
  priority_question TEXT NOT NULL,
  required_evidence TEXT NOT NULL,
  decision_horizon TEXT NOT NULL,
  output_type TEXT NOT NULL,
  action_pathway TEXT NOT NULL
);

CREATE TABLE platform_governance_log (
  governance_id TEXT PRIMARY KEY,
  date TEXT NOT NULL,
  component TEXT NOT NULL,
  decision TEXT NOT NULL,
  owner TEXT NOT NULL,
  status TEXT NOT NULL,
  public_note_required INTEGER NOT NULL
);

INSERT INTO platform_assets VALUES
('streamflow-api-001','water','api_stream',0.92,0.88,0.90,0.86,0.84,1,'Operational water-data source suitable for warning and planning'),
('flood-scenario-model-002','flood','model_output',0.84,0.78,0.76,0.62,0.81,1,'Flood scenario model needs stronger uncertainty visibility and lineage'),
('habitat-layer-003','biodiversity','geospatial_layer',0.68,0.64,0.55,0.58,0.70,0,'Habitat layer needs metadata and semantic review'),
('air-exposure-dashboard-004','air_quality','decision_view',0.88,0.82,0.86,0.90,0.92,1,'Community-facing air exposure decision view'),
('compliance-records-005','regulatory','administrative_record',0.80,0.74,0.82,0.72,0.76,1,'Compliance records need semantic review before cross-program comparison'),
('climate-scenario-006','climate','scenario_output',0.86,0.80,0.78,0.70,0.88,1,'Scenario output requires assumptions and model-version review');
