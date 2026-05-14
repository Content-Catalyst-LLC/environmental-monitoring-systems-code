#!/usr/bin/env bash
set -euo pipefail

ARTICLE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

required_files=(
  "$ARTICLE_DIR/README.md"
  "$ARTICLE_DIR/companion_manifest.yml"
  "$ARTICLE_DIR/config/network_objective.yml"
  "$ARTICLE_DIR/config/telemetry_latency_manifest.yml"
  "$ARTICLE_DIR/config/network_qaqc_policy.yml"
  "$ARTICLE_DIR/config/metadata_interoperability.yml"
  "$ARTICLE_DIR/config/coverage_equity_policy.yml"
  "$ARTICLE_DIR/config/security_access_policy.yml"
  "$ARTICLE_DIR/schemas/network_observation.schema.json"
  "$ARTICLE_DIR/model_cards/network_readiness_model_card.md"
  "$ARTICLE_DIR/model_cards/node_anomaly_model_card.md"
  "$ARTICLE_DIR/data/node_site_registry.csv"
  "$ARTICLE_DIR/data/network_topology.geojson"
  "$ARTICLE_DIR/data/network_readiness_scores.csv"
  "$ARTICLE_DIR/data/network_observation_records.csv"
  "$ARTICLE_DIR/data/telemetry_delivery_records.csv"
  "$ARTICLE_DIR/data/coverage_equity_audit.csv"
  "$ARTICLE_DIR/data/alert_rule_registry.csv"
  "$ARTICLE_DIR/data/network_governance_log.csv"
  "$ARTICLE_DIR/python/sensor_network_readiness.py"
  "$ARTICLE_DIR/r/sensor_network_reporting.R"
  "$ARTICLE_DIR/sql/schema.sql"
  "$ARTICLE_DIR/typescript/src/sensor_network_types.ts"
)

for file in "${required_files[@]}"; do
  if [ ! -f "$file" ]; then
    echo "Missing required file: $file"
    exit 1
  fi
done

echo "All required environmental sensor-network scaffold files are present."
