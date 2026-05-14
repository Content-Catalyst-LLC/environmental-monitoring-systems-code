.headers on
.mode column

SELECT
  program_id,
  domain,
  climate_variable,
  ROUND(
    0.15 * record_continuity +
    0.13 * metadata_completeness +
    0.14 * calibration_quality +
    0.13 * homogenization_readiness +
    0.13 * spatial_coverage +
    0.11 * version_control +
    0.10 * uncertainty_communication +
    0.11 * governance_readiness,
    3
  ) AS climate_record_quality
FROM climate_monitoring_readiness_scores
ORDER BY climate_record_quality ASC;

SELECT
  program_id,
  CASE
    WHEN high_stakes_use = 1 AND record_continuity < 0.75 THEN 'high_stakes_record_continuity_review'
    WHEN metadata_completeness < 0.75 THEN 'metadata_completeness_review'
    WHEN calibration_quality < 0.75 THEN 'calibration_quality_review'
    WHEN homogenization_readiness < 0.75 THEN 'homogenization_readiness_review'
    WHEN spatial_coverage < 0.70 THEN 'spatial_coverage_review'
    WHEN version_control < 0.75 THEN 'version_control_review'
    WHEN uncertainty_communication < 0.75 THEN 'uncertainty_communication_review'
    WHEN governance_readiness < 0.75 THEN 'governance_readiness_review'
    ELSE 'routine_monitoring'
  END AS review_priority
FROM climate_monitoring_readiness_scores
ORDER BY review_priority, program_id;

SELECT
  record_id,
  climate_variable,
  COUNT(*) AS records,
  ROUND(AVG(anomaly), 3) AS mean_anomaly,
  ROUND(MAX(anomaly), 3) AS max_anomaly,
  SUM(trend_ready) AS trend_ready_records
FROM climate_indicator_anomaly_table
GROUP BY record_id, climate_variable
ORDER BY record_id;

SELECT
  platform_id,
  climate_variable,
  status,
  COUNT(*) AS adjustments,
  SUM(CASE WHEN status != 'pass' THEN 1 ELSE 0 END) AS review_items
FROM homogenization_adjustment_log
GROUP BY platform_id, climate_variable, status
ORDER BY review_items DESC, platform_id;
