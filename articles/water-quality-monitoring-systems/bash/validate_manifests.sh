#!/usr/bin/env bash
set -euo pipefail

ARTICLE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

required_files=(
  "$ARTICLE_DIR/README.md"
  "$ARTICLE_DIR/companion_manifest.yml"
  "$ARTICLE_DIR/config/water_quality_objective.yml"
  "$ARTICLE_DIR/config/qaqc_policy.yml"
  "$ARTICLE_DIR/config/assessment_policy.yml"
  "$ARTICLE_DIR/config/public_evidence_policy.yml"
  "$ARTICLE_DIR/schemas/water_quality_observation.schema.json"
  "$ARTICLE_DIR/schemas/laboratory_result.schema.json"
  "$ARTICLE_DIR/model_cards/water_quality_monitoring_readiness_model_card.md"
  "$ARTICLE_DIR/model_cards/load_and_threshold_model_card.md"
  "$ARTICLE_DIR/docs/mathematical_lens.md"
  "$ARTICLE_DIR/docs/water_quality_monitoring_framework.md"
  "$ARTICLE_DIR/docs/readiness_gate.md"
  "$ARTICLE_DIR/docs/public_evidence_package.md"
  "$ARTICLE_DIR/docs/qaqc_review_template.md"
  "$ARTICLE_DIR/data/site_station_registry.csv"
  "$ARTICLE_DIR/data/parameter_method_registry.csv"
  "$ARTICLE_DIR/data/sensor_calibration_log.csv"
  "$ARTICLE_DIR/data/sampling_event_log.csv"
  "$ARTICLE_DIR/data/laboratory_results.csv"
  "$ARTICLE_DIR/data/hydrology_load_linkage.csv"
  "$ARTICLE_DIR/data/assessment_threshold_registry.csv"
  "$ARTICLE_DIR/data/water_quality_monitoring_readiness_scores.csv"
  "$ARTICLE_DIR/data/water_quality_governance_log.csv"
  "$ARTICLE_DIR/data/water_quality_sites.geojson"
  "$ARTICLE_DIR/python/water_quality_monitoring_readiness.py"
  "$ARTICLE_DIR/r/water_quality_monitoring_reporting.R"
  "$ARTICLE_DIR/sql/schema.sql"
  "$ARTICLE_DIR/sql/sample_queries.sql"
  "$ARTICLE_DIR/typescript/src/water_quality_monitoring_types.ts"
  "$ARTICLE_DIR/go/program_status_endpoint.go"
  "$ARTICLE_DIR/rust/src/main.rs"
  "$ARTICLE_DIR/c/water_quality_sensor_record.c"
  "$ARTICLE_DIR/cpp/water_quality_event_queue.cpp"
)

for file in "${required_files[@]}"; do
  if [ ! -f "$file" ]; then
    echo "Missing required file: $file"
    exit 1
  fi
done

echo "All required water quality monitoring scaffold files are present."
