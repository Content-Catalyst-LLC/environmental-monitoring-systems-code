.headers on
.mode column

SELECT
  program_id,
  monitoring_purpose,
  pollutant_focus,
  ROUND(
    0.15 * calibration_quality +
    0.14 * data_completeness +
    0.13 * spatial_coverage +
    0.12 * temporal_coverage +
    0.12 * meteorological_context +
    0.13 * exposure_relevance +
    0.10 * uncertainty_communication +
    0.11 * governance_readiness,
    3
  ) AS air_evidence_quality
FROM air_quality_monitoring_readiness_scores
ORDER BY air_evidence_quality ASC;

SELECT
  program_id,
  CASE
    WHEN high_stakes_use = 1 AND calibration_quality < 0.75 THEN 'high_stakes_calibration_review'
    WHEN data_completeness < 0.75 THEN 'data_completeness_review'
    WHEN spatial_coverage < 0.70 THEN 'spatial_coverage_review'
    WHEN temporal_coverage < 0.75 THEN 'temporal_coverage_review'
    WHEN meteorological_context < 0.70 THEN 'meteorological_context_review'
    WHEN exposure_relevance < 0.70 THEN 'exposure_relevance_review'
    WHEN uncertainty_communication < 0.75 THEN 'uncertainty_communication_review'
    WHEN governance_readiness < 0.75 THEN 'governance_readiness_review'
    ELSE 'routine_monitoring'
  END AS review_priority
FROM air_quality_monitoring_readiness_scores
ORDER BY review_priority, program_id;

SELECT
  pollutant,
  unit,
  COUNT(*) AS observations,
  ROUND(AVG(value), 3) AS mean_value,
  ROUND(MAX(value), 3) AS max_value,
  SUM(CASE WHEN qc_flag != 'pass' THEN 1 ELSE 0 END) AS review_required
FROM pollutant_observation_records
GROUP BY pollutant, unit
ORDER BY review_required DESC, pollutant;

SELECT
  sensor_id,
  status,
  COUNT(*) AS calibration_events,
  SUM(CASE WHEN status != 'pass' THEN 1 ELSE 0 END) AS review_items
FROM calibration_collocation_log
GROUP BY sensor_id, status
ORDER BY review_items DESC, sensor_id;
