.headers on
.mode column

SELECT
  component_id,
  domain,
  component_type,
  ROUND(
    0.18 * device_availability +
    0.18 * delivery_completeness +
    0.18 * semantic_completeness +
    0.16 * qc_readiness +
    0.14 * edge_traceability +
    0.16 * decision_fit -
    0.10 * MIN(MAX((end_to_end_latency_minutes / target_latency_minutes) - 1, 0), 1),
    3
  ) AS iot_evidence_quality
FROM iot_architecture_readiness_scores
ORDER BY iot_evidence_quality ASC;

SELECT
  component_id,
  domain,
  CASE
    WHEN high_stakes_use = 1 AND qc_readiness < 0.80 THEN 'high_stakes_qc_review'
    WHEN device_availability < 0.75 THEN 'device_reliability_review'
    WHEN delivery_completeness < 0.80 THEN 'connectivity_delivery_review'
    WHEN semantic_completeness < 0.80 THEN 'semantic_completeness_review'
    WHEN edge_traceability < 0.75 THEN 'edge_traceability_review'
    WHEN end_to_end_latency_minutes > target_latency_minutes THEN 'latency_review'
    WHEN decision_fit < 0.75 THEN 'decision_fit_review'
    ELSE 'routine_monitoring'
  END AS review_priority
FROM iot_architecture_readiness_scores
ORDER BY review_priority, component_id;

SELECT device_id, domain, observed_property, calibration_status, high_stakes_use
FROM device_sensor_registry
WHERE calibration_status != 'valid' OR high_stakes_use = 1;

SELECT alert_rule_id, domain, observed_property, severity, review_status
FROM alert_rule_registry
WHERE review_status != 'approved';
