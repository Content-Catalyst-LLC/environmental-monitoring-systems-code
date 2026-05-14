#!/usr/bin/env bash
set -euo pipefail

ARTICLE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

required_files=(
  "$ARTICLE_DIR/README.md"
  "$ARTICLE_DIR/companion_manifest.yml"
  "$ARTICLE_DIR/config/weather_sensing_objective.yml"
  "$ARTICLE_DIR/config/quality_control_policy.yml"
  "$ARTICLE_DIR/config/assimilation_policy.yml"
  "$ARTICLE_DIR/config/public_evidence_policy.yml"
  "$ARTICLE_DIR/schemas/atmospheric_observation.schema.json"
  "$ARTICLE_DIR/schemas/platform_registry.schema.json"
  "$ARTICLE_DIR/model_cards/assimilation_readiness_model_card.md"
  "$ARTICLE_DIR/model_cards/weather_sensing_readiness_model_card.md"
  "$ARTICLE_DIR/docs/mathematical_lens.md"
  "$ARTICLE_DIR/docs/weather_sensing_framework.md"
  "$ARTICLE_DIR/docs/readiness_gate.md"
  "$ARTICLE_DIR/docs/public_evidence_package.md"
  "$ARTICLE_DIR/docs/coverage_audit_template.md"
  "$ARTICLE_DIR/data/observation_platform_registry.csv"
  "$ARTICLE_DIR/data/atmospheric_observations.csv"
  "$ARTICLE_DIR/data/telemetry_latency_log.csv"
  "$ARTICLE_DIR/data/quality_control_flags.csv"
  "$ARTICLE_DIR/data/assimilation_readiness_records.csv"
  "$ARTICLE_DIR/data/coverage_blindspot_audit.csv"
  "$ARTICLE_DIR/data/forecast_use_log.csv"
  "$ARTICLE_DIR/data/weather_sensing_readiness_scores.csv"
  "$ARTICLE_DIR/data/weather_sensing_governance_log.csv"
  "$ARTICLE_DIR/data/weather_platforms.geojson"
  "$ARTICLE_DIR/python/weather_sensing_readiness.py"
  "$ARTICLE_DIR/r/weather_sensing_reporting.R"
  "$ARTICLE_DIR/sql/schema.sql"
  "$ARTICLE_DIR/sql/sample_queries.sql"
  "$ARTICLE_DIR/typescript/src/weather_sensing_types.ts"
  "$ARTICLE_DIR/go/program_status_endpoint.go"
  "$ARTICLE_DIR/rust/src/main.rs"
  "$ARTICLE_DIR/c/weather_observation_record.c"
  "$ARTICLE_DIR/cpp/weather_event_queue.cpp"
)

for file in "${required_files[@]}"; do
  if [ ! -f "$file" ]; then
    echo "Missing required file: $file"
    exit 1
  fi
done

echo "All required weather sensing scaffold files are present."
