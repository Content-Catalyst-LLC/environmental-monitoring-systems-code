#!/usr/bin/env bash
set -euo pipefail

ARTICLE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

required_files=(
  "$ARTICLE_DIR/README.md"
  "$ARTICLE_DIR/companion_manifest.yml"
  "$ARTICLE_DIR/config/device_objective.yml"
  "$ARTICLE_DIR/config/power_budget.yml"
  "$ARTICLE_DIR/config/firmware_manifest.yml"
  "$ARTICLE_DIR/config/storage_telemetry_manifest.yml"
  "$ARTICLE_DIR/config/field_qaqc_policy.yml"
  "$ARTICLE_DIR/config/enclosure_deployment_manifest.yml"
  "$ARTICLE_DIR/config/security_access_policy.yml"
  "$ARTICLE_DIR/schemas/field_observation.schema.json"
  "$ARTICLE_DIR/model_cards/device_readiness_model_card.md"
  "$ARTICLE_DIR/model_cards/field_device_fault_model_card.md"
  "$ARTICLE_DIR/data/device_sensor_registry.csv"
  "$ARTICLE_DIR/data/calibration_maintenance_log.csv"
  "$ARTICLE_DIR/data/device_health_records.csv"
  "$ARTICLE_DIR/data/embedded_device_readiness_scores.csv"
  "$ARTICLE_DIR/data/field_observation_records.csv"
  "$ARTICLE_DIR/data/embedded_device_governance_log.csv"
  "$ARTICLE_DIR/python/embedded_device_readiness.py"
  "$ARTICLE_DIR/r/embedded_device_reporting.R"
  "$ARTICLE_DIR/sql/schema.sql"
  "$ARTICLE_DIR/typescript/src/embedded_device_types.ts"
)

for file in "${required_files[@]}"; do
  if [ ! -f "$file" ]; then
    echo "Missing required file: $file"
    exit 1
  fi
done

echo "All required embedded field-device scaffold files are present."
