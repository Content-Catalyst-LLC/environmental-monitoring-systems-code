.headers on
.mode column

SELECT
  scenario_id,
  hazard_type,
  ROUND(
    0.18 * detection_confidence +
    0.16 * usable_lead_time_score +
    0.16 * reach_score +
    0.14 * trust_score +
    0.14 * response_capacity_score +
    0.14 * protective_action_score -
    0.04 * missed_event_penalty -
    0.04 * equity_gap_score,
    3
  ) AS warning_effectiveness
FROM warning_scenarios
ORDER BY warning_effectiveness DESC;

SELECT
  scenario_id,
  hazard_type,
  CASE
    WHEN equity_gap_score >= 0.30 THEN 'equity_and_last_mile_review'
    WHEN usable_lead_time_score < 0.50 THEN 'lead_time_review'
    WHEN reach_score < 0.60 THEN 'communication_reach_review'
    WHEN response_capacity_score < 0.55 THEN 'preparedness_capacity_review'
    ELSE 'routine_monitoring'
  END AS review_priority
FROM warning_scenarios
ORDER BY review_priority;
