#!/usr/bin/env bash
set -euo pipefail

ARTICLE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

required_files=(
  "$ARTICLE_DIR/README.md"
  "$ARTICLE_DIR/companion_manifest.yml"
  "$ARTICLE_DIR/config/edge_objective.yml"
  "$ARTICLE_DIR/config/retention_loss_policy.yml"
  "$ARTICLE_DIR/config/buffer_replay_manifest.yml"
  "$ARTICLE_DIR/config/quality_control_rules.yml"
  "$ARTICLE_DIR/config/latency_transport_manifest.yml"
  "$ARTICLE_DIR/config/security_access_policy.yml"
  "$ARTICLE_DIR/schemas/edge_event.schema.json"
  "$ARTICLE_DIR/model_cards/edge_model_card.md"
  "$ARTICLE_DIR/model_cards/edge_readiness_model_card.md"
  "$ARTICLE_DIR/data/edge_device_registry.csv"
  "$ARTICLE_DIR/data/edge_rule_registry.csv"
  "$ARTICLE_DIR/data/edge_model_registry.csv"
  "$ARTICLE_DIR/data/edge_readiness_scores.csv"
  "$ARTICLE_DIR/data/edge_event_records.csv"
  "$ARTICLE_DIR/data/edge_governance_log.csv"
  "$ARTICLE_DIR/python/edge_readiness.py"
  "$ARTICLE_DIR/r/edge_readiness_reporting.R"
  "$ARTICLE_DIR/sql/schema.sql"
  "$ARTICLE_DIR/typescript/src/edge_computing_types.ts"
)

for file in "${required_files[@]}"; do
  if [ ! -f "$file" ]; then
    echo "Missing required file: $file"
    exit 1
  fi
done

echo "All required environmental edge computing scaffold files are present."
