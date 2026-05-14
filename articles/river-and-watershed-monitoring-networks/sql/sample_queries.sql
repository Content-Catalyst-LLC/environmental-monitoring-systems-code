.headers on
.mode column

SELECT
  network_id,
  basin_context,
  geography,
  ROUND(
    0.12 * gauge_coverage +
    0.12 * water_quality_coverage +
    0.10 * ecological_coverage +
    0.13 * network_representativeness +
    0.12 * temporal_continuity +
    0.12 * event_capture +
    0.09 * uncertainty_communication +
    0.10 * interoperability +
    0.10 * governance_readiness,
    3
  ) AS watershed_evidence_quality
FROM watershed_monitoring_readiness_scores
ORDER BY watershed_evidence_quality ASC;

SELECT
  network_id,
  CASE
    WHEN high_stakes_use = 1 AND network_representativeness < 0.70 THEN 'high_stakes_representativeness_review'
    WHEN gauge_coverage < 0.70 THEN 'gauge_coverage_review'
    WHEN water_quality_coverage < 0.70 THEN 'water_quality_coverage_review'
    WHEN ecological_coverage < 0.65 THEN 'ecological_coverage_review'
    WHEN temporal_continuity < 0.70 THEN 'temporal_continuity_review'
    WHEN event_capture < 0.70 THEN 'event_capture_review'
    WHEN interoperability < 0.75 THEN 'interoperability_review'
    WHEN governance_readiness < 0.75 THEN 'governance_readiness_review'
    ELSE 'routine_monitoring'
  END AS review_priority
FROM watershed_monitoring_readiness_scores
ORDER BY review_priority, network_id;

SELECT
  station_id,
  constituent,
  event_flag,
  COUNT(*) AS records,
  ROUND(AVG(concentration_mg_L), 3) AS mean_concentration_mg_L,
  ROUND(SUM(instantaneous_load_kg_day), 2) AS total_instantaneous_load_kg_day,
  SUM(CASE WHEN quality_flag != 'pass' THEN 1 ELSE 0 END) AS review_records
FROM water_quality_load_records
GROUP BY station_id, constituent, event_flag
ORDER BY station_id, constituent;

SELECT
  health_id,
  station_id,
  ROUND(CAST(received_records AS REAL) / expected_records, 3) AS telemetry_completeness,
  median_latency_seconds,
  outage_minutes,
  rating_status,
  maintenance_status,
  status
FROM telemetry_station_health
WHERE status != 'pass' OR rating_status = 'review_required' OR maintenance_status = 'maintenance_due';
