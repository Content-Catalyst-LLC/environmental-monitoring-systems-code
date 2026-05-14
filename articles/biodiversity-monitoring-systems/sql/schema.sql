DROP TABLE IF EXISTS biodiversity_dimension_matrix;
DROP TABLE IF EXISTS observation_method_registry;
DROP TABLE IF EXISTS species_observation_records;
DROP TABLE IF EXISTS biodiversity_indicator_registry;
DROP TABLE IF EXISTS detectability_bias_audit;
DROP TABLE IF EXISTS biodiversity_monitoring_readiness_scores;
DROP TABLE IF EXISTS community_monitoring_governance;
DROP TABLE IF EXISTS conservation_accountability_log;

CREATE TABLE biodiversity_dimension_matrix (
  dimension_id TEXT PRIMARY KEY,
  dimension_name TEXT NOT NULL,
  definition TEXT NOT NULL,
  example_measures TEXT NOT NULL,
  primary_risk TEXT NOT NULL
);

CREATE TABLE observation_method_registry (
  method_id TEXT PRIMARY KEY,
  method_name TEXT NOT NULL,
  best_for TEXT NOT NULL,
  detectability_limits TEXT NOT NULL,
  data_burden TEXT NOT NULL,
  governance_note TEXT NOT NULL
);

CREATE TABLE species_observation_records (
  observation_id TEXT PRIMARY KEY,
  program_id TEXT NOT NULL,
  site_id TEXT NOT NULL,
  taxon_group TEXT NOT NULL,
  species_or_taxon TEXT NOT NULL,
  method_id TEXT NOT NULL,
  observation_date TEXT NOT NULL,
  detected INTEGER NOT NULL,
  count_or_index TEXT,
  effort_units TEXT NOT NULL,
  quality_flag TEXT NOT NULL,
  detectability_note TEXT,
  habitat_context TEXT
);

CREATE TABLE biodiversity_indicator_registry (
  indicator_id TEXT PRIMARY KEY,
  indicator_name TEXT NOT NULL,
  dimension_id TEXT NOT NULL,
  ebv_link TEXT NOT NULL,
  gbf_or_policy_use TEXT NOT NULL,
  proxy_limit TEXT NOT NULL,
  baseline_or_reference TEXT NOT NULL,
  review_status TEXT NOT NULL
);

CREATE TABLE detectability_bias_audit (
  audit_id TEXT PRIMARY KEY,
  program_id TEXT NOT NULL,
  bias_dimension TEXT NOT NULL,
  target_group_or_zone TEXT NOT NULL,
  score REAL NOT NULL,
  evidence_gap TEXT NOT NULL,
  priority TEXT NOT NULL,
  notes TEXT
);

CREATE TABLE biodiversity_monitoring_readiness_scores (
  program_id TEXT PRIMARY KEY,
  ecosystem_context TEXT NOT NULL,
  geography TEXT NOT NULL,
  taxonomic_coverage REAL NOT NULL,
  spatial_representativeness REAL NOT NULL,
  method_diversity REAL NOT NULL,
  detectability_adjustment REAL NOT NULL,
  observation_quality REAL NOT NULL,
  indicator_readiness REAL NOT NULL,
  habitat_context_linkage REAL NOT NULL,
  uncertainty_communication REAL NOT NULL,
  governance_readiness REAL NOT NULL,
  high_stakes_use INTEGER NOT NULL
);

CREATE TABLE community_monitoring_governance (
  governance_id TEXT PRIMARY KEY,
  program_id TEXT NOT NULL,
  knowledge_source TEXT NOT NULL,
  consent_status TEXT NOT NULL,
  ownership_model TEXT NOT NULL,
  sensitive_location_policy TEXT NOT NULL,
  interpretation_role TEXT NOT NULL,
  public_use_status TEXT NOT NULL,
  notes TEXT
);

CREATE TABLE conservation_accountability_log (
  accountability_id TEXT PRIMARY KEY,
  date TEXT NOT NULL,
  program_id TEXT NOT NULL,
  claim TEXT NOT NULL,
  decision TEXT NOT NULL,
  owner TEXT NOT NULL,
  status TEXT NOT NULL,
  public_note_required INTEGER NOT NULL
);

INSERT INTO biodiversity_monitoring_readiness_scores VALUES
('forest-biodiversity-monitoring','forest','regional_forest',0.64,0.72,0.70,0.68,0.80,0.76,0.82,0.74,0.80,1),
('wetland-biodiversity-monitoring','wetland','regional_watershed',0.70,0.76,0.74,0.72,0.82,0.78,0.84,0.76,0.82,1),
('stream-edna-monitoring','river_stream','watershed_network',0.62,0.68,0.72,0.64,0.76,0.70,0.78,0.72,0.76,1),
('grassland-insect-monitoring','grassland','restoration_landscape',0.58,0.66,0.64,0.62,0.74,0.68,0.72,0.70,0.74,0),
('urban-biodiversity-monitoring','urban_ecology','metro_region',0.55,0.52,0.70,0.58,0.70,0.66,0.76,0.68,0.72,1);

INSERT INTO biodiversity_indicator_registry VALUES
('ind-occupancy','Detection-adjusted occupancy','occurrence','Species populations / species distributions','site occupancy and species persistence','Requires detectability model and repeated effort','repeat_survey_baseline','approved'),
('ind-abundance','Relative abundance trend','abundance','Species populations','population trend reporting','Effort shifts can mimic trend','long_term_monitoring_baseline','approved'),
('ind-community-turnover','Community turnover index','community','Community composition','ecological condition and homogenization review','Richness may hide specialist decline','reference_community','review_required'),
('ind-habitat-fragmentation','Habitat fragmentation index','habitat','Ecosystem structure','habitat quality and connectivity reporting','Habitat pattern does not equal species viability','landscape_reference','approved'),
('ind-edna-presence','eDNA detection index','occurrence','Species distributions','cryptic taxa screening','DNA detection may not equal local living presence','site_sampling_protocol','review_required');

INSERT INTO detectability_bias_audit VALUES
('audit-001','forest-biodiversity-monitoring','taxonomic_bias','invertebrates_and_soil_biota',0.42,'Monitoring dominated by birds and large mammals','high','Add insect soil and microbial methods'),
('audit-002','wetland-biodiversity-monitoring','seasonal_bias','amphibian_breeding_windows',0.68,'Surveys do not cover full breeding season','medium','Add weather-triggered acoustic sampling'),
('audit-003','stream-edna-monitoring','method_bias','local_presence_interpretation',0.60,'eDNA transport complicates site-level presence','high','Pair with habitat and field validation'),
('audit-004','urban-biodiversity-monitoring','effort_bias','underserved_neighborhoods',0.48,'Citizen-science effort uneven across neighborhoods','high','Support community-based monitoring and effort correction');

INSERT INTO conservation_accountability_log VALUES
('acct-001','2026-05-01','forest-biodiversity-monitoring','Forest biodiversity stable','Require taxonomic bias caveat before public claim','forest_team','open',1),
('acct-002','2026-05-02','wetland-biodiversity-monitoring','Wetland amphibian monitoring supports restoration review','Approved with seasonal-detectability caveat','wetland_team','closed',1),
('acct-003','2026-05-03','stream-edna-monitoring','eDNA indicates native fish presence','Require field or habitat validation before high-confidence claim','stream_team','open',1);
