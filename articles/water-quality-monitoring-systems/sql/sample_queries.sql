.headers on
.mode column

SELECT
  program_id,
  waterbody_type,
  decision_use,
  ROUND(
    0.13 * sampling_representativeness +
    0.13 * analytical_validity +
    0.12 * hydrological_context +
    0.13 * qaqc_completeness +
    0.11 * load_readiness +
    0.11 * threshold_alignment +
    0.09 * uncertainty_communication +
    0.09 * data_interoperability +
    0.09 * governance_readiness,
    3
  ) AS water_quality_evidence_score
FROM water_quality_monitoring_readiness_scores
ORDER BY water_quality_evidence_score ASC;

SELECT
  program_id,
  CASE
    WHEN high_stakes_use = 1 AND analytical_validity < 0.75 THEN 'high_stakes_analytical_validity_review'
    WHEN sampling_representativeness < 0.70 THEN 'sampling_representativeness_review'
    WHEN hydrological_context < 0.70 THEN 'hydrological_context_review'
    WHEN qaqc_completeness < 0.75 THEN 'qaqc_completeness_review'
    WHEN load_readiness < 0.70 THEN 'load_readiness_review'
    WHEN threshold_alignment < 0.75 THEN 'threshold_alignment_review'
    WHEN uncertainty_communication < 0.75 THEN 'uncertainty_communication_review'
    WHEN data_interoperability < 0.75 THEN 'data_interoperability_review'
    WHEN governance_readiness < 0.75 THEN 'governance_readiness_review'
    ELSE 'routine_monitoring'
  END AS review_priority
FROM water_quality_monitoring_readiness_scores
ORDER BY review_priority, program_id;

SELECT
  site_id,
  concentration_parameter,
  event_flag,
  COUNT(*) AS records,
  ROUND(AVG(concentration_value), 3) AS mean_concentration,
  ROUND(SUM(instantaneous_load_kg_day), 2) AS total_instantaneous_load_kg_day,
  SUM(CASE WHEN quality_flag != 'pass' THEN 1 ELSE 0 END) AS review_records
FROM hydrology_load_linkage
WHERE instantaneous_load_kg_day IS NOT NULL
GROUP BY site_id, concentration_parameter, event_flag
ORDER BY site_id, concentration_parameter;

SELECT
  lr.parameter_id,
  atr.decision_use,
  COUNT(*) AS valid_observations,
  SUM(
    CASE
      WHEN atr.threshold_type = 'above' AND lr.result_value > atr.threshold_value THEN 1
      WHEN atr.threshold_type = 'below' AND lr.result_value < atr.threshold_value THEN 1
      ELSE 0
    END
  ) AS exceedances
FROM laboratory_results lr
JOIN assessment_threshold_registry atr
  ON lr.parameter_id = atr.parameter_id
GROUP BY lr.parameter_id, atr.decision_use;
