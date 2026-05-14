#!/usr/bin/env bash
set -euo pipefail

ARTICLE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

required_files=(
  "$ARTICLE_DIR/README.md"
  "$ARTICLE_DIR/companion_manifest.yml"
  "$ARTICLE_DIR/config/air_quality_monitoring_objective.yml"
  "$ARTICLE_DIR/config/quality_control_policy.yml"
  "$ARTICLE_DIR/config/calibration_policy.yml"
  "$ARTICLE_DIR/config/public_evidence_policy.yml"
  "$ARTICLE_DIR/schemas/pollutant_observation.schema.json"
  "$ARTICLE_DIR/schemas/sensor_registry.schema.json"
  "$ARTICLE_DIR/model_cards/air_quality_readiness_model_card.md"
  "$ARTICLE_DIR/model_cards/exposure_equity_model_card.md"
  "$ARTICLE_DIR/docs/mathematical_lens.md"
  "$ARTICLE_DIR/docs/air_quality_evidence_framework.md"
  "$ARTICLE_DIR/docs/siting_network_rationale.md"
  "$ARTICLE_DIR/docs/readiness_gate.md"
  "$ARTICLE_DIR/docs/dashboard_alert_specification.md"
  "$ARTICLE_DIR/docs/public_evidence_package.md"
  "$ARTICLE_DIR/data/air_quality_sensor_registry.csv"
  "$ARTICLE_DIR/data/pollutant_observation_records.csv"
  "$ARTICLE_DIR/data/calibration_collocation_log.csv"
  "$ARTICLE_DIR/data/air_quality_qc_flags.csv"
  "$ARTICLE_DIR/data/meteorological_context.csv"
  "$ARTICLE_DIR/data/exposure_equity_layer.csv"
  "$ARTICLE_DIR/data/dashboard_alert_records.csv"
  "$ARTICLE_DIR/data/air_quality_monitoring_readiness_scores.csv"
  "$ARTICLE_DIR/data/air_quality_governance_log.csv"
  "$ARTICLE_DIR/data/air_quality_monitoring_sites.geojson"
  "$ARTICLE_DIR/python/air_quality_monitoring_readiness.py"
  "$ARTICLE_DIR/r/air_quality_monitoring_reporting.R"
  "$ARTICLE_DIR/sql/schema.sql"
  "$ARTICLE_DIR/sql/sample_queries.sql"
  "$ARTICLE_DIR/typescript/src/air_quality_types.ts"
  "$ARTICLE_DIR/go/program_status_endpoint.go"
  "$ARTICLE_DIR/rust/src/main.rs"
  "$ARTICLE_DIR/c/air_quality_sensor_record.c"
  "$ARTICLE_DIR/cpp/air_quality_alert_queue.cpp"
)

for file in "${required_files[@]}"; do
  if [ ! -f "$file" ]; then
    echo "Missing required file: $file"
    exit 1
  fi
done

echo "All required air quality monitoring scaffold files are present."
