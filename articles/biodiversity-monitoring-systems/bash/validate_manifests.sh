#!/usr/bin/env bash
set -euo pipefail

ARTICLE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

required_files=(
  "$ARTICLE_DIR/README.md"
  "$ARTICLE_DIR/companion_manifest.yml"
  "$ARTICLE_DIR/config/monitoring_objective.yml"
  "$ARTICLE_DIR/config/detectability_policy.yml"
  "$ARTICLE_DIR/config/indicator_mapping_policy.yml"
  "$ARTICLE_DIR/config/inclusion_governance_policy.yml"
  "$ARTICLE_DIR/config/public_evidence_policy.yml"
  "$ARTICLE_DIR/schemas/species_observation.schema.json"
  "$ARTICLE_DIR/model_cards/biodiversity_monitoring_readiness_model_card.md"
  "$ARTICLE_DIR/model_cards/detectability_and_indicator_model_card.md"
  "$ARTICLE_DIR/docs/public_evidence_package.md"
  "$ARTICLE_DIR/docs/community_and_indigenous_knowledge_governance.md"
  "$ARTICLE_DIR/data/biodiversity_dimension_matrix.csv"
  "$ARTICLE_DIR/data/observation_method_registry.csv"
  "$ARTICLE_DIR/data/species_observation_records.csv"
  "$ARTICLE_DIR/data/biodiversity_indicator_registry.csv"
  "$ARTICLE_DIR/data/detectability_bias_audit.csv"
  "$ARTICLE_DIR/data/biodiversity_monitoring_readiness_scores.csv"
  "$ARTICLE_DIR/data/community_monitoring_governance.csv"
  "$ARTICLE_DIR/data/conservation_accountability_log.csv"
  "$ARTICLE_DIR/data/monitoring_sites.geojson"
  "$ARTICLE_DIR/python/biodiversity_monitoring_readiness.py"
  "$ARTICLE_DIR/r/biodiversity_monitoring_reporting.R"
  "$ARTICLE_DIR/sql/schema.sql"
  "$ARTICLE_DIR/typescript/src/biodiversity_monitoring_types.ts"
)

for file in "${required_files[@]}"; do
  if [ ! -f "$file" ]; then
    echo "Missing required file: $file"
    exit 1
  fi
done

echo "All required biodiversity monitoring scaffold files are present."
