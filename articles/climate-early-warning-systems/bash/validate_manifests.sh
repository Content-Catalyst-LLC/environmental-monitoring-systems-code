#!/usr/bin/env bash
set -euo pipefail

ARTICLE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

required_files=(
  "$ARTICLE_DIR/README.md"
  "$ARTICLE_DIR/companion_manifest.yml"
  "$ARTICLE_DIR/config/early_warning_objective.yml"
  "$ARTICLE_DIR/config/warning_policy.yml"
  "$ARTICLE_DIR/config/communication_policy.yml"
  "$ARTICLE_DIR/config/public_evidence_policy.yml"
  "$ARTICLE_DIR/schemas/warning_decision.schema.json"
  "$ARTICLE_DIR/schemas/communication_channel.schema.json"
  "$ARTICLE_DIR/model_cards/forecast_model_card.md"
  "$ARTICLE_DIR/model_cards/early_warning_readiness_model_card.md"
  "$ARTICLE_DIR/docs/mathematical_lens.md"
  "$ARTICLE_DIR/docs/early_warning_framework.md"
  "$ARTICLE_DIR/docs/readiness_gate.md"
  "$ARTICLE_DIR/docs/public_evidence_package.md"
  "$ARTICLE_DIR/docs/after_action_review_template.md"
  "$ARTICLE_DIR/data/hazard_monitoring_registry.csv"
  "$ARTICLE_DIR/data/forecast_records.csv"
  "$ARTICLE_DIR/data/exposure_vulnerability_matrix.csv"
  "$ARTICLE_DIR/data/impact_threshold_registry.csv"
  "$ARTICLE_DIR/data/warning_decision_log.csv"
  "$ARTICLE_DIR/data/communication_channel_registry.csv"
  "$ARTICLE_DIR/data/preparedness_action_log.csv"
  "$ARTICLE_DIR/data/coverage_inclusion_audit.csv"
  "$ARTICLE_DIR/data/early_warning_readiness_scores.csv"
  "$ARTICLE_DIR/data/early_warning_governance_log.csv"
  "$ARTICLE_DIR/data/early_warning_zones.geojson"
  "$ARTICLE_DIR/python/early_warning_readiness.py"
  "$ARTICLE_DIR/r/early_warning_reporting.R"
  "$ARTICLE_DIR/sql/schema.sql"
  "$ARTICLE_DIR/sql/sample_queries.sql"
  "$ARTICLE_DIR/typescript/src/early_warning_types.ts"
  "$ARTICLE_DIR/go/program_status_endpoint.go"
  "$ARTICLE_DIR/rust/src/main.rs"
  "$ARTICLE_DIR/c/early_warning_alert_record.c"
  "$ARTICLE_DIR/cpp/early_warning_event_queue.cpp"
)

for file in "${required_files[@]}"; do
  if [ ! -f "$file" ]; then
    echo "Missing required file: $file"
    exit 1
  fi
done

echo "All required early warning scaffold files are present."
