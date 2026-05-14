#!/usr/bin/env bash
set -euo pipefail

ARTICLE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

required_files=(
  "$ARTICLE_DIR/README.md"
  "$ARTICLE_DIR/companion_manifest.yml"
  "$ARTICLE_DIR/config/warning_objective.yml"
  "$ARTICLE_DIR/config/threshold_registry.yml"
  "$ARTICLE_DIR/config/evidence_retention_policy.yml"
  "$ARTICLE_DIR/config/last_mile_equity_policy.yml"
  "$ARTICLE_DIR/schemas/warning_scenario.schema.json"
  "$ARTICLE_DIR/model_cards/warning_chain_model_card.md"
  "$ARTICLE_DIR/data/warning_scenarios.csv"
  "$ARTICLE_DIR/data/hazard_signal_inventory.csv"
  "$ARTICLE_DIR/data/message_templates.csv"
  "$ARTICLE_DIR/data/communication_channel_matrix.csv"
  "$ARTICLE_DIR/data/warning_reach_response.csv"
  "$ARTICLE_DIR/python/warning_chain_readiness.py"
  "$ARTICLE_DIR/r/warning_reach_response_reporting.R"
  "$ARTICLE_DIR/sql/schema.sql"
)

for file in "${required_files[@]}"; do
  if [ ! -f "$file" ]; then
    echo "Missing required file: $file"
    exit 1
  fi
done

echo "All required early warning scaffold files are present."
