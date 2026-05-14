#!/usr/bin/env bash
set -euo pipefail

ARTICLE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

required_files=(
  "$ARTICLE_DIR/README.md"
  "$ARTICLE_DIR/companion_manifest.yml"
  "$ARTICLE_DIR/config/monitoring_objective.yml"
  "$ARTICLE_DIR/config/preprocessing_manifest.yml"
  "$ARTICLE_DIR/config/classification_manifest.yml"
  "$ARTICLE_DIR/config/change_detection_policy.yml"
  "$ARTICLE_DIR/config/accuracy_assessment_policy.yml"
  "$ARTICLE_DIR/config/public_evidence_policy.yml"
  "$ARTICLE_DIR/schemas/land_change.schema.json"
  "$ARTICLE_DIR/model_cards/land_monitoring_readiness_model_card.md"
  "$ARTICLE_DIR/model_cards/classification_accountability_model_card.md"
  "$ARTICLE_DIR/data/land_class_legend.csv"
  "$ARTICLE_DIR/data/imagery_inventory.csv"
  "$ARTICLE_DIR/data/reference_samples.csv"
  "$ARTICLE_DIR/data/change_rule_registry.csv"
  "$ARTICLE_DIR/data/land_change_records.csv"
  "$ARTICLE_DIR/data/accuracy_assessment.csv"
  "$ARTICLE_DIR/data/landscape_metrics.csv"
  "$ARTICLE_DIR/data/land_monitoring_readiness_scores.csv"
  "$ARTICLE_DIR/data/land_monitoring_governance_log.csv"
  "$ARTICLE_DIR/python/land_monitoring_readiness.py"
  "$ARTICLE_DIR/r/land_monitoring_reporting.R"
  "$ARTICLE_DIR/sql/schema.sql"
  "$ARTICLE_DIR/typescript/src/land_monitoring_types.ts"
)

for file in "${required_files[@]}"; do
  if [ ! -f "$file" ]; then
    echo "Missing required file: $file"
    exit 1
  fi
done

echo "All required land-use monitoring scaffold files are present."
