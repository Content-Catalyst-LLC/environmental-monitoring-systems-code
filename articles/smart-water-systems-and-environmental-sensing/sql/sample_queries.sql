.headers on
.mode column

SELECT
  program_id,
  water_domain,
  service_goal,
  ROUND(
    0.11 * sensing_coverage +
    0.13 * data_quality_validity +
    0.12 * telemetry_completeness +
    0.10 * latency_readiness +
    0.10 * anomaly_confidence +
    0.13 * response_capacity +
    0.10 * model_readiness +
    0.10 * control_safety +
    0.11 * governance_readiness,
    3
  ) AS smart_water_quality
FROM smart_water_readiness_scores
ORDER BY smart_water_quality ASC;

SELECT
  program_id,
  CASE
    WHEN high_stakes_use = 1 AND data_quality_validity < 0.75 THEN 'high_stakes_data_quality_review'
    WHEN telemetry_completeness < 0.80 THEN 'telemetry_completeness_review'
    WHEN response_capacity < 0.75 THEN 'response_capacity_review'
    WHEN control_safety < 0.75 THEN 'control_safety_review'
    WHEN model_readiness < 0.70 THEN 'model_readiness_review'
    WHEN governance_readiness < 0.75 THEN 'governance_readiness_review'
    ELSE 'routine_monitoring'
  END AS review_priority
FROM smart_water_readiness_scores;

SELECT
  telemetry_id,
  sensor_id,
  ROUND(CAST(received_readings AS REAL) / expected_readings, 3) AS telemetry_completeness,
  max_latency_seconds,
  outage_minutes,
  status
FROM telemetry_status_records
WHERE status != 'pass';
