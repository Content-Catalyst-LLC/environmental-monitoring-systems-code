.headers on
.mode column

SELECT
  indicator_id,
  domain,
  user_role,
  ROUND(
    0.25 * is_fresh +
    0.25 * has_provenance +
    0.20 * CASE WHEN is_modeled_or_estimated = 0 OR uncertainty_labeled = 1 THEN 1 ELSE 0 END +
    0.20 * supports_priority_task -
    0.10 * MIN(
      CASE
        WHEN actionable_alert_count = 0 THEN alert_count
        ELSE CAST(alert_count AS REAL) / actionable_alert_count
      END / 10.0,
      1.0
    ),
    3
  ) AS decision_support_score
FROM dashboard_indicators
ORDER BY decision_support_score ASC;

SELECT
  indicator_id,
  domain,
  CASE
    WHEN has_provenance = 0 THEN 'provenance_review'
    WHEN is_modeled_or_estimated = 1 AND uncertainty_labeled = 0 THEN 'uncertainty_visibility_review'
    WHEN actionable_alert_count > 0 AND CAST(alert_count AS REAL) / actionable_alert_count > 5 THEN 'alert_burden_review'
    WHEN supports_priority_task = 0 THEN 'user_role_fit_review'
    ELSE 'routine_monitoring'
  END AS review_priority
FROM dashboard_indicators
ORDER BY review_priority;
