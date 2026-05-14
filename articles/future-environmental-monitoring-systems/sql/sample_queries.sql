.headers on
.mode column

SELECT
  source_id,
  domain,
  source_type,
  ROUND(
    0.20 * quality_score +
    0.15 * coverage_score +
    0.15 * freshness_score +
    0.15 * interoperability_score +
    0.15 * provenance_score +
    0.10 * governance_score -
    0.10 * uncertainty_score,
    3
  ) AS decision_usefulness
FROM observation_sources
ORDER BY decision_usefulness DESC;

SELECT
  source_id,
  domain,
  CASE
    WHEN uncertainty_score > 0.35 THEN 'high_uncertainty_review'
    WHEN provenance_score < 0.70 THEN 'provenance_review'
    WHEN interoperability_score < 0.70 THEN 'interoperability_review'
    ELSE 'routine_monitoring'
  END AS review_priority
FROM observation_sources
ORDER BY review_priority;
