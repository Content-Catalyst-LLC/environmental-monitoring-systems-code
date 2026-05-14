.headers on
.mode column

SELECT
  product_id,
  domain,
  sensing_mode,
  ROUND(
    0.25 * correction_quality +
    0.30 * validation_score +
    0.25 * uncertainty_characterized +
    0.20 * domain_suitability,
    3
  ) AS inference_quality,
  ROUND(
    0.20 * valid_coverage +
    0.22 * (
      0.25 * correction_quality +
      0.30 * validation_score +
      0.25 * uncertainty_characterized +
      0.20 * domain_suitability
    ) +
    0.18 * time_series_continuity +
    0.15 * proxy_transparency +
    0.15 * field_validation +
    0.10 * decision_fit,
    3
  ) AS remote_evidence_quality
FROM product_readiness_scores
ORDER BY remote_evidence_quality ASC;

SELECT
  product_id,
  domain,
  CASE
    WHEN high_stakes_use = 1 AND uncertainty_characterized < 0.80 THEN 'high_stakes_uncertainty_review'
    WHEN valid_coverage < 0.70 THEN 'valid_coverage_review'
    WHEN proxy_transparency < 0.75 THEN 'proxy_transparency_review'
    WHEN field_validation < 0.70 THEN 'field_validation_review'
    WHEN time_series_continuity < 0.70 THEN 'time_series_continuity_review'
    WHEN decision_fit < 0.70 THEN 'decision_fit_review'
    ELSE 'routine_monitoring'
  END AS review_priority
FROM product_readiness_scores
ORDER BY review_priority, product_id;

SELECT
  change_id,
  product_id,
  change_type,
  status
FROM time_series_change_records
WHERE status LIKE '%review%';
