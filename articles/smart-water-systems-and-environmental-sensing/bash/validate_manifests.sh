#!/usr/bin/env bash
set -euo pipefail

ARTICLE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

required_files=(
  "$ARTICLE_DIR/README.md"
  "$ARTICLE_DIR/companion_manifest.yml"
  "$ARTICLE_DIR/config/smart_water_objective.yml"
  "$ARTICLE_DIR/config/qaqc_validation_policy.yml"
  "$ARTICLE_DIR/config/telemetry_policy.yml"
  "$ARTICLE_DIR/config/control_failsafe_policy.yml"
  "$ARTICLE_DIR/config/public_evidence_policy.yml"
  "$ARTICLE_DIR/schemas/water_observation.schema.json"
  "$ARTICLE_DIR/model_cards/smart_water_readiness_model_card.md"
  "$ARTICLE_DIR/model_cards/digital_twin_model_card.md"
  "$ARTICLE_DIR/data/sensor_asset_registry.csv"
  "$ARTICLE_DIR/data/telemetry_status_records.csv"
  "$ARTICLE_DIR/data/water_observation_records.csv"
  "$ARTICLE_DIR/data/threshold_alert_registry.csv"
  "$ARTICLE_DIR/data/response_work_order_log.csv"
  "$ARTICLE_DIR/data/control_failsafe_log.csv"
  "$ARTICLE_DIR/data/smart_water_readiness_scores.csv"
  "$ARTICLE_DIR/data/smart_water_governance_log.csv"
  "$ARTICLE_DIR/python/smart_water_readiness.py"
  "$ARTICLE_DIR/r/smart_water_reporting.R"
  "$ARTICLE_DIR/sql/schema.sql"
  "$ARTICLE_DIR/typescript/src/smart_water_types.ts"
)

for file in "${required_files[@]}"; do
  if [ ! -f "$file" ]; then
    echo "Missing required file: $file"
    exit 1
  fi
done

echo "All required smart water scaffold files are present."
