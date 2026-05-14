#!/usr/bin/env bash
set -euo pipefail

ARTICLE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

test -f "$ARTICLE_DIR/README.md"
test -f "$ARTICLE_DIR/companion_manifest.yml"
test -f "$ARTICLE_DIR/python/climate_monitoring_readiness.py"
test -f "$ARTICLE_DIR/r/climate_monitoring_reporting.R"
test -f "$ARTICLE_DIR/sql/schema.sql"
test -f "$ARTICLE_DIR/schemas/climate_observation.schema.json"
test -f "$ARTICLE_DIR/schemas/climate_data_record_manifest.schema.json"
test -f "$ARTICLE_DIR/typescript/src/climate_monitoring_types.ts"
test -f "$ARTICLE_DIR/data/climate_monitoring_readiness_scores.csv"
test -f "$ARTICLE_DIR/data/climate_indicator_anomaly_table.csv"
test -f "$ARTICLE_DIR/data/homogenization_adjustment_log.csv"

echo "Expected file test passed."
