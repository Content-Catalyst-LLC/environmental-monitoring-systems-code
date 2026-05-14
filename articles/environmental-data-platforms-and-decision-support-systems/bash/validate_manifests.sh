#!/usr/bin/env bash
set -euo pipefail

ARTICLE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

required_files=(
  "$ARTICLE_DIR/README.md"
  "$ARTICLE_DIR/companion_manifest.yml"
  "$ARTICLE_DIR/config/platform_objective.yml"
  "$ARTICLE_DIR/config/data_quality_rules.yml"
  "$ARTICLE_DIR/config/lineage_policy.yml"
  "$ARTICLE_DIR/config/platform_governance.yml"
  "$ARTICLE_DIR/schemas/environmental_dataset.schema.json"
  "$ARTICLE_DIR/model_cards/platform_evidence_quality_model_card.md"
  "$ARTICLE_DIR/data/platform_assets.csv"
  "$ARTICLE_DIR/data/source_inventory.csv"
  "$ARTICLE_DIR/data/semantic_crosswalk.csv"
  "$ARTICLE_DIR/data/workflow_registry.csv"
  "$ARTICLE_DIR/data/model_scenario_registry.csv"
  "$ARTICLE_DIR/data/decision_support_matrix.csv"
  "$ARTICLE_DIR/data/platform_governance_log.csv"
  "$ARTICLE_DIR/python/platform_evidence_quality.py"
  "$ARTICLE_DIR/r/platform_evidence_reporting.R"
  "$ARTICLE_DIR/sql/schema.sql"
  "$ARTICLE_DIR/typescript/src/platform_types.ts"
)

for file in "${required_files[@]}"; do
  if [ ! -f "$file" ]; then
    echo "Missing required file: $file"
    exit 1
  fi
done

echo "All required environmental data platform scaffold files are present."
