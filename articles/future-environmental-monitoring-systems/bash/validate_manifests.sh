#!/usr/bin/env bash
set -euo pipefail

ARTICLE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

required_files=(
  "$ARTICLE_DIR/README.md"
  "$ARTICLE_DIR/companion_manifest.yml"
  "$ARTICLE_DIR/config/monitoring_objective.yml"
  "$ARTICLE_DIR/config/interoperability_profile.yml"
  "$ARTICLE_DIR/config/uncertainty_policy.yml"
  "$ARTICLE_DIR/config/governance_review.yml"
  "$ARTICLE_DIR/schemas/environmental_observation.schema.json"
  "$ARTICLE_DIR/model_cards/environmental_intelligence_model_card.md"
  "$ARTICLE_DIR/data/observation_source_inventory.csv"
  "$ARTICLE_DIR/python/environmental_intelligence_pipeline.py"
  "$ARTICLE_DIR/r/indicator_reporting.R"
  "$ARTICLE_DIR/sql/schema.sql"
)

for file in "${required_files[@]}"; do
  if [ ! -f "$file" ]; then
    echo "Missing required file: $file"
    exit 1
  fi
done

echo "All required manifest and scaffold files are present."
