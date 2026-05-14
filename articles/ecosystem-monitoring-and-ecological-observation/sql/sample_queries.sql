.headers on
.mode column

SELECT
  program_id,
  ecosystem_type,
  geography,
  extent_visibility,
  condition_evidence,
  structure_evidence,
  function_evidence,
  integrity_evidence,
  resilience_evidence,
  baseline_strength,
  uncertainty_communication,
  governance_readiness,
  ROUND(
    0.11 * extent_visibility +
    0.14 * condition_evidence +
    0.11 * structure_evidence +
    0.12 * function_evidence +
    0.13 * integrity_evidence +
    0.12 * resilience_evidence +
    0.10 * baseline_strength +
    0.08 * uncertainty_communication +
    0.09 * governance_readiness,
    3
  ) AS ecosystem_evidence_quality
FROM ecosystem_monitoring_readiness_scores
ORDER BY ecosystem_evidence_quality ASC;

SELECT
  program_id,
  ecosystem_type,
  CASE
    WHEN high_stakes_use = 1 AND condition_evidence < 0.75 THEN 'high_stakes_condition_review'
    WHEN extent_visibility < 0.70 THEN 'extent_visibility_review'
    WHEN condition_evidence < 0.75 THEN 'condition_evidence_review'
    WHEN function_evidence < 0.70 THEN 'function_evidence_review'
    WHEN integrity_evidence < 0.70 THEN 'integrity_evidence_review'
    WHEN resilience_evidence < 0.70 THEN 'resilience_evidence_review'
    WHEN baseline_strength < 0.75 THEN 'baseline_reference_review'
    WHEN uncertainty_communication < 0.75 THEN 'uncertainty_communication_review'
    WHEN governance_readiness < 0.75 THEN 'governance_readiness_review'
    ELSE 'routine_monitoring'
  END AS review_priority
FROM ecosystem_monitoring_readiness_scores
ORDER BY review_priority, program_id;

SELECT
  indicator_id,
  indicator_name,
  ecological_dimension,
  proxy_limit,
  review_status
FROM ecological_indicator_registry
WHERE review_status != 'approved';

SELECT
  assessment_id,
  program_id,
  ecosystem_type,
  condition_score,
  function_score,
  integrity_score,
  resilience_score,
  confidence,
  review_status
FROM ecosystem_assessment_scores
WHERE review_status != 'approved'
   OR confidence < 0.75
   OR resilience_score < 0.70;

SELECT
  audit_id,
  program_id,
  coverage_dimension,
  target_group_or_zone,
  coverage_score,
  priority
FROM representativeness_audit
WHERE coverage_score < 0.70
ORDER BY priority, coverage_score;
