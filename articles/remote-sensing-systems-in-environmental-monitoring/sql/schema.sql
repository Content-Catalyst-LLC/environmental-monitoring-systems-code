DROP TABLE IF EXISTS platform_sensor_inventory;
DROP TABLE IF EXISTS remote_sensing_product_registry;
DROP TABLE IF EXISTS validation_records;
DROP TABLE IF EXISTS product_readiness_scores;
DROP TABLE IF EXISTS time_series_change_records;
DROP TABLE IF EXISTS product_governance_log;

CREATE TABLE platform_sensor_inventory (
  platform_id TEXT PRIMARY KEY,
  platform_type TEXT NOT NULL,
  agency_or_owner TEXT NOT NULL,
  sensing_mode TEXT NOT NULL,
  primary_domains TEXT NOT NULL,
  spatial_resolution_class TEXT NOT NULL,
  revisit_category TEXT NOT NULL,
  coverage_scope TEXT NOT NULL,
  notes TEXT
);

CREATE TABLE remote_sensing_product_registry (
  product_id TEXT PRIMARY KEY,
  platform_id TEXT NOT NULL,
  domain TEXT NOT NULL,
  sensing_mode TEXT NOT NULL,
  product_type TEXT NOT NULL,
  processing_level TEXT NOT NULL,
  variable TEXT NOT NULL,
  unit TEXT NOT NULL,
  temporal_cadence TEXT NOT NULL,
  spatial_scale TEXT NOT NULL,
  evidence_status TEXT NOT NULL,
  decision_use TEXT NOT NULL,
  FOREIGN KEY (platform_id) REFERENCES platform_sensor_inventory(platform_id)
);

CREATE TABLE validation_records (
  record_id TEXT PRIMARY KEY,
  product_id TEXT NOT NULL,
  correction_quality REAL NOT NULL,
  validation_score REAL NOT NULL,
  uncertainty_characterized REAL NOT NULL,
  domain_suitability REAL NOT NULL,
  field_validation REAL NOT NULL,
  validation_status TEXT NOT NULL,
  notes TEXT,
  FOREIGN KEY (product_id) REFERENCES remote_sensing_product_registry(product_id)
);

CREATE TABLE product_readiness_scores (
  product_id TEXT PRIMARY KEY,
  domain TEXT NOT NULL,
  sensing_mode TEXT NOT NULL,
  valid_coverage REAL NOT NULL,
  correction_quality REAL NOT NULL,
  validation_score REAL NOT NULL,
  uncertainty_characterized REAL NOT NULL,
  domain_suitability REAL NOT NULL,
  time_series_continuity REAL NOT NULL,
  proxy_transparency REAL NOT NULL,
  field_validation REAL NOT NULL,
  decision_fit REAL NOT NULL,
  high_stakes_use INTEGER NOT NULL
);

CREATE TABLE time_series_change_records (
  change_id TEXT PRIMARY KEY,
  product_id TEXT NOT NULL,
  baseline_period TEXT NOT NULL,
  comparison_period TEXT NOT NULL,
  change_type TEXT NOT NULL,
  seasonal_controlled INTEGER NOT NULL,
  product_version_consistent INTEGER NOT NULL,
  field_review_required INTEGER NOT NULL,
  status TEXT NOT NULL
);

CREATE TABLE product_governance_log (
  governance_id TEXT PRIMARY KEY,
  date TEXT NOT NULL,
  product_id TEXT NOT NULL,
  decision TEXT NOT NULL,
  owner TEXT NOT NULL,
  status TEXT NOT NULL,
  public_note_required INTEGER NOT NULL
);

INSERT INTO platform_sensor_inventory VALUES
('landsat-8-9','satellite','NASA/USGS','optical_thermal','land|water|urban|ecosystems','moderate','repeat_global','global_archive','Long-term land and thermal observation archive'),
('sentinel-1','satellite','Copernicus/ESA','sar','flood|wetlands|ice|land','moderate','repeat_global','global_routine','SAR supports all-weather day-night monitoring'),
('sentinel-2','satellite','Copernicus/ESA','optical_multispectral','land|vegetation|water|coasts','moderate_to_high','repeat_global','global_routine','Multispectral land and coastal monitoring'),
('goes-r-series','satellite','NOAA','geostationary_optical_ir','weather|atmosphere|hazards','regional','continuous_regional','hemispheric','Continuous geostationary environmental monitoring'),
('uav-multispectral-001','drone','field_monitoring_team','multispectral','restoration|agriculture|habitat','very_high','tasked_local','local_site','Drone-based local validation and monitoring');

INSERT INTO remote_sensing_product_registry VALUES
('landsat-land-cover-change','landsat-8-9','land','optical_thermal','classification','L2_L3','land_cover_change','class_change','seasonal_to_annual','local_to_regional','classified_product','land_change_monitoring'),
('sentinel-sar-flood-extent','sentinel-1','flood','sar','classification','L2','water_extent','polygon','event_based','local_to_regional','retrieved_classification','hazard_response'),
('vegetation-stress-index','sentinel-2','biosphere','optical_multispectral','index','L2_L3','vegetation_stress','index','weekly_to_monthly','local_to_regional','retrieved_index','drought_and_ecosystem_monitoring'),
('urban-heat-thermal-field','landsat-8-9','urban_heat','thermal_ir','retrieval','L2','land_surface_temperature','celsius','seasonal','urban_regional','retrieved_product','urban_heat_assessment'),
('drone-restoration-cover','uav-multispectral-001','restoration','multispectral','classification','processed','vegetation_cover','percent','campaign_based','site_scale','classified_product','restoration_monitoring');

INSERT INTO product_readiness_scores VALUES
('landsat-land-cover-change','land','optical_thermal',0.82,0.86,0.80,0.76,0.82,0.88,0.82,0.74,0.84,1),
('sentinel-sar-flood-extent','flood','sar',0.84,0.82,0.76,0.74,0.80,0.72,0.82,0.68,0.88,1),
('vegetation-stress-index','biosphere','optical_ir_index',0.70,0.80,0.70,0.66,0.74,0.78,0.62,0.64,0.78,0),
('urban-heat-thermal-field','urban_heat','thermal_ir',0.78,0.84,0.78,0.76,0.80,0.70,0.80,0.72,0.86,1),
('drone-restoration-cover','restoration','multispectral',0.92,0.88,0.84,0.78,0.86,0.62,0.84,0.86,0.82,0);
