#!/usr/bin/env bash
set -euo pipefail

ARTICLE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

required_files=(
  "$ARTICLE_DIR/README.md"
  "$ARTICLE_DIR/companion_manifest.yml"
  "$ARTICLE_DIR/config/monitoring_objective.yml"
  "$ARTICLE_DIR/config/calibration_policy.yml"
  "$ARTICLE_DIR/config/telemetry_policy.yml"
  "$ARTICLE_DIR/config/public_evidence_policy.yml"
  "$ARTICLE_DIR/schemas/soil_observation.schema.json"
  "$ARTICLE_DIR/model_cards/soil_monitoring_readiness_model_card.md"
  "$ARTICLE_DIR/data/soil_profile_registry.csv"
  "$ARTICLE_DIR/data/sensor_sampling_registry.csv"
  "$ARTICLE_DIR/data/calibration_maintenance_log.csv"
  "$ARTICLE_DIR/data/soil_observation_records.csv"
  "$ARTICLE_DIR/data/lab_soil_results.csv"
  "$ARTICLE_DIR/data/remote_soil_moisture_linkage.csv"
  "$ARTICLE_DIR/data/threshold_decision_registry.csv"
  "$ARTICLE_DIR/data/soil_monitoring_readiness_scores.csv"
  "$ARTICLE_DIR/data/soil_monitoring_governance_log.csv"
  "$ARTICLE_DIR/python/soil_monitoring_readiness.py"
  "$ARTICLE_DIR/r/soil_monitoring_reporting.R"
  "$ARTICLE_DIR/sql/schema.sql"
  "$ARTICLE_DIR/typescript/src/soil_monitoring_types.ts"
)

for file in "${required_files[@]}"; do
  if [ ! -f "$file" ]; then
    echo "Missing required file: $file"
    exit 1
  fi
done

echo "All required soil monitoring scaffold files are present."
