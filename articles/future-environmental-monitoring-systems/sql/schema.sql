DROP TABLE IF EXISTS observation_sources;
DROP TABLE IF EXISTS environmental_observations;
DROP TABLE IF EXISTS model_outputs;
DROP TABLE IF EXISTS provenance_records;

CREATE TABLE observation_sources (
  source_id TEXT PRIMARY KEY,
  domain TEXT NOT NULL,
  source_type TEXT NOT NULL,
  coverage_score REAL NOT NULL,
  freshness_score REAL NOT NULL,
  quality_score REAL NOT NULL,
  interoperability_score REAL NOT NULL,
  provenance_score REAL NOT NULL,
  governance_score REAL NOT NULL,
  uncertainty_score REAL NOT NULL,
  notes TEXT
);

CREATE TABLE environmental_observations (
  observation_id TEXT PRIMARY KEY,
  source_id TEXT NOT NULL,
  observed_property TEXT NOT NULL,
  value REAL NOT NULL,
  unit TEXT NOT NULL,
  timestamp TEXT NOT NULL,
  latitude REAL NOT NULL,
  longitude REAL NOT NULL,
  quality_flag TEXT NOT NULL,
  uncertainty REAL,
  FOREIGN KEY (source_id) REFERENCES observation_sources(source_id)
);

CREATE TABLE model_outputs (
  output_id TEXT PRIMARY KEY,
  model_id TEXT NOT NULL,
  source_id TEXT NOT NULL,
  output_type TEXT NOT NULL,
  confidence REAL,
  uncertainty REAL,
  processing_version TEXT NOT NULL,
  created_at TEXT NOT NULL,
  FOREIGN KEY (source_id) REFERENCES observation_sources(source_id)
);

CREATE TABLE provenance_records (
  provenance_id TEXT PRIMARY KEY,
  output_id TEXT NOT NULL,
  source_id TEXT NOT NULL,
  transformation_step TEXT NOT NULL,
  processing_version TEXT NOT NULL,
  created_at TEXT NOT NULL,
  FOREIGN KEY (output_id) REFERENCES model_outputs(output_id),
  FOREIGN KEY (source_id) REFERENCES observation_sources(source_id)
);

INSERT INTO observation_sources VALUES
('sat-landsurface-001','land','earth_observation',0.95,0.80,0.82,0.90,0.88,0.78,0.22,'Satellite-derived land surface monitoring product'),
('sensor-water-001','water','field_sensor',0.55,0.92,0.76,0.70,0.65,0.72,0.30,'Watershed water-quality sensor stream'),
('community-heat-001','urban_heat','community_observation',0.40,0.85,0.62,0.55,0.58,0.80,0.38,'Community heat exposure monitoring network'),
('model-air-001','air_quality','ai_model',0.75,0.88,0.79,0.76,0.70,0.68,0.28,'AI-supported air-quality estimation model');
