.headers on
.mode column

SELECT
  program_id,
  ecosystem_context,
  geography,
  taxonomic_coverage,
  spatial_representativeness,
  method_diversity,
  detectability_adjustment,
  observation_quality,
  indicator_readiness,
  habitat_context_linkage,
  uncertainty_communication,
  governance_readiness,
  ROUND(
    0.12 * taxonomic_coverage +
    0.12 * spatial_representativeness +
    0.10 * method_diversity +
    0.12 * detectability_adjustment +
    0.12 * observation_quality +
    0.12 * indicator_readiness +
    0.10 * habitat_context_linkage +
    0.09 * uncertainty_communication +
    0.11 * governance_readiness,
    3
  ) AS biodiversity_evidence_quality
FROM biodiversity_monitoring_readiness_scores
ORDER BY biodiversity_evidence_quality ASC;

SELECT
  program_id,
  ecosystem_context,
  CASE
    WHEN high_stakes_use = 1 AND detectability_adjustment < 0.70 THEN 'high_stakes_detectability_review'
    WHEN taxonomic_coverage < 0.65 THEN 'taxonomic_coverage_review'
    WHEN spatial_representativeness < 0.65 THEN 'spatial_representativeness_review'
    WHEN method_diversity < 0.65 THEN 'method_diversity_review'
    WHEN detectability_adjustment < 0.70 THEN 'detectability_review'
    WHEN indicator_readiness < 0.70 THEN 'indicator_readiness_review'
    WHEN habitat_context_linkage < 0.70 THEN 'habitat_context_review'
    WHEN uncertainty_communication < 0.75 THEN 'uncertainty_communication_review'
    WHEN governance_readiness < 0.75 THEN 'governance_readiness_review'
    ELSE 'routine_monitoring'
  END AS review_priority
FROM biodiversity_monitoring_readiness_scores
ORDER BY review_priority, program_id;

SELECT
  audit_id,
  program_id,
  bias_dimension,
  target_group_or_zone,
  score,
  priority,
  evidence_gap
FROM detectability_bias_audit
WHERE score < 0.70
ORDER BY priority, score;

SELECT
  indicator_id,
  indicator_name,
  dimension_id,
  proxy_limit,
  review_status
FROM biodiversity_indicator_registry
WHERE review_status != 'approved';
