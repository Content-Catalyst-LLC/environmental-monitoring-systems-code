.headers on
.mode column

SELECT
  product_id,
  domain,
  sensing_mode,
  ROUND(
    0.25 * calibration_score +
    0.30 * validation_score +
    0.25 * uncertainty_characterized +
    0.20 * domain_suitability,
    3
  ) AS retrieval_quality,
  ROUND(
    0.20 * usable_coverage +
    0.22 * (
      0.25 * calibration_score +
      0.30 * validation_score +
      0.25 * uncertainty_characterized +
      0.20 * domain_suitability
    ) +
    0.18 * continuity_score +
    0.15 * proxy_transparency +
    0.15 * in_situ_validation +
    0.10 * decision_fit,
    3
  ) AS satellite_evidence_quality
FROM product_readiness_scores
ORDER BY satellite_evidence_quality ASC;

SELECT
  product_id,
  domain,
  CASE
    WHEN high_stakes_use = 1 AND uncertainty_characterized < 0.80 THEN 'high_stakes_uncertainty_review'
    WHEN continuity_score < 0.70 THEN 'continuity_review'
    WHEN proxy_transparency < 0.75 THEN 'proxy_transparency_review'
    WHEN in_situ_validation < 0.70 THEN 'validation_review'
    WHEN decision_fit < 0.70 THEN 'decision_fit_review'
    ELSE 'routine_monitoring'
  END AS review_priority
FROM product_readiness_scores
ORDER BY review_priority, product_id;

SELECT
  transition_id,
  product_family,
  from_mission,
  to_mission,
  status
FROM continuity_transition_records
WHERE status LIKE '%review%';
