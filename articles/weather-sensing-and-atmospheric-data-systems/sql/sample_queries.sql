.headers on
.mode column

SELECT
  program_id,
  operational_use,
  geography,
  ROUND(
    0.15 * observation_freshness +
    0.13 * spatial_coverage +
    0.13 * vertical_coverage +
    0.14 * qc_completeness +
    0.14 * assimilation_readiness +
    0.11 * representativeness +
    0.10 * uncertainty_communication +
    0.10 * governance_readiness,
    3
  ) AS weather_evidence_quality
FROM weather_sensing_readiness_scores
ORDER BY weather_evidence_quality ASC;

SELECT
  program_id,
  CASE
    WHEN high_stakes_use = 1 AND observation_freshness < 0.75 THEN 'high_stakes_latency_review'
    WHEN spatial_coverage < 0.70 THEN 'spatial_coverage_review'
    WHEN vertical_coverage < 0.70 THEN 'vertical_coverage_review'
    WHEN qc_completeness < 0.75 THEN 'quality_control_review'
    WHEN assimilation_readiness < 0.75 THEN 'assimilation_readiness_review'
    WHEN representativeness < 0.70 THEN 'representativeness_review'
    WHEN uncertainty_communication < 0.75 THEN 'uncertainty_communication_review'
    WHEN governance_readiness < 0.75 THEN 'governance_readiness_review'
    ELSE 'routine_monitoring'
  END AS review_priority
FROM weather_sensing_readiness_scores
ORDER BY review_priority, program_id;

SELECT
  platform_id,
  expected_reports,
  received_reports,
  ROUND(CAST(received_reports AS REAL) / expected_reports, 3) AS fresh_report_ratio,
  median_latency_minutes,
  max_latency_minutes,
  outage_minutes,
  freshness_status
FROM telemetry_latency_log
ORDER BY freshness_status, fresh_report_ratio ASC;

SELECT
  platform_id,
  COUNT(*) AS observations,
  SUM(assimilable) AS assimilable_observations,
  ROUND(CAST(SUM(assimilable) AS REAL) / COUNT(*), 3) AS assimilation_ready_ratio
FROM assimilation_readiness_records
GROUP BY platform_id
ORDER BY assimilation_ready_ratio ASC;
