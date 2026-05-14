#!/usr/bin/env bash
set -euo pipefail

ARTICLE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

required_files=(
  "$ARTICLE_DIR/README.md"
  "$ARTICLE_DIR/companion_manifest.yml"
  "$ARTICLE_DIR/config/remote_sensing_objective.yml"
  "$ARTICLE_DIR/config/preprocessing_manifest.yml"
  "$ARTICLE_DIR/config/time_series_change_manifest.yml"
  "$ARTICLE_DIR/config/uncertainty_proxy_policy.yml"
  "$ARTICLE_DIR/config/remote_sensing_product_governance.yml"
  "$ARTICLE_DIR/schemas/remote_sensing_product.schema.json"
  "$ARTICLE_DIR/model_cards/inference_proxy_card.md"
  "$ARTICLE_DIR/model_cards/remote_sensing_product_readiness_model_card.md"
  "$ARTICLE_DIR/data/platform_sensor_inventory.csv"
  "$ARTICLE_DIR/data/remote_sensing_product_registry.csv"
  "$ARTICLE_DIR/data/validation_records.csv"
  "$ARTICLE_DIR/data/product_readiness_scores.csv"
  "$ARTICLE_DIR/data/time_series_change_records.csv"
  "$ARTICLE_DIR/data/product_governance_log.csv"
  "$ARTICLE_DIR/python/remote_sensing_product_readiness.py"
  "$ARTICLE_DIR/r/remote_sensing_product_reporting.R"
  "$ARTICLE_DIR/sql/schema.sql"
  "$ARTICLE_DIR/typescript/src/remote_sensing_product_types.ts"
)

for file in "${required_files[@]}"; do
  if [ ! -f "$file" ]; then
    echo "Missing required file: $file"
    exit 1
  fi
done

echo "All required remote sensing scaffold files are present."
