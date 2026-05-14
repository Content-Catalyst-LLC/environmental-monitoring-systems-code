#!/usr/bin/env bash
set -euo pipefail

ARTICLE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

required_files=(
  "$ARTICLE_DIR/README.md"
  "$ARTICLE_DIR/companion_manifest.yml"
  "$ARTICLE_DIR/config/dashboard_objective.yml"
  "$ARTICLE_DIR/config/alert_rule_registry.yml"
  "$ARTICLE_DIR/config/provenance_policy.yml"
  "$ARTICLE_DIR/config/dashboard_governance.yml"
  "$ARTICLE_DIR/schemas/dashboard_indicator.schema.json"
  "$ARTICLE_DIR/model_cards/dashboard_signal_quality_model_card.md"
  "$ARTICLE_DIR/data/dashboard_indicators.csv"
  "$ARTICLE_DIR/data/user_role_matrix.csv"
  "$ARTICLE_DIR/data/dashboard_source_inventory.csv"
  "$ARTICLE_DIR/data/alert_log.csv"
  "$ARTICLE_DIR/data/dashboard_change_log.csv"
  "$ARTICLE_DIR/python/dashboard_signal_quality.py"
  "$ARTICLE_DIR/r/dashboard_indicator_reporting.R"
  "$ARTICLE_DIR/sql/schema.sql"
  "$ARTICLE_DIR/typescript/src/dashboard_types.ts"
)

for file in "${required_files[@]}"; do
  if [ ! -f "$file" ]; then
    echo "Missing required file: $file"
    exit 1
  fi
done

echo "All required dashboard scaffold files are present."
