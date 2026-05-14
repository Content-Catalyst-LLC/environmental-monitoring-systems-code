.headers on
.mode column

SELECT
  network_id,
  domain,
  network_type,
  ROUND(MAX(0, MIN(1, monitored_area_km2 / target_area_km2)), 3) AS spatial_coverage,
  ROUND(MAX(0, MIN(1, CAST(valid_time_steps AS REAL) / expected_time_steps)), 3) AS temporal_completeness,
  ROUND(MAX(0, MIN(1, CAST(active_nodes AS REAL) / deployed_nodes)), 3) AS network_availability,
  ROUND(MAX(0, 1 - MIN(observed_latency_minutes / target_latency_minutes, 1)), 3) AS latency_readiness,
  ROUND(
    0.14 * MAX(0, MIN(1, monitored_area_km2 / target_area_km2)) +
    0.14 * MAX(0, MIN(1, CAST(valid_time_steps AS REAL) / expected_time_steps)) +
    0.14 * MAX(0, MIN(1, CAST(active_nodes AS REAL) / deployed_nodes)) +
    0.14 * representativeness +
    0.14 * valid_data_share +
    0.12 * metadata_maturity +
    0.10 * MAX(0, 1 - MIN(observed_latency_minutes / target_latency_minutes, 1)) +
    0.08 * action_fit,
    3
  ) AS network_evidence_quality
FROM network_readiness_scores
ORDER BY network_evidence_quality ASC;

SELECT
  network_id,
  domain,
  CASE
    WHEN high_stakes_use = 1 AND valid_data_share < 0.80 THEN 'high_stakes_quality_review'
    WHEN MAX(0, MIN(1, monitored_area_km2 / target_area_km2)) < 0.70 THEN 'coverage_review'
    WHEN MAX(0, MIN(1, CAST(valid_time_steps AS REAL) / expected_time_steps)) < 0.80 THEN 'temporal_completeness_review'
    WHEN MAX(0, MIN(1, CAST(active_nodes AS REAL) / deployed_nodes)) < 0.80 THEN 'node_availability_review'
    WHEN representativeness < 0.75 THEN 'representativeness_review'
    WHEN metadata_maturity < 0.75 THEN 'metadata_interoperability_review'
    WHEN MAX(0, 1 - MIN(observed_latency_minutes / target_latency_minutes, 1)) < 0.25 THEN 'latency_readiness_review'
    WHEN action_fit < 0.75 THEN 'action_fit_review'
    ELSE 'routine_monitoring'
  END AS review_priority
FROM network_readiness_scores
ORDER BY review_priority, network_id;

SELECT
  node_id,
  network_id,
  observed_property,
  calibration_status,
  high_stakes_use
FROM node_site_registry
WHERE calibration_status != 'valid'
   OR high_stakes_use = 1;

SELECT
  audit_id,
  network_id,
  coverage_dimension,
  target_group_or_zone,
  coverage_score,
  priority
FROM coverage_equity_audit
WHERE coverage_score < 0.70
ORDER BY priority, coverage_score;

SELECT
  observation_id,
  node_id,
  network_id,
  observed_property,
  value,
  unit,
  quality_flag,
  calibration_status
FROM network_observation_records
WHERE quality_flag != 'pass'
   OR calibration_status != 'valid';
