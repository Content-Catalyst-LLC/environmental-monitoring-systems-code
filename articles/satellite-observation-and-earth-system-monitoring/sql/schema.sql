DROP TABLE IF EXISTS mission_sensor_inventory;
DROP TABLE IF EXISTS satellite_product_registry;
DROP TABLE IF EXISTS calibration_validation_records;
DROP TABLE IF EXISTS product_readiness_scores;
DROP TABLE IF EXISTS continuity_transition_records;
DROP TABLE IF EXISTS product_governance_log;

CREATE TABLE mission_sensor_inventory (
  mission_id TEXT PRIMARY KEY,
  mission_family TEXT NOT NULL,
  agency TEXT NOT NULL,
  orbit_type TEXT NOT NULL,
  sensing_mode TEXT NOT NULL,
  primary_domains TEXT NOT NULL,
  revisit_category TEXT NOT NULL,
  coverage_scope TEXT NOT NULL,
  notes TEXT
);

CREATE TABLE satellite_product_registry (
  product_id TEXT PRIMARY KEY,
  mission_id TEXT NOT NULL,
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
  FOREIGN KEY (mission_id) REFERENCES mission_sensor_inventory(mission_id)
);

CREATE TABLE calibration_validation_records (
  record_id TEXT PRIMARY KEY,
  product_id TEXT NOT NULL,
  calibration_score REAL NOT NULL,
  validation_score REAL NOT NULL,
  uncertainty_characterized REAL NOT NULL,
  domain_suitability REAL NOT NULL,
  in_situ_validation REAL NOT NULL,
  validation_status TEXT NOT NULL,
  notes TEXT,
  FOREIGN KEY (product_id) REFERENCES satellite_product_registry(product_id)
);

CREATE TABLE product_readiness_scores (
  product_id TEXT PRIMARY KEY,
  domain TEXT NOT NULL,
  sensing_mode TEXT NOT NULL,
  usable_coverage REAL NOT NULL,
  calibration_score REAL NOT NULL,
  validation_score REAL NOT NULL,
  uncertainty_characterized REAL NOT NULL,
  domain_suitability REAL NOT NULL,
  continuity_score REAL NOT NULL,
  proxy_transparency REAL NOT NULL,
  in_situ_validation REAL NOT NULL,
  decision_fit REAL NOT NULL,
  high_stakes_use INTEGER NOT NULL
);

CREATE TABLE continuity_transition_records (
  transition_id TEXT PRIMARY KEY,
  product_family TEXT NOT NULL,
  from_mission TEXT NOT NULL,
  to_mission TEXT NOT NULL,
  transition_type TEXT NOT NULL,
  overlap_available INTEGER NOT NULL,
  cross_calibration_documented INTEGER NOT NULL,
  algorithm_version_change INTEGER NOT NULL,
  reprocessing_required INTEGER NOT NULL,
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

INSERT INTO mission_sensor_inventory VALUES
('goes-r-series','GOES','NOAA','geostationary','optical_ir_lightning','atmosphere|weather|hazards','continuous_regional','hemispheric','Continuous geostationary environmental monitoring'),
('sentinel-1','Sentinel','Copernicus/ESA','polar_low_earth','sar','land|flood|ice|ocean','repeat_global','global_routine','SAR supports all-weather day-night observation'),
('sentinel-2','Sentinel','Copernicus/ESA','polar_low_earth','optical_multispectral','land|water|vegetation|coasts','repeat_global','global_routine','Multispectral land and coastal monitoring'),
('terra-aqua-modis','EOS/NASA','NASA','polar_low_earth','optical_ir','land|ocean|atmosphere|fire','frequent_global','global','Long-running Earth observation products and climate-relevant records'),
('landsat-8-9','Landsat','NASA/USGS','polar_low_earth','optical_thermal','land|water|urban|ecosystems','repeat_global','global_archive','Long-term land observation archive');

INSERT INTO satellite_product_registry VALUES
('goes-storm-imagery','goes-r-series','atmosphere','geostationary_optical_ir','imagery','L1b_L2','cloud_and_storm_fields','various','minutes','regional','retrieved_or_visualized','weather_monitoring'),
('sentinel-flood-extent','sentinel-1','flood','sar','classification','L2','water_extent','polygon','event_based','local_to_regional','retrieved_classification','hazard_response'),
('vegetation-stress-index','terra-aqua-modis','biosphere','optical_ir','index','L3','vegetation_stress','index','daily_to_monthly','regional_to_global','retrieved_index','drought_and_ecosystem_monitoring'),
('sea-ice-continuity-record','terra-aqua-modis','cryosphere','microwave_optical','climate_record','L3','sea_ice_extent','area','daily_to_monthly','polar','retrieved_record','climate_monitoring'),
('land-cover-change','landsat-8-9','land','optical_thermal','classification','L2_L3','land_cover_class','class','seasonal_to_annual','local_to_regional','retrieved_classification','land_change_monitoring');

INSERT INTO product_readiness_scores VALUES
('goes-storm-imagery','atmosphere','geostationary_optical_ir',0.92,0.90,0.86,0.82,0.88,0.84,0.90,0.78,0.92,1),
('sentinel-flood-extent','flood','sar',0.82,0.88,0.76,0.74,0.80,0.72,0.82,0.68,0.86,1),
('vegetation-stress-index','biosphere','optical_ir',0.68,0.82,0.70,0.68,0.74,0.78,0.62,0.64,0.78,0),
('sea-ice-continuity-record','cryosphere','microwave',0.90,0.86,0.84,0.82,0.86,0.92,0.88,0.80,0.84,1),
('land-cover-change','land','optical_thermal',0.76,0.84,0.78,0.72,0.80,0.82,0.76,0.70,0.82,1);
