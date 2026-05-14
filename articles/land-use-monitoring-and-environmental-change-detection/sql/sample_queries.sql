.headers on
.mode column

SELECT
  product_id,
  geography,
  monitoring_purpose,
  classification_accuracy,
  temporal_consistency,
  ROUND(CAST(validated_change_samples AS REAL) / detected_change_samples, 3) AS change_confidence,
  reference_data_strength,
  condition_sensitivity,
  fragmentation_visibility,
  uncertainty_communication,
  reporting_readiness,
  ROUND(
    0.16 * classification_accuracy +
    0.14 * temporal_consistency +
    0.14 * (CAST(validated_change_samples AS REAL) / detected_change_samples) +
    0.14 * reference_data_strength +
    0.12 * condition_sensitivity +
    0.10 * fragmentation_visibility +
    0.10 * uncertainty_communication +
    0.10 * reporting_readiness,
    3
  ) AS land_evidence_quality
FROM land_monitoring_readiness_scores
ORDER BY land_evidence_quality ASC;

SELECT
  product_id,
  geography,
  CASE
    WHEN high_stakes_use = 1 AND classification_accuracy < 0.80 THEN 'high_stakes_accuracy_review'
    WHEN temporal_consistency < 0.75 THEN 'temporal_consistency_review'
    WHEN CAST(validated_change_samples AS REAL) / detected_change_samples < 0.75 THEN 'change_validation_review'
    WHEN reference_data_strength < 0.75 THEN 'reference_data_review'
    WHEN condition_sensitivity < 0.70 THEN 'condition_monitoring_review'
    WHEN fragmentation_visibility < 0.70 THEN 'fragmentation_visibility_review'
    WHEN uncertainty_communication < 0.75 THEN 'uncertainty_communication_review'
    WHEN reporting_readiness < 0.75 THEN 'reporting_readiness_review'
    ELSE 'routine_monitoring'
  END AS review_priority
FROM land_monitoring_readiness_scores
ORDER BY review_priority, product_id;

SELECT
  change_id,
  product_id,
  from_class,
  to_class,
  change_type,
  change_year,
  confidence,
  persistence_score,
  validated,
  reporting_relevance
FROM land_change_records
WHERE validated = 0
   OR confidence < 0.80
   OR persistence_score < 0.75;

SELECT
  assessment_id,
  product_id,
  class_name,
  users_accuracy,
  producers_accuracy,
  mapped_area_ha,
  adjusted_area_ha,
  ABS(mapped_area_ha - adjusted_area_ha) AS area_estimation_difference_ha
FROM accuracy_assessment
ORDER BY area_estimation_difference_ha DESC;
