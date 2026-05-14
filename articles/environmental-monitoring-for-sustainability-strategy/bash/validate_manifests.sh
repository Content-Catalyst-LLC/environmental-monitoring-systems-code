#!/usr/bin/env bash
set -euo pipefail

ARTICLE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

required_files=(
  "$ARTICLE_DIR/README.md"
  "$ARTICLE_DIR/companion_manifest.yml"
  "$ARTICLE_DIR/config/sustainability_monitoring_manifest.yml"
  "$ARTICLE_DIR/config/feedback_rulebook.yml"
  "$ARTICLE_DIR/config/indicator_governance.yml"
  "$ARTICLE_DIR/config/public_evidence_policy.yml"
  "$ARTICLE_DIR/schemas/sustainability_indicator.schema.json"
  "$ARTICLE_DIR/model_cards/sustainability_indicator_model_card.md"
  "$ARTICLE_DIR/data/indicator_registry.csv"
  "$ARTICLE_DIR/data/baselines_targets_thresholds.csv"
  "$ARTICLE_DIR/data/tradeoff_register.csv"
  "$ARTICLE_DIR/data/accountability_log.csv"
  "$ARTICLE_DIR/python/sustainability_indicator_integrity.py"
  "$ARTICLE_DIR/r/sustainability_progress_reporting.R"
  "$ARTICLE_DIR/sql/schema.sql"
)

for file in "${required_files[@]}"; do
  if [ ! -f "$file" ]; then
    echo "Missing required file: $file"
    exit 1
  fi
done

echo "All required sustainability monitoring scaffold files are present."
