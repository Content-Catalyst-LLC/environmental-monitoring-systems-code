#!/usr/bin/env bash
set -euo pipefail

ARTICLE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

required_files=(
  "$ARTICLE_DIR/README.md"
  "$ARTICLE_DIR/companion_manifest.yml"
  "$ARTICLE_DIR/config/observation_objective.yml"
  "$ARTICLE_DIR/config/continuity_plan.yml"
  "$ARTICLE_DIR/config/integration_manifest.yml"
  "$ARTICLE_DIR/config/uncertainty_proxy_policy.yml"
  "$ARTICLE_DIR/config/satellite_product_governance.yml"
  "$ARTICLE_DIR/schemas/satellite_product.schema.json"
  "$ARTICLE_DIR/model_cards/retrieval_algorithm_card.md"
  "$ARTICLE_DIR/model_cards/satellite_product_readiness_model_card.md"
  "$ARTICLE_DIR/data/mission_sensor_inventory.csv"
  "$ARTICLE_DIR/data/satellite_product_registry.csv"
  "$ARTICLE_DIR/data/calibration_validation_records.csv"
  "$ARTICLE_DIR/data/product_readiness_scores.csv"
  "$ARTICLE_DIR/data/continuity_transition_records.csv"
  "$ARTICLE_DIR/data/product_governance_log.csv"
  "$ARTICLE_DIR/python/satellite_product_readiness.py"
  "$ARTICLE_DIR/r/satellite_product_reporting.R"
  "$ARTICLE_DIR/sql/schema.sql"
  "$ARTICLE_DIR/typescript/src/satellite_product_types.ts"
)

for file in "${required_files[@]}"; do
  if [ ! -f "$file" ]; then
    echo "Missing required file: $file"
    exit 1
  fi
done

echo "All required satellite observation scaffold files are present."
