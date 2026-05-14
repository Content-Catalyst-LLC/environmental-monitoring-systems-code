#!/usr/bin/env bash
set -euo pipefail

ARTICLE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

test -f "$ARTICLE_DIR/README.md"
test -f "$ARTICLE_DIR/companion_manifest.yml"
test -f "$ARTICLE_DIR/python/air_quality_monitoring_readiness.py"
test -f "$ARTICLE_DIR/r/air_quality_monitoring_reporting.R"
test -f "$ARTICLE_DIR/sql/schema.sql"
test -f "$ARTICLE_DIR/schemas/pollutant_observation.schema.json"
test -f "$ARTICLE_DIR/schemas/sensor_registry.schema.json"
test -f "$ARTICLE_DIR/typescript/src/air_quality_types.ts"
test -f "$ARTICLE_DIR/data/air_quality_monitoring_readiness_scores.csv"
test -f "$ARTICLE_DIR/data/pollutant_observation_records.csv"
test -f "$ARTICLE_DIR/data/calibration_collocation_log.csv"

echo "Expected file test passed."
