.headers on
.mode column

SELECT
  device_id,
  domain,
  device_type,
  ROUND(MAX(0, MIN(1, valid_operation_hours / deployment_hours)), 3) AS device_availability,
  ROUND(MAX(0, MIN(1, CAST(valid_records AS REAL) / expected_records)), 3) AS record_completeness,
  ROUND(MAX(0, MIN(1, 0.5 + ((energy_available_wh - energy_required_wh) / energy_required_wh))), 3) AS power_margin_score,
  ROUND(MAX(0, 1 - MIN(ABS(clock_drift_seconds) / allowed_clock_drift_seconds, 1)), 3) AS timing_consistency,
  ROUND(
    0.16 * MAX(0, MIN(1, valid_operation_hours / deployment_hours)) +
    0.16 * MAX(0, MIN(1, CAST(valid_records AS REAL) / expected_records)) +
    0.14 * MAX(0, MIN(1, 0.5 + ((energy_available_wh - energy_required_wh) / energy_required_wh))) +
    0.16 * calibration_validity +
    0.12 * MAX(0, 1 - MIN(ABS(clock_drift_seconds) / allowed_clock_drift_seconds, 1)) +
    0.14 * qc_readiness +
    0.12 * health_visibility +
    0.10 * decision_fit,
    3
  ) AS field_evidence_quality
FROM embedded_device_readiness_scores
ORDER BY field_evidence_quality ASC;

SELECT
  device_id,
  domain,
  CASE
    WHEN high_stakes_use = 1 AND calibration_validity < 0.80 THEN 'high_stakes_calibration_review'
    WHEN MAX(0, MIN(1, valid_operation_hours / deployment_hours)) < 0.75 THEN 'device_availability_review'
    WHEN MAX(0, MIN(1, CAST(valid_records AS REAL) / expected_records)) < 0.80 THEN 'record_completeness_review'
    WHEN MAX(0, MIN(1, 0.5 + ((energy_available_wh - energy_required_wh) / energy_required_wh))) < 0.50 THEN 'power_budget_review'
    WHEN MAX(0, 1 - MIN(ABS(clock_drift_seconds) / allowed_clock_drift_seconds, 1)) < 0.75 THEN 'timing_integrity_review'
    WHEN qc_readiness < 0.75 THEN 'qaqc_readiness_review'
    WHEN health_visibility < 0.75 THEN 'device_health_visibility_review'
    WHEN decision_fit < 0.75 THEN 'decision_fit_review'
    ELSE 'routine_monitoring'
  END AS review_priority
FROM embedded_device_readiness_scores
ORDER BY review_priority, device_id;

SELECT
  device_id,
  domain,
  observed_property,
  calibration_status,
  high_stakes_use
FROM device_sensor_registry
WHERE calibration_status != 'valid'
   OR high_stakes_use = 1;

SELECT
  observation_id,
  device_id,
  observed_property,
  value,
  unit,
  quality_flag,
  calibration_status
FROM field_observation_records
WHERE quality_flag != 'pass'
   OR calibration_status != 'valid';
