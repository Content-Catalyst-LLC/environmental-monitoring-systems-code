.headers on
.mode column

SELECT
  program_id,
  hazard_type,
  geography,
  ROUND(
    0.14 * forecast_confidence +
    0.14 * risk_knowledge +
    0.14 * protective_lead_time +
    0.13 * communication_reach +
    0.13 * action_capacity +
    0.10 * trust_readiness +
    0.11 * inclusion_capacity +
    0.11 * governance_readiness,
    3
  ) AS early_warning_quality
FROM early_warning_readiness_scores
ORDER BY early_warning_quality ASC;

SELECT
  program_id,
  CASE
    WHEN high_stakes_use = 1 AND protective_lead_time < 0.70 THEN 'high_stakes_lead_time_review'
    WHEN forecast_confidence < 0.70 THEN 'forecast_confidence_review'
    WHEN risk_knowledge < 0.70 THEN 'risk_knowledge_review'
    WHEN communication_reach < 0.75 THEN 'communication_reach_review'
    WHEN action_capacity < 0.75 THEN 'action_capacity_review'
    WHEN trust_readiness < 0.70 THEN 'trust_readiness_review'
    WHEN inclusion_capacity < 0.75 THEN 'inclusion_capacity_review'
    WHEN governance_readiness < 0.75 THEN 'governance_readiness_review'
    ELSE 'routine_monitoring'
  END AS review_priority
FROM early_warning_readiness_scores
ORDER BY review_priority, program_id;

SELECT
  program_id,
  hazard_type,
  warning_level,
  COUNT(*) AS warnings,
  ROUND(AVG(protective_lead_time_hours), 2) AS mean_protective_lead_time_hours,
  ROUND(MIN(protective_lead_time_hours), 2) AS min_protective_lead_time_hours
FROM warning_decision_log
GROUP BY program_id, hazard_type, warning_level
ORDER BY min_protective_lead_time_hours ASC;

SELECT
  program_id,
  COUNT(*) AS channels,
  ROUND(AVG(coverage_estimate), 3) AS mean_coverage,
  SUM(fallback_available) AS fallback_channels,
  SUM(CASE WHEN status != 'active' THEN 1 ELSE 0 END) AS review_channels
FROM communication_channel_registry
GROUP BY program_id
ORDER BY mean_coverage ASC;
