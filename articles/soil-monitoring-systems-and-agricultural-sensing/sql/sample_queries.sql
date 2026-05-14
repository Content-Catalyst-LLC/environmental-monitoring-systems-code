.headers on
.mode column

SELECT
  program_id,
  crop_or_system,
  geography,
  ROUND(
    0.14 * spatial_representativeness +
    0.14 * depth_representation +
    0.14 * calibration_quality +
    0.12 * telemetry_completeness +
    0.12 * laboratory_support +
    0.10 * remote_product_agreement +
    0.10 * uncertainty_communication +
    0.14 * decision_readiness,
    3
  ) AS soil_evidence_quality
FROM soil_monitoring_readiness_scores
ORDER BY soil_evidence_quality ASC;

SELECT
  program_id,
  CASE
    WHEN high_stakes_use = 1 AND calibration_quality < 0.75 THEN 'high_stakes_calibration_review'
    WHEN spatial_representativeness < 0.70 THEN 'spatial_representativeness_review'
    WHEN depth_representation < 0.70 THEN 'depth_representation_review'
    WHEN telemetry_completeness < 0.80 THEN 'telemetry_completeness_review'
    WHEN remote_product_agreement < 0.70 THEN 'remote_product_validation_review'
    ELSE 'routine_monitoring'
  END AS review_priority
FROM soil_monitoring_readiness_scores;
