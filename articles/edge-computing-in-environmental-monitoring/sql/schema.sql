DROP TABLE IF EXISTS edge_device_registry;
DROP TABLE IF EXISTS edge_rule_registry;
DROP TABLE IF EXISTS edge_model_registry;
DROP TABLE IF EXISTS edge_readiness_scores;
DROP TABLE IF EXISTS edge_event_records;
DROP TABLE IF EXISTS edge_governance_log;

CREATE TABLE edge_device_registry (
  device_id TEXT PRIMARY KEY,
  domain TEXT NOT NULL,
  site_id TEXT NOT NULL,
  edge_component_type TEXT NOT NULL,
  observed_property TEXT NOT NULL,
  unit TEXT NOT NULL,
  processor_class TEXT NOT NULL,
  firmware_version TEXT NOT NULL,
  calibration_status TEXT NOT NULL,
  power_mode TEXT NOT NULL,
  connectivity_mode TEXT NOT NULL,
  owner TEXT NOT NULL,
  high_stakes_use INTEGER NOT NULL,
  notes TEXT
);

CREATE TABLE edge_rule_registry (
  edge_rule_id TEXT PRIMARY KEY,
  component_id TEXT NOT NULL,
  rule_type TEXT NOT NULL,
  observed_property TEXT NOT NULL,
  threshold_or_method TEXT NOT NULL,
  version TEXT NOT NULL,
  owner TEXT NOT NULL,
  autonomy_level TEXT NOT NULL,
  retention_requirement TEXT NOT NULL,
  review_status TEXT NOT NULL
);

CREATE TABLE edge_model_registry (
  model_id TEXT PRIMARY KEY,
  component_id TEXT NOT NULL,
  domain TEXT NOT NULL,
  model_type TEXT NOT NULL,
  input_signal TEXT NOT NULL,
  output_label TEXT NOT NULL,
  model_version TEXT NOT NULL,
  training_domain TEXT NOT NULL,
  confidence_required REAL NOT NULL,
  drift_monitoring_status TEXT NOT NULL,
  review_status TEXT NOT NULL
);

CREATE TABLE edge_readiness_scores (
  component_id TEXT PRIMARY KEY,
  domain TEXT NOT NULL,
  component_type TEXT NOT NULL,
  observed_latency_seconds REAL NOT NULL,
  target_latency_seconds REAL NOT NULL,
  raw_data_mb REAL NOT NULL,
  transmitted_data_mb REAL NOT NULL,
  discarded_without_audit_mb REAL NOT NULL,
  retained_context_score REAL NOT NULL,
  edge_traceability REAL NOT NULL,
  qc_readiness REAL NOT NULL,
  inference_transparency REAL NOT NULL,
  decision_fit REAL NOT NULL,
  high_stakes_use INTEGER NOT NULL
);

CREATE TABLE edge_event_records (
  event_id TEXT PRIMARY KEY,
  component_id TEXT NOT NULL,
  edge_rule_id TEXT NOT NULL,
  event_type TEXT NOT NULL,
  phenomenon_time TEXT NOT NULL,
  result_time TEXT NOT NULL,
  ingested_at TEXT NOT NULL,
  confidence REAL,
  quality_flag TEXT NOT NULL,
  raw_context_retained INTEGER NOT NULL,
  delayed_record INTEGER NOT NULL,
  notes TEXT
);

CREATE TABLE edge_governance_log (
  governance_id TEXT PRIMARY KEY,
  date TEXT NOT NULL,
  component_id TEXT NOT NULL,
  decision TEXT NOT NULL,
  owner TEXT NOT NULL,
  status TEXT NOT NULL,
  public_note_required INTEGER NOT NULL
);

INSERT INTO edge_device_registry VALUES
('edge-river-001','water','river-station-a','gateway_threshold_engine','water_level','m','embedded_linux','v1.4.2','valid','solar_battery','cellular','hydrology_team',1,'Flood threshold gateway with local alerting'),
('edge-acoustic-002','biodiversity','forest-site-b','edge_audio_classifier','bird_call_detection','count','arm_sbc','v0.8.5','valid','battery_solar','mesh_to_cellular','ecology_team',0,'Acoustic biodiversity node with local classification'),
('edge-sonde-003','water_quality','reservoir-site-c','local_qc_alert_node','turbidity','ntu','embedded_linux','v2.0.1','valid','solar_battery','cellular','water_quality_team',1,'Water-quality sonde with local QC and thresholds'),
('edge-smoke-004','air_quality','wildfire-watch-d','image_event_detector','smoke_plume_detection','binary','gpu_edge_node','v1.1.0','valid','mains_backup','cellular','sensor_ops_team',1,'Camera edge node for smoke detection'),
('edge-storm-006','infrastructure','stormwater-site-f','local_alarm_gateway','flow_rate','l_s','embedded_linux','v1.2.0','expired','mains','wired','stormwater_team',1,'Stormwater edge gateway with expired calibration');

INSERT INTO edge_rule_registry VALUES
('edge-water-threshold-001','flood-threshold-gateway','threshold','water_level','greater_than_3_2m','v1.0','hydrology_team','alert','pre_post_event_window_10min','approved'),
('edge-acoustic-classifier-001','acoustic-biodiversity-node','classification','bird_call_detection','edge_audio_model_confidence_0_70','v0.8','ecology_team','infer','retain_low_confidence_samples','review_required'),
('edge-turbidity-qc-001','water-quality-edge-sonde','qc_and_threshold','turbidity','range_spike_flatline_and_threshold','v1.2','water_quality_team','alert','retain_raw_when_qc_fails','approved'),
('edge-smoke-detection-001','wildfire-smoke-camera-edge','image_detection','smoke_plume_detection','image_model_confidence_0_75','v1.1','sensor_ops_team','alert','retain_event_clip_and_audit_sample','review_required'),
('edge-flow-alarm-001','stormwater-flow-alert-system','local_alarm','flow_rate','greater_than_750_l_s','v1.0','stormwater_team','alert','retain_raw_and_action_log','review_required');

INSERT INTO edge_readiness_scores VALUES
('flood-threshold-gateway','water','gateway_threshold_engine',8,15,120,22,6,0.84,0.82,0.86,0.80,0.90,1),
('acoustic-biodiversity-node','biodiversity','edge_audio_classifier',45,60,850,40,320,0.62,0.70,0.76,0.68,0.72,0),
('water-quality-edge-sonde','water_quality','local_qc_and_alert_node',18,20,75,28,4,0.88,0.78,0.82,0.76,0.86,1),
('wildfire-smoke-camera-edge','air_quality','image_event_detector',20,30,1500,60,260,0.72,0.76,0.80,0.78,0.84,1),
('stormwater-flow-alert-system','infrastructure','local_alarm_gateway',6,5,95,35,12,0.82,0.74,0.76,0.72,0.86,1);

INSERT INTO edge_event_records VALUES
('evt-001','flood-threshold-gateway','edge-water-threshold-001','threshold_crossing','2026-05-14T12:00:00Z','2026-05-14T12:00:03Z','2026-05-14T12:00:11Z',0.94,'pass',1,0,'Water level exceeded local threshold'),
('evt-002','acoustic-biodiversity-node','edge-acoustic-classifier-001','local_classification','2026-05-14T04:32:00Z','2026-05-14T04:32:08Z','2026-05-14T05:20:00Z',0.72,'review_required',1,1,'Bird-call detection delayed through mesh gateway'),
('evt-003','water-quality-edge-sonde','edge-turbidity-qc-001','qc_failure','2026-05-14T12:10:00Z','2026-05-14T12:10:04Z','2026-05-14T12:10:16Z',0.88,'suspect',1,0,'Turbidity spike flagged for review'),
('evt-004','wildfire-smoke-camera-edge','edge-smoke-detection-001','image_detection','2026-05-14T13:05:00Z','2026-05-14T13:05:09Z','2026-05-14T13:05:25Z',0.79,'preliminary',1,0,'Smoke-like plume detected by edge image model'),
('evt-005','stormwater-flow-alert-system','edge-flow-alarm-001','local_alarm','2026-05-14T13:10:00Z','2026-05-14T13:10:02Z','2026-05-14T13:10:09Z',0.91,'calibration_expired',1,0,'Flow alarm issued but calibration is expired');
