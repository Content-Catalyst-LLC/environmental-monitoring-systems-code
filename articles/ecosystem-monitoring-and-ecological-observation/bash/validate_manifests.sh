#!/usr/bin/env bash
set -euo pipefail

ARTICLE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

required_files=(
  "$ARTICLE_DIR/README.md"
  "$ARTICLE_DIR/companion_manifest.yml"
  "$ARTICLE_DIR/config/monitoring_objective.yml"
  "$ARTICLE_DIR/config/indicator_governance.yml"
  "$ARTICLE_DIR/config/assessment_policy.yml"
  "$ARTICLE_DIR/config/disturbance_recovery_policy.yml"
  "$ARTICLE_DIR/config/uncertainty_public_evidence_policy.yml"
  "$ARTICLE_DIR/schemas/ecosystem_assessment.schema.json"
  "$ARTICLE_DIR/model_cards/ecosystem_monitoring_readiness_model_card.md"
  "$ARTICLE_DIR/model_cards/ecological_indicator_model_card.md"
  "$ARTICLE_DIR/docs/field_observation_protocol.md"
  "$ARTICLE_DIR/docs/public_evidence_package.md"
  "$ARTICLE_DIR/data/ecosystem_dimension_matrix.csv"
  "$ARTICLE_DIR/data/ecological_observation_registry.csv"
  "$ARTICLE_DIR/data/ecological_indicator_registry.csv"
  "$ARTICLE_DIR/data/disturbance_recovery_log.csv"
  "$ARTICLE_DIR/data/ecosystem_monitoring_readiness_scores.csv"
  "$ARTICLE_DIR/data/ecosystem_assessment_scores.csv"
  "$ARTICLE_DIR/data/representativeness_audit.csv"
  "$ARTICLE_DIR/data/ecosystem_monitoring_governance_log.csv"
  "$ARTICLE_DIR/data/ecosystem_sites.geojson"
  "$ARTICLE_DIR/python/ecosystem_monitoring_readiness.py"
  "$ARTICLE_DIR/r/ecosystem_monitoring_reporting.R"
  "$ARTICLE_DIR/sql/schema.sql"
  "$ARTICLE_DIR/typescript/src/ecosystem_monitoring_types.ts"
)

for file in "${required_files[@]}"; do
  if [ ! -f "$file" ]; then
    echo "Missing required file: $file"
    exit 1
  fi
done

echo "All required ecosystem monitoring scaffold files are present."
