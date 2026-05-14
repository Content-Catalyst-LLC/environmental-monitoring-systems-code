#!/usr/bin/env bash
set -euo pipefail

ARTICLE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

required_files=(
  "$ARTICLE_DIR/README.md"
  "$ARTICLE_DIR/companion_manifest.yml"
  "$ARTICLE_DIR/config/climate_monitoring_objective.yml"
  "$ARTICLE_DIR/config/record_quality_policy.yml"
  "$ARTICLE_DIR/config/homogenization_policy.yml"
  "$ARTICLE_DIR/config/public_evidence_policy.yml"
  "$ARTICLE_DIR/schemas/climate_observation.schema.json"
  "$ARTICLE_DIR/schemas/climate_data_record_manifest.schema.json"
  "$ARTICLE_DIR/model_cards/climate_record_quality_model_card.md"
  "$ARTICLE_DIR/model_cards/reanalysis_linkage_model_card.md"
  "$ARTICLE_DIR/docs/mathematical_lens.md"
  "$ARTICLE_DIR/docs/climate_monitoring_framework.md"
  "$ARTICLE_DIR/docs/readiness_gate.md"
  "$ARTICLE_DIR/docs/public_evidence_package.md"
  "$ARTICLE_DIR/docs/coverage_continuity_audit_template.md"
  "$ARTICLE_DIR/docs/reanalysis_linkage_note.md"
  "$ARTICLE_DIR/data/climate_observation_platform_registry.csv"
  "$ARTICLE_DIR/data/metadata_provenance_registry.csv"
  "$ARTICLE_DIR/data/calibration_intercomparison_log.csv"
  "$ARTICLE_DIR/data/climate_observation_records.csv"
  "$ARTICLE_DIR/data/homogenization_adjustment_log.csv"
  "$ARTICLE_DIR/data/climate_data_record_manifest.csv"
  "$ARTICLE_DIR/data/climate_indicator_anomaly_table.csv"
  "$ARTICLE_DIR/data/coverage_continuity_audit.csv"
  "$ARTICLE_DIR/data/climate_monitoring_readiness_scores.csv"
  "$ARTICLE_DIR/data/climate_monitoring_governance_log.csv"
  "$ARTICLE_DIR/data/climate_monitoring_platforms.geojson"
  "$ARTICLE_DIR/python/climate_monitoring_readiness.py"
  "$ARTICLE_DIR/r/climate_monitoring_reporting.R"
  "$ARTICLE_DIR/sql/schema.sql"
  "$ARTICLE_DIR/sql/sample_queries.sql"
  "$ARTICLE_DIR/typescript/src/climate_monitoring_types.ts"
  "$ARTICLE_DIR/go/program_status_endpoint.go"
  "$ARTICLE_DIR/rust/src/main.rs"
  "$ARTICLE_DIR/c/climate_observation_record.c"
  "$ARTICLE_DIR/cpp/climate_record_event_queue.cpp"
)

for file in "${required_files[@]}"; do
  if [ ! -f "$file" ]; then
    echo "Missing required file: $file"
    exit 1
  fi
done

echo "All required climate monitoring scaffold files are present."
