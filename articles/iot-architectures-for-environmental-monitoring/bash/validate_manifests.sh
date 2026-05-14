#!/usr/bin/env bash
set -euo pipefail
ARTICLE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
required_files=(
  "$ARTICLE_DIR/README.md"
  "$ARTICLE_DIR/companion_manifest.yml"
  "$ARTICLE_DIR/config/iot_architecture_objective.yml"
  "$ARTICLE_DIR/config/connectivity_manifest.yml"
  "$ARTICLE_DIR/config/quality_control_rules.yml"
  "$ARTICLE_DIR/config/edge_rule_manifest.yml"
  "$ARTICLE_DIR/config/security_access_policy.yml"
  "$ARTICLE_DIR/schemas/environmental_observation.schema.json"
  "$ARTICLE_DIR/model_cards/iot_architecture_readiness_model_card.md"
  "$ARTICLE_DIR/model_cards/edge_anomaly_model_card.md"
  "$ARTICLE_DIR/data/device_sensor_registry.csv"
  "$ARTICLE_DIR/data/gateway_edge_registry.csv"
  "$ARTICLE_DIR/data/iot_architecture_readiness_scores.csv"
  "$ARTICLE_DIR/data/alert_rule_registry.csv"
  "$ARTICLE_DIR/data/environmental_observations_sample.csv"
  "$ARTICLE_DIR/data/iot_governance_log.csv"
  "$ARTICLE_DIR/python/iot_architecture_readiness.py"
  "$ARTICLE_DIR/r/iot_architecture_reporting.R"
  "$ARTICLE_DIR/sql/schema.sql"
  "$ARTICLE_DIR/typescript/src/iot_architecture_types.ts"
)
for file in "${required_files[@]}"; do
  if [ ! -f "$file" ]; then
    echo "Missing required file: $file"
    exit 1
  fi
done
echo "All required environmental IoT architecture scaffold files are present."
