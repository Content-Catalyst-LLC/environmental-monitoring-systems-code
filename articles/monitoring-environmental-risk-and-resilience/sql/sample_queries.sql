.headers on
.mode column

SELECT
  unit_id,
  domain,
  ROUND(hazard_score * exposure_score * vulnerability_score * (1 - capacity_score), 3) AS risk_score,
  ROUND(
    0.20 * capacity_score +
    0.15 * redundancy_score +
    0.15 * learning_score +
    0.15 * governance_score +
    0.15 * ecological_condition_score +
    0.10 * recovery_ratio -
    0.10 * vulnerability_score,
    3
  ) AS resilience_score,
  threshold_proximity
FROM resilience_units
ORDER BY risk_score DESC;

SELECT
  unit_id,
  domain,
  CASE
    WHEN threshold_proximity >= 0.90 THEN 'threshold_escalation_review'
    WHEN recovery_ratio < 0.60 THEN 'recovery_delay_review'
    WHEN capacity_score < 0.50 THEN 'capacity_gap_review'
    ELSE 'routine_monitoring'
  END AS review_priority
FROM resilience_units
ORDER BY review_priority;
