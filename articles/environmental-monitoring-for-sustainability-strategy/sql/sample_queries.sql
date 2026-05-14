.headers on
.mode column

SELECT
  indicator_id,
  domain,
  indicator_type,
  ROUND(
    0.20 * metadata_score +
    0.20 * validation_score +
    0.20 * lineage_score +
    0.20 * uncertainty_score +
    0.20 * conceptual_relevance_score,
    3
  ) AS indicator_integrity,
  ROUND((current_value - target_value) / NULLIF((baseline_value - target_value), 0), 3) AS target_gap,
  ROUND((threshold_value - current_value) / NULLIF(threshold_value, 0), 3) AS threshold_distance
FROM indicator_registry
ORDER BY threshold_distance ASC;

SELECT
  indicator_id,
  domain,
  CASE
    WHEN ROUND((threshold_value - current_value) / NULLIF(threshold_value, 0), 3) <= 0.10 THEN 'threshold_proximity_review'
    WHEN (
      0.20 * metadata_score +
      0.20 * validation_score +
      0.20 * lineage_score +
      0.20 * uncertainty_score +
      0.20 * conceptual_relevance_score
    ) < 0.70 THEN 'indicator_integrity_review'
    WHEN material_finding = 1 AND corrective_action_taken = 0 THEN 'feedback_failure_review'
    WHEN material_finding = 1 AND publicly_reviewable = 0 THEN 'accountability_review'
    ELSE 'routine_monitoring'
  END AS review_priority
FROM indicator_registry
ORDER BY review_priority;
