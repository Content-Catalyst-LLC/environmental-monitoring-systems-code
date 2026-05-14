DROP TABLE IF EXISTS ecosystem_dimension_matrix;
DROP TABLE IF EXISTS ecological_observation_registry;
DROP TABLE IF EXISTS ecological_indicator_registry;
DROP TABLE IF EXISTS disturbance_recovery_log;
DROP TABLE IF EXISTS ecosystem_monitoring_readiness_scores;
DROP TABLE IF EXISTS ecosystem_assessment_scores;
DROP TABLE IF EXISTS representativeness_audit;
DROP TABLE IF EXISTS ecosystem_monitoring_governance_log;

CREATE TABLE ecosystem_dimension_matrix (
  dimension_id TEXT PRIMARY KEY,
  dimension_name TEXT NOT NULL,
  definition TEXT NOT NULL,
  example_indicators TEXT NOT NULL,
  primary_risk TEXT NOT NULL
);

CREATE TABLE ecological_observation_registry (
  observation_id TEXT PRIMARY KEY,
  program_id TEXT NOT NULL,
  site_id TEXT NOT NULL,
  ecosystem_type TEXT NOT NULL,
  geography TEXT NOT NULL,
  latitude REAL NOT NULL,
  longitude REAL NOT NULL,
  method TEXT NOT NULL,
  observed_variable TEXT NOT NULL,
  unit TEXT NOT NULL,
  ecological_dimension TEXT NOT NULL,
  observation_date TEXT NOT NULL,
  quality_flag TEXT NOT NULL,
  uncertainty_note TEXT
);

CREATE TABLE ecological_indicator_registry (
  indicator_id TEXT PRIMARY KEY,
  indicator_name TEXT NOT NULL,
  ecological_dimension TEXT NOT NULL,
  proxy_meaning TEXT NOT NULL,
  baseline_or_reference TEXT NOT NULL,
  threshold REAL NOT NULL,
  valid_use TEXT NOT NULL,
  proxy_limit TEXT NOT NULL,
  review_status TEXT NOT NULL
);

CREATE TABLE disturbance_recovery_log (
  event_id TEXT PRIMARY KEY,
  program_id TEXT NOT NULL,
  site_id TEXT NOT NULL,
  ecosystem_type TEXT NOT NULL,
  event_type TEXT NOT NULL,
  event_start TEXT NOT NULL,
  event_end TEXT NOT NULL,
  frequency_class TEXT NOT NULL,
  intensity_score REAL NOT NULL,
  spatial_extent_ha REAL NOT NULL,
  recovery_status TEXT NOT NULL,
  notes TEXT
);

CREATE TABLE ecosystem_monitoring_readiness_scores (
  program_id TEXT PRIMARY KEY,
  ecosystem_type TEXT NOT NULL,
  geography TEXT NOT NULL,
  extent_visibility REAL NOT NULL,
  condition_evidence REAL NOT NULL,
  structure_evidence REAL NOT NULL,
  function_evidence REAL NOT NULL,
  integrity_evidence REAL NOT NULL,
  resilience_evidence REAL NOT NULL,
  baseline_strength REAL NOT NULL,
  uncertainty_communication REAL NOT NULL,
  governance_readiness REAL NOT NULL,
  high_stakes_use INTEGER NOT NULL
);

CREATE TABLE ecosystem_assessment_scores (
  assessment_id TEXT PRIMARY KEY,
  program_id TEXT NOT NULL,
  site_id TEXT NOT NULL,
  ecosystem_type TEXT NOT NULL,
  assessment_date TEXT NOT NULL,
  condition_score REAL NOT NULL,
  structure_score REAL NOT NULL,
  function_score REAL NOT NULL,
  integrity_score REAL NOT NULL,
  resilience_score REAL NOT NULL,
  confidence REAL NOT NULL,
  review_status TEXT NOT NULL,
  notes TEXT
);

CREATE TABLE representativeness_audit (
  audit_id TEXT PRIMARY KEY,
  program_id TEXT NOT NULL,
  coverage_dimension TEXT NOT NULL,
  target_group_or_zone TEXT NOT NULL,
  coverage_score REAL NOT NULL,
  evidence_gap TEXT NOT NULL,
  priority TEXT NOT NULL,
  notes TEXT
);

CREATE TABLE ecosystem_monitoring_governance_log (
  governance_id TEXT PRIMARY KEY,
  date TEXT NOT NULL,
  program_id TEXT NOT NULL,
  decision TEXT NOT NULL,
  owner TEXT NOT NULL,
  status TEXT NOT NULL,
  public_note_required INTEGER NOT NULL
);

INSERT INTO ecosystem_dimension_matrix VALUES
('extent','Ecosystem extent','Area distribution and mapped presence of an ecosystem type','ecosystem area habitat distribution land cover persistence','Mapped presence mistaken for ecological health'),
('condition','Ecosystem condition','Ecological state relative to reference or benchmark','biotic condition water quality habitat score vegetation health','Composite scores hide weak components'),
('structure','Ecosystem structure','Physical spatial and compositional organization','canopy layers patch structure connectivity habitat complexity','Structure assumed to imply function'),
('function','Ecosystem function','Ecological processes and throughput','productivity nutrient cycling hydrological function decomposition carbon flux','Processes inferred from weak proxies'),
('integrity','Ecosystem integrity','Synthetic coherence of biotic structural and functional character','native composition process continuity connectivity reference similarity','Integrity treated as directly measured'),
('resilience','Ecosystem resilience','Capacity to absorb recover adapt or reorganize after disturbance','recovery rate threshold distance disturbance memory adaptive capacity','Short-term persistence mistaken for resilience');

INSERT INTO ecological_indicator_registry VALUES
('ind-condition-veg','Vegetation condition index','condition','Approximate plant community condition','reference_wetland_sites',0.70,'condition screening','Does not fully represent function or integrity','approved'),
('ind-do-function','Dissolved oxygen stability','function','Aquatic habitat process support','site_reference_period',5.0,'aquatic stress screening','Chemistry alone does not equal biological integrity','approved'),
('ind-canopy-structure','Canopy structure index','structure','Forest vertical and spatial structure','regional_reference_forest',0.75,'structure monitoring','Structure does not guarantee native composition','approved'),
('ind-native-integrity','Native composition score','integrity','Native biotic assemblage similarity','least_disturbed_reference',0.70,'integrity assessment','Sampling may miss rare taxa','review_required'),
('ind-recovery-ratio','Recovery ratio','recovery','Progress toward reference condition','restoration_target_reference',0.60,'restoration review','Visible recovery may not equal restored function','review_required');

INSERT INTO ecosystem_monitoring_readiness_scores VALUES
('wetland-integrity-monitoring','wetland','regional_watershed',0.86,0.78,0.74,0.72,0.76,0.70,0.82,0.78,0.84,1),
('forest-condition-monitoring','forest','regional_forest',0.90,0.76,0.84,0.70,0.72,0.68,0.80,0.76,0.82,1),
('stream-ecological-condition','river_stream','watershed_network',0.78,0.82,0.70,0.80,0.78,0.74,0.84,0.80,0.86,1),
('restoration-recovery-program','restoration_mosaic','restoration_sites',0.74,0.70,0.72,0.66,0.68,0.64,0.70,0.68,0.72,0),
('coastal-marsh-monitoring','coastal_marsh','coastal_region',0.82,0.72,0.76,0.68,0.70,0.66,0.76,0.74,0.78,1);

INSERT INTO ecosystem_assessment_scores VALUES
('assess-001','wetland-integrity-monitoring','wetland-site-a','wetland','2026-05-10',0.78,0.74,0.72,0.76,0.70,0.78,'approved','Condition adequate but resilience needs longer time series'),
('assess-002','forest-condition-monitoring','forest-site-b','forest','2026-05-11',0.76,0.84,0.70,0.72,0.68,0.74,'review_required','Strong structure evidence but resilience and integrity need review'),
('assess-003','stream-ecological-condition','stream-site-c','river_stream','2026-05-12',0.82,0.70,0.80,0.78,0.74,0.80,'approved','Biological and water-quality indicators aligned'),
('assess-004','restoration-recovery-program','restoration-site-d','restoration_mosaic','2026-05-13',0.70,0.72,0.66,0.68,0.64,0.66,'review_required','Recovery claim not yet supported by function and resilience evidence');
