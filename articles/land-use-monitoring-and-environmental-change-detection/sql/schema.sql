DROP TABLE IF EXISTS land_class_legend;
DROP TABLE IF EXISTS imagery_inventory;
DROP TABLE IF EXISTS reference_samples;
DROP TABLE IF EXISTS change_rule_registry;
DROP TABLE IF EXISTS land_change_records;
DROP TABLE IF EXISTS accuracy_assessment;
DROP TABLE IF EXISTS landscape_metrics;
DROP TABLE IF EXISTS land_monitoring_readiness_scores;
DROP TABLE IF EXISTS land_monitoring_governance_log;

CREATE TABLE land_class_legend (
  class_id TEXT PRIMARY KEY,
  class_name TEXT NOT NULL,
  class_group TEXT NOT NULL,
  definition TEXT NOT NULL,
  monitoring_note TEXT
);

CREATE TABLE imagery_inventory (
  scene_id TEXT PRIMARY KEY,
  source TEXT NOT NULL,
  sensor TEXT NOT NULL,
  acquisition_date TEXT NOT NULL,
  geography TEXT NOT NULL,
  cloud_cover_percent REAL NOT NULL,
  processing_level TEXT NOT NULL,
  seasonal_window TEXT NOT NULL,
  used_for TEXT NOT NULL,
  notes TEXT
);

CREATE TABLE reference_samples (
  sample_id TEXT PRIMARY KEY,
  geography TEXT NOT NULL,
  latitude REAL NOT NULL,
  longitude REAL NOT NULL,
  reference_class TEXT NOT NULL,
  reference_source TEXT NOT NULL,
  reference_date TEXT NOT NULL,
  confidence REAL NOT NULL,
  role TEXT NOT NULL,
  notes TEXT
);

CREATE TABLE change_rule_registry (
  change_rule_id TEXT PRIMARY KEY,
  from_class TEXT NOT NULL,
  to_class TEXT NOT NULL,
  change_type TEXT NOT NULL,
  persistence_required TEXT NOT NULL,
  minimum_confidence REAL NOT NULL,
  reporting_use TEXT NOT NULL,
  review_status TEXT NOT NULL
);

CREATE TABLE land_change_records (
  change_id TEXT PRIMARY KEY,
  product_id TEXT NOT NULL,
  geography TEXT NOT NULL,
  site_id TEXT NOT NULL,
  from_class TEXT NOT NULL,
  to_class TEXT NOT NULL,
  change_type TEXT NOT NULL,
  change_year INTEGER NOT NULL,
  confidence REAL NOT NULL,
  persistence_score REAL NOT NULL,
  validated INTEGER NOT NULL,
  reporting_relevance TEXT NOT NULL,
  notes TEXT
);

CREATE TABLE accuracy_assessment (
  assessment_id TEXT PRIMARY KEY,
  product_id TEXT NOT NULL,
  class_name TEXT NOT NULL,
  reference_samples INTEGER NOT NULL,
  correct_samples INTEGER NOT NULL,
  users_accuracy REAL NOT NULL,
  producers_accuracy REAL NOT NULL,
  mapped_area_ha REAL NOT NULL,
  adjusted_area_ha REAL NOT NULL,
  area_uncertainty_ha REAL NOT NULL
);

CREATE TABLE landscape_metrics (
  metric_id TEXT PRIMARY KEY,
  product_id TEXT NOT NULL,
  geography TEXT NOT NULL,
  class_name TEXT NOT NULL,
  year INTEGER NOT NULL,
  patch_count INTEGER NOT NULL,
  mean_patch_size_ha REAL NOT NULL,
  edge_density_m_per_ha REAL NOT NULL,
  connectivity_score REAL NOT NULL,
  condition_index REAL NOT NULL,
  notes TEXT
);

CREATE TABLE land_monitoring_readiness_scores (
  product_id TEXT PRIMARY KEY,
  geography TEXT NOT NULL,
  monitoring_purpose TEXT NOT NULL,
  classification_accuracy REAL NOT NULL,
  temporal_consistency REAL NOT NULL,
  detected_change_samples INTEGER NOT NULL,
  validated_change_samples INTEGER NOT NULL,
  reference_data_strength REAL NOT NULL,
  condition_sensitivity REAL NOT NULL,
  fragmentation_visibility REAL NOT NULL,
  uncertainty_communication REAL NOT NULL,
  reporting_readiness REAL NOT NULL,
  high_stakes_use INTEGER NOT NULL
);

CREATE TABLE land_monitoring_governance_log (
  governance_id TEXT PRIMARY KEY,
  date TEXT NOT NULL,
  product_id TEXT NOT NULL,
  decision TEXT NOT NULL,
  owner TEXT NOT NULL,
  status TEXT NOT NULL,
  public_note_required INTEGER NOT NULL
);

INSERT INTO land_class_legend VALUES
('forest','Forest','land_cover','Tree-dominated land cover including natural and managed forest','Class may hide degradation canopy thinning harvest cycles or recovery stage'),
('cropland','Cropland','land_cover_land_use','Land used or visibly managed for crop production','Broad class may hide intensification irrigation crop rotation or soil exposure'),
('wetland','Wetland','land_cover_condition','Hydrologically influenced land with wetland vegetation or wet soil indicators','Condition change may occur before mapped wetland loss'),
('urban_developed','Urban or Developed','land_cover_land_use','Built-up impervious or settlement-associated land cover','Incremental impervious expansion may require fractional or high-resolution methods'),
('grassland','Grassland','land_cover','Herbaceous land cover including natural or managed grassland','Condition and grazing pressure may not appear as class change'),
('restoration','Restoration Area','land_use_condition','Area under ecological restoration or recovery management','Recovery requires trajectory validation not only class assignment');

INSERT INTO land_monitoring_readiness_scores VALUES
('annual-land-cover-change','national','land_cover_and_change_reporting',0.86,0.88,420,365,0.84,0.76,0.72,0.82,0.88,1),
('wetland-condition-change','regional_watershed','wetland_loss_and_condition',0.78,0.80,160,112,0.74,0.82,0.70,0.76,0.80,1),
('urban-impervious-expansion','metro_region','urban_growth_and_watershed_risk',0.90,0.84,210,188,0.82,0.78,0.86,0.84,0.86,1),
('restoration-trajectory-monitoring','restoration_sites','recovery_and_accountability',0.76,0.72,95,61,0.68,0.74,0.66,0.70,0.72,0),
('land-degradation-watch','rangeland_region','land_degradation_assessment',0.77,0.81,140,108,0.72,0.80,0.76,0.73,0.78,1);

INSERT INTO land_change_records VALUES
('chg-001','annual-land-cover-change','national','site-a','forest','cropland','conversion',2021,0.88,0.92,1,'land_use_change_reporting','Validated forest to cropland conversion'),
('chg-002','wetland-condition-change','regional_watershed','site-b','wetland','wetland','within_class_condition_change',2022,0.76,0.70,1,'wetland_condition_review','Wetness decline without full class transition'),
('chg-003','urban-impervious-expansion','metro_region','site-c','grassland','urban_developed','conversion',2022,0.91,0.89,1,'urban_planning_and_watershed_risk','Urban edge expansion'),
('chg-004','restoration-trajectory-monitoring','restoration_sites','site-d','barren','restoration','recovery',2022,0.72,0.68,0,'restoration_accountability','Recovery signal needs more validation'),
('chg-005','land-degradation-watch','rangeland_region','site-f','grassland','barren','degradation',2020,0.79,0.81,1,'land_degradation_assessment','Grassland to exposed soil transition');

INSERT INTO accuracy_assessment VALUES
('acc-001','annual-land-cover-change','forest',120,105,0.88,0.86,250000,242500,8200),
('acc-002','annual-land-cover-change','cropland',110,96,0.87,0.84,310000,318400,9100),
('acc-003','wetland-condition-change','wetland',80,62,0.78,0.75,42000,38500,5200),
('acc-004','urban-impervious-expansion','urban_developed',95,88,0.93,0.90,98000,101200,4100),
('acc-005','restoration-trajectory-monitoring','restoration',55,39,0.71,0.68,12500,10900,2700);
