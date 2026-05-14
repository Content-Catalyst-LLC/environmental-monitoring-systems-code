DROP TABLE IF EXISTS basin_topology_edges;
DROP TABLE IF EXISTS monitoring_node_registry;
DROP TABLE IF EXISTS hydrological_driver_matrix;
DROP TABLE IF EXISTS telemetry_station_health;
DROP TABLE IF EXISTS water_quality_load_records;
DROP TABLE IF EXISTS ecological_assessment_registry;
DROP TABLE IF EXISTS representativeness_audit;
DROP TABLE IF EXISTS watershed_monitoring_readiness_scores;
DROP TABLE IF EXISTS watershed_governance_log;

CREATE TABLE basin_topology_edges (
  edge_id TEXT PRIMARY KEY,
  from_node TEXT,
  to_node TEXT,
  relation TEXT,
  stream_order TEXT,
  upstream_area_km2 REAL,
  notes TEXT
);

CREATE TABLE monitoring_node_registry (
  node_id TEXT PRIMARY KEY,
  station_id TEXT,
  station_name TEXT,
  site_type TEXT,
  basin_position TEXT,
  monitored_variables TEXT,
  latitude REAL,
  longitude REAL,
  upstream_area_km2 REAL,
  agency TEXT,
  continuity_status TEXT,
  telemetry_status TEXT
);

CREATE TABLE hydrological_driver_matrix (
  driver_id TEXT PRIMARY KEY,
  driver_name TEXT,
  basin_process TEXT,
  measurement_sources TEXT,
  decision_relevance TEXT,
  primary_uncertainty TEXT
);

CREATE TABLE telemetry_station_health (
  health_id TEXT PRIMARY KEY,
  station_id TEXT,
  window_start TEXT,
  window_end TEXT,
  expected_records INTEGER,
  received_records INTEGER,
  median_latency_seconds REAL,
  outage_minutes REAL,
  rating_status TEXT,
  maintenance_status TEXT,
  status TEXT
);

CREATE TABLE water_quality_load_records (
  record_id TEXT PRIMARY KEY,
  station_id TEXT,
  timestamp TEXT,
  constituent TEXT,
  concentration_mg_L REAL,
  discharge_m3_s REAL,
  instantaneous_load_kg_day REAL,
  event_flag TEXT,
  method TEXT,
  quality_flag TEXT
);

CREATE TABLE ecological_assessment_registry (
  assessment_id TEXT PRIMARY KEY,
  station_id TEXT,
  assessment_date TEXT,
  protocol TEXT,
  indicator TEXT,
  value REAL,
  unit TEXT,
  season TEXT,
  habitat_context TEXT,
  quality_flag TEXT
);

CREATE TABLE representativeness_audit (
  audit_id TEXT PRIMARY KEY,
  network_id TEXT,
  coverage_dimension TEXT,
  target_zone_or_process TEXT,
  coverage_score REAL,
  evidence_gap TEXT,
  priority TEXT,
  notes TEXT
);

CREATE TABLE watershed_monitoring_readiness_scores (
  network_id TEXT PRIMARY KEY,
  basin_context TEXT,
  geography TEXT,
  gauge_coverage REAL,
  water_quality_coverage REAL,
  ecological_coverage REAL,
  network_representativeness REAL,
  temporal_continuity REAL,
  event_capture REAL,
  uncertainty_communication REAL,
  interoperability REAL,
  governance_readiness REAL,
  high_stakes_use INTEGER
);

CREATE TABLE watershed_governance_log (
  governance_id TEXT PRIMARY KEY,
  date TEXT,
  network_id TEXT,
  decision TEXT,
  owner TEXT,
  status TEXT,
  public_note_required INTEGER
);

INSERT INTO watershed_monitoring_readiness_scores VALUES
('mainstem-integrated-basin-network','large_river_basin','regional_watershed',0.84,0.78,0.72,0.80,0.86,0.76,0.78,0.82,0.84,1),
('headwater-source-area-network','headwater_tributaries','upper_basin',0.68,0.72,0.70,0.66,0.74,0.64,0.72,0.70,0.72,1),
('urban-tributary-load-network','urbanizing_subbasins','metro_watershed',0.72,0.80,0.62,0.70,0.78,0.82,0.76,0.74,0.76,1),
('transboundary-data-sharing-network','cross_jurisdictional_basin','multi_agency_watershed',0.76,0.70,0.66,0.72,0.80,0.68,0.74,0.62,0.68,1),
('groundwater-connected-reach-review','groundwater_surface_water_exchange','lower_basin',0.70,0.68,0.60,0.64,0.66,0.62,0.70,0.66,0.70,1);

INSERT INTO water_quality_load_records VALUES
('load-001','st-002','2026-05-01T08:00:00Z','nitrate',4.2,8.5,3084.48,'baseflow','sensor_flow_paired','pass'),
('load-002','st-002','2026-05-01T12:00:00Z','nitrate',5.8,22.0,11024.64,'storm_event','sensor_flow_paired','pass'),
('load-003','st-003','2026-05-01T12:00:00Z','total_phosphorus',0.18,12.0,186.62,'storm_event','grab_sample_interpolated','review_required'),
('load-004','st-006','2026-05-01T12:00:00Z','suspended_sediment',85.0,65.0,477360.00,'storm_event','autosampler_flow_paired','pass'),
('load-005','st-007','2026-05-01T12:00:00Z','nitrate',3.4,88.0,25850.88,'storm_event','sensor_flow_paired','pass');

INSERT INTO telemetry_station_health VALUES
('health-001','st-001','2026-05-01T00:00:00Z','2026-05-01T12:00:00Z',48,48,35,0,'current','current','pass'),
('health-002','st-002','2026-05-01T00:00:00Z','2026-05-01T12:00:00Z',48,46,45,10,'current','current','pass'),
('health-003','st-003','2026-05-01T00:00:00Z','2026-05-01T12:00:00Z',24,22,70,20,'NA','current','review_required'),
('health-004','st-006','2026-05-01T00:00:00Z','2026-05-01T12:00:00Z',48,44,80,35,'review_required','maintenance_due','review_required');
