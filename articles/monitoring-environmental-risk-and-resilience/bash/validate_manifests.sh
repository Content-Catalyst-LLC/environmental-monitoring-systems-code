#!/usr/bin/env bash
set -euo pipefail

ARTICLE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

required_files=(
  "$ARTICLE_DIR/README.md"
  "$ARTICLE_DIR/companion_manifest.yml"
  "$ARTICLE_DIR/config/risk_monitoring_manifest.yml"
  "$ARTICLE_DIR/config/threshold_registry.yml"
  "$ARTICLE_DIR/config/recovery_monitoring_policy.yml"
  "$ARTICLE_DIR/config/equity_audit_policy.yml"
  "$ARTICLE_DIR/schemas/resilience_unit.schema.json"
  "$ARTICLE_DIR/model_cards/resilience_indicator_model_card.md"
  "$ARTICLE_DIR/data/resilience_units.csv"
  "$ARTICLE_DIR/data/hazard_inventory.csv"
  "$ARTICLE_DIR/data/exposure_registry.csv"
  "$ARTICLE_DIR/data/recovery_trajectories.csv"
  "$ARTICLE_DIR/python/risk_resilience_scoring.py"
  "$ARTICLE_DIR/r/recovery_trajectory_reporting.R"
  "$ARTICLE_DIR/sql/schema.sql"
)

for file in "${required_files[@]}"; do
  if [ ! -f "$file" ]; then
    echo "Missing required file: $file"
    exit 1
  fi
done

echo "All required risk and resilience scaffold files are present."
