#!/usr/bin/env bash
set -euo pipefail

ARTICLE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

test -f "$ARTICLE_DIR/README.md"
test -f "$ARTICLE_DIR/companion_manifest.yml"
test -f "$ARTICLE_DIR/python/watershed_monitoring_readiness.py"
test -f "$ARTICLE_DIR/r/watershed_monitoring_reporting.R"
test -f "$ARTICLE_DIR/sql/schema.sql"
test -f "$ARTICLE_DIR/schemas/monitoring_node.schema.json"
test -f "$ARTICLE_DIR/schemas/water_quality_load_record.schema.json"
test -f "$ARTICLE_DIR/typescript/src/watershed_monitoring_types.ts"
test -f "$ARTICLE_DIR/data/watershed_monitoring_readiness_scores.csv"
test -f "$ARTICLE_DIR/data/water_quality_load_records.csv"

echo "Expected file test passed."
