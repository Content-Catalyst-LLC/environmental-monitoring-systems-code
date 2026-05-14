DROP TABLE IF EXISTS resilience_units;
DROP TABLE IF EXISTS hazard_inventory;
DROP TABLE IF EXISTS exposure_registry;
DROP TABLE IF EXISTS recovery_trajectories;
DROP TABLE IF EXISTS threshold_registry;
DROP TABLE IF EXISTS post_event_learning;

CREATE TABLE resilience_units (
  unit_id TEXT PRIMARY KEY,
  domain TEXT NOT NULL,
  hazard_score REAL NOT NULL,
  exposure_score REAL NOT NULL,
  vulnerability_score REAL NOT NULL,
  capacity_score REAL NOT NULL,
  redundancy_score REAL NOT NULL,
  learning_score REAL NOT NULL,
  governance_score REAL NOT NULL,
  ecological_condition_score REAL NOT NULL,
  threshold_proximity REAL NOT NULL,
  recovery_ratio REAL NOT NULL,
  notes TEXT
);

CREATE TABLE hazard_inventory (
  hazard_id TEXT PRIMARY KEY,
  hazard_type TEXT NOT NULL,
  indicator TEXT NOT NULL,
  unit TEXT NOT NULL,
  current_value REAL NOT NULL,
  warning_threshold REAL NOT NULL,
  critical_threshold REAL NOT NULL,
  freshness_hours REAL NOT NULL,
  source TEXT NOT NULL
);

CREATE TABLE exposure_registry (
  exposure_id TEXT PRIMARY KEY,
  unit_id TEXT NOT NULL,
  exposure_type TEXT NOT NULL,
  count_or_value REAL NOT NULL,
  critical_service INTEGER NOT NULL,
  notes TEXT,
  FOREIGN KEY (unit_id) REFERENCES resilience_units(unit_id)
);

CREATE TABLE recovery_trajectories (
  recovery_id INTEGER PRIMARY KEY AUTOINCREMENT,
  unit_id TEXT NOT NULL,
  domain TEXT NOT NULL,
  days_after_event INTEGER NOT NULL,
  function_restored REAL NOT NULL,
  target_function REAL NOT NULL,
  vulnerability_score REAL NOT NULL,
  FOREIGN KEY (unit_id) REFERENCES resilience_units(unit_id)
);

CREATE TABLE threshold_registry (
  threshold_id TEXT PRIMARY KEY,
  domain TEXT NOT NULL,
  variable TEXT NOT NULL,
  warning_value REAL NOT NULL,
  critical_value REAL NOT NULL,
  unit TEXT NOT NULL,
  escalation_action TEXT NOT NULL
);

CREATE TABLE post_event_learning (
  learning_id TEXT PRIMARY KEY,
  unit_id TEXT NOT NULL,
  event_name TEXT NOT NULL,
  lesson TEXT NOT NULL,
  adaptation_action TEXT NOT NULL,
  residual_risk_review TEXT NOT NULL,
  FOREIGN KEY (unit_id) REFERENCES resilience_units(unit_id)
);

INSERT INTO resilience_units VALUES
('urban-heat-zone-001','urban_heat',0.86,0.82,0.74,0.42,0.35,0.52,0.58,0.40,0.91,0.55,'High heat exposure with low cooling and social capacity'),
('watershed-002','flood_risk',0.78,0.65,0.55,0.62,0.58,0.64,0.67,0.72,0.82,0.70,'Watershed with moderate flood risk and partial recovery'),
('coastal-wetland-003','coastal_resilience',0.70,0.60,0.48,0.66,0.70,0.60,0.64,0.78,0.74,0.76,'Coastal wetland with ecological buffering capacity'),
('forest-fire-zone-004','wildfire',0.88,0.58,0.62,0.46,0.44,0.50,0.55,0.52,0.93,0.50,'Wildfire-prone area approaching threshold escalation');
