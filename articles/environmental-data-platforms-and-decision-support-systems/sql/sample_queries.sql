.headers on
.mode column

SELECT
  asset_id,
  domain,
  asset_type,
  ROUND(
    0.22 * metadata_complete +
    0.20 * semantic_compatibility +
    0.22 * lineage_complete +
    0.18 * uncertainty_visible +
    0.18 * decision_fit,
    3
  ) AS platform_evidence_quality
FROM platform_assets
ORDER BY platform_evidence_quality ASC;

SELECT
  asset_id,
  domain,
  CASE
    WHEN is_high_stakes = 1 AND lineage_complete < 0.85 THEN 'high_stakes_lineage_review'
    WHEN metadata_complete < 0.75 THEN 'metadata_completeness_review'
    WHEN semantic_compatibility < 0.70 THEN 'semantic_integration_review'
    WHEN uncertainty_visible < 0.70 THEN 'uncertainty_visibility_review'
    WHEN decision_fit < 0.70 THEN 'decision_support_fit_review'
    ELSE 'routine_monitoring'
  END AS review_priority
FROM platform_assets
ORDER BY review_priority, asset_id;

SELECT
  crosswalk_id,
  source_field,
  target_concept,
  semantic_status
FROM semantic_crosswalk
WHERE semantic_status LIKE '%review%';
