.headers on
.mode column

SELECT
  program_id,
  flood_type,
  geography,
  ROUND(
    0.12 * gauge_coverage +
    0.11 * rainfall_coverage +
    0.12 * telemetry_completeness +
    0.12 * forecast_confidence +
    0.11 * inundation_map_readiness +
    0.12 * protective_lead_time +
    0.10 * communication_readiness +
    0.10 * response_capacity +
    0.10 * governance_readiness,
    3
  ) AS flood_warning_quality
FROM flood_monitoring_readiness_scores
ORDER BY flood_warning_quality ASC;

SELECT
  program_id,
  flood_type,
  CASE
    WHEN high_stakes_use = 1 AND telemetry_completeness < 0.80 THEN 'high_stakes_telemetry_review'
    WHEN gauge_coverage < 0.70 THEN 'gauge_coverage_review'
    WHEN rainfall_coverage < 0.70 THEN 'rainfall_coverage_review'
    WHEN forecast_confidence < 0.70 THEN 'forecast_confidence_review'
    WHEN inundation_map_readiness < 0.70 THEN 'inundation_mapping_review'
    WHEN protective_lead_time < 0.70 THEN 'lead_time_review'
    WHEN communication_readiness < 0.75 THEN 'communication_readiness_review'
    WHEN response_capacity < 0.75 THEN 'response_capacity_review'
    WHEN governance_readiness < 0.75 THEN 'governance_readiness_review'
    ELSE 'routine_monitoring'
  END AS review_priority
FROM flood_monitoring_readiness_scores
ORDER BY review_priority, program_id;

SELECT
  telemetry_id,
  station_id,
  ROUND(CAST(received_observations AS REAL) / expected_observations, 3) AS telemetry_completeness,
  max_latency_seconds,
  outage_minutes,
  status
FROM telemetry_status_records
WHERE status != 'pass';

SELECT
  threshold_id,
  station_id,
  threshold_name,
  stage_ft,
  impact_description,
  response_action,
  review_status
FROM threshold_impact_registry
WHERE review_status != 'approved';
