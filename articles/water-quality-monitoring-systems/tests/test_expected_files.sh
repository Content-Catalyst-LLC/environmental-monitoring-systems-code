#!/usr/bin/env bash
set -euo pipefail

ARTICLE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

test -f "$ARTICLE_DIR/README.md"
test -f "$ARTICLE_DIR/companion_manifest.yml"
test -f "$ARTICLE_DIR/python/water_quality_monitoring_readiness.py"
test -f "$ARTICLE_DIR/r/water_quality_monitoring_reporting.R"
test -f "$ARTICLE_DIR/sql/schema.sql"
test -f "$ARTICLE_DIR/schemas/water_quality_observation.schema.json"
test -f "$ARTICLE_DIR/schemas/laboratory_result.schema.json"
test -f "$ARTICLE_DIR/typescript/src/water_quality_monitoring_types.ts"
test -f "$ARTICLE_DIR/data/water_quality_monitoring_readiness_scores.csv"
test -f "$ARTICLE_DIR/data/laboratory_results.csv"
test -f "$ARTICLE_DIR/data/hydrology_load_linkage.csv"

echo "Expected file test passed."
