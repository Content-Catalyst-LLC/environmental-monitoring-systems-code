#!/usr/bin/env bash
set -euo pipefail

ARTICLE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

test -f "$ARTICLE_DIR/README.md"
test -f "$ARTICLE_DIR/companion_manifest.yml"
test -f "$ARTICLE_DIR/python/flood_monitoring_readiness.py"
test -f "$ARTICLE_DIR/r/flood_monitoring_reporting.R"
test -f "$ARTICLE_DIR/sql/schema.sql"
test -f "$ARTICLE_DIR/schemas/flood_observation.schema.json"
test -f "$ARTICLE_DIR/typescript/src/flood_monitoring_types.ts"
test -f "$ARTICLE_DIR/data/flood_monitoring_readiness_scores.csv"

echo "Expected file test passed."
