#!/usr/bin/env bash
set -euo pipefail

ARTICLE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

required_files=(
  "$ARTICLE_DIR/README.md"
  "$ARTICLE_DIR/companion_manifest.yml"
  "$ARTICLE_DIR/config/flood_risk_objective.yml"
  "$ARTICLE_DIR/config/telemetry_policy.yml"
  "$ARTICLE_DIR/config/forecast_warning_policy.yml"
  "$ARTICLE_DIR/config/inundation_mapping_policy.yml"
  "$ARTICLE_DIR/config/public_evidence_policy.yml"
  "$ARTICLE_DIR/schemas/flood_observation.schema.json"
  "$ARTICLE_DIR/model_cards/flood_monitoring_readiness_model_card.md"
  "$ARTICLE_DIR/model_cards/flood_forecast_model_card.md"
  "$ARTICLE_DIR/docs/mathematical_lens.md"
  "$ARTICLE_DIR/docs/flood_monitoring_framework.md"
  "$ARTICLE_DIR/docs/readiness_gate.md"
  "$ARTICLE_DIR/docs/public_evidence_package.md"
  "$ARTICLE_DIR/docs/post_event_review_template.md"
  "$ARTICLE_DIR/data/gauge_sensor_registry.csv"
  "$ARTICLE_DIR/data/hydrometeorological_driver_matrix.csv"
  "$ARTICLE_DIR/data/telemetry_status_records.csv"
  "$ARTICLE_DIR/data/flood_observation_records.csv"
  "$ARTICLE_DIR/data/threshold_impact_registry.csv"
  "$ARTICLE_DIR/data/inundation_map_linkage.csv"
  "$ARTICLE_DIR/data/warning_response_log.csv"
  "$ARTICLE_DIR/data/coverage_equity_audit.csv"
  "$ARTICLE_DIR/data/flood_monitoring_readiness_scores.csv"
  "$ARTICLE_DIR/data/flood_monitoring_governance_log.csv"
  "$ARTICLE_DIR/data/flood_monitoring_sites.geojson"
  "$ARTICLE_DIR/python/flood_monitoring_readiness.py"
  "$ARTICLE_DIR/r/flood_monitoring_reporting.R"
  "$ARTICLE_DIR/sql/schema.sql"
  "$ARTICLE_DIR/sql/sample_queries.sql"
  "$ARTICLE_DIR/typescript/src/flood_monitoring_types.ts"
  "$ARTICLE_DIR/go/program_status_endpoint.go"
  "$ARTICLE_DIR/rust/src/main.rs"
  "$ARTICLE_DIR/c/flood_gage_record.c"
  "$ARTICLE_DIR/cpp/flood_alert_event_queue.cpp"
)

for file in "${required_files[@]}"; do
  if [ ! -f "$file" ]; then
    echo "Missing required file: $file"
    exit 1
  fi
done

echo "All required flood monitoring scaffold files are present."
