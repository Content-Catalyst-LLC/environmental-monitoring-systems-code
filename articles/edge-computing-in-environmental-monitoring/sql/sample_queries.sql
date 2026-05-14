.headers on
.mode column

SELECT
  component_id,
  domain,
  component_type,
  ROUND(MAX(0, 1 - MIN(observed_latency_seconds / target_latency_seconds, 1)), 3) AS latency_readiness,
  ROUND(MAX(0, MIN(1, 1 - transmitted_data_mb / raw_data_mb)), 3) AS bandwidth_reduction,
  ROUND(MAX(0, MIN(1, discarded_without_audit_mb / raw_data_mb)), 3) AS loss_penalty,
  ROUND(
    0.16 * MAX(0, 1 - MIN(observed_latency_seconds / target_latency_seconds, 1)) +
    0.16 * edge_traceability +
    0.16 * retained_context_score +
    0.16 * qc_readiness +
    0.14 * inference_transparency +
    0.14 * decision_fit +
    0.08 * MAX(0, MIN(1, 1 - transmitted_data_mb / raw_data_mb)) -
    0.12 * MAX(0, MIN(1, discarded_without_audit_mb / raw_data_mb)),
    3
  ) AS edge_evidence_quality
FROM edge_readiness_scores
ORDER BY edge_evidence_quality ASC;

SELECT
  component_id,
  domain,
  CASE
    WHEN high_stakes_use = 1 AND qc_readiness < 0.80 THEN 'high_stakes_qc_review'
    WHEN MAX(0, 1 - MIN(observed_latency_seconds / target_latency_seconds, 1)) < 0.20 THEN 'latency_readiness_review'
    WHEN edge_traceability < 0.75 THEN 'edge_traceability_review'
    WHEN retained_context_score < 0.70 THEN 'retained_context_review'
    WHEN inference_transparency < 0.75 THEN 'inference_transparency_review'
    WHEN MAX(0, MIN(1, discarded_without_audit_mb / raw_data_mb)) > 0.30 THEN 'loss_policy_review'
    WHEN decision_fit < 0.75 THEN 'decision_fit_review'
    ELSE 'routine_monitoring'
  END AS review_priority
FROM edge_readiness_scores
ORDER BY review_priority, component_id;

SELECT
  edge_rule_id,
  component_id,
  rule_type,
  autonomy_level,
  review_status
FROM edge_rule_registry
WHERE review_status != 'approved';

SELECT
  event_id,
  component_id,
  event_type,
  confidence,
  quality_flag,
  raw_context_retained,
  delayed_record
FROM edge_event_records
WHERE quality_flag != 'pass'
   OR delayed_record = 1
   OR raw_context_retained = 0;
