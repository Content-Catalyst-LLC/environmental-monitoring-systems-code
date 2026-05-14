#!/usr/bin/env bash
set -euo pipefail

ARTICLE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

required_files=(
  "$ARTICLE_DIR/README.md"
  "$ARTICLE_DIR/companion_manifest.yml"
  "$ARTICLE_DIR/config/watershed_objective.yml"
  "$ARTICLE_DIR/config/qaqc_policy.yml"
  "$ARTICLE_DIR/config/interoperability_policy.yml"
  "$ARTICLE_DIR/config/public_evidence_policy.yml"
  "$ARTICLE_DIR/schemas/monitoring_node.schema.json"
  "$ARTICLE_DIR/schemas/water_quality_load_record.schema.json"
  "$ARTICLE_DIR/model_cards/watershed_monitoring_readiness_model_card.md"
  "$ARTICLE_DIR/model_cards/load_estimation_model_card.md"
  "$ARTICLE_DIR/docs/mathematical_lens.md"
  "$ARTICLE_DIR/docs/watershed_monitoring_framework.md"
  "$ARTICLE_DIR/docs/readiness_gate.md"
  "$ARTICLE_DIR/docs/public_evidence_package.md"
  "$ARTICLE_DIR/docs/representativeness_audit_template.md"
  "$ARTICLE_DIR/data/basin_topology_edges.csv"
  "$ARTICLE_DIR/data/monitoring_node_registry.csv"
  "$ARTICLE_DIR/data/hydrological_driver_matrix.csv"
  "$ARTICLE_DIR/data/telemetry_station_health.csv"
  "$ARTICLE_DIR/data/water_quality_load_records.csv"
  "$ARTICLE_DIR/data/ecological_assessment_registry.csv"
  "$ARTICLE_DIR/data/representativeness_audit.csv"
  "$ARTICLE_DIR/data/watershed_monitoring_readiness_scores.csv"
  "$ARTICLE_DIR/data/watershed_governance_log.csv"
  "$ARTICLE_DIR/data/watershed_monitoring_sites.geojson"
  "$ARTICLE_DIR/python/watershed_monitoring_readiness.py"
  "$ARTICLE_DIR/r/watershed_monitoring_reporting.R"
  "$ARTICLE_DIR/sql/schema.sql"
  "$ARTICLE_DIR/sql/sample_queries.sql"
  "$ARTICLE_DIR/typescript/src/watershed_monitoring_types.ts"
  "$ARTICLE_DIR/go/program_status_endpoint.go"
  "$ARTICLE_DIR/rust/src/main.rs"
  "$ARTICLE_DIR/c/watershed_node_record.c"
  "$ARTICLE_DIR/cpp/watershed_event_queue.cpp"
)

for file in "${required_files[@]}"; do
  if [ ! -f "$file" ]; then
    echo "Missing required file: $file"
    exit 1
  fi
done

echo "All required watershed monitoring scaffold files are present."
