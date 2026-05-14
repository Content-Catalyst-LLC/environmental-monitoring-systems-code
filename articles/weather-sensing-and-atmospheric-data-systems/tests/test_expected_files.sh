#!/usr/bin/env bash
set -euo pipefail

ARTICLE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

test -f "$ARTICLE_DIR/README.md"
test -f "$ARTICLE_DIR/companion_manifest.yml"
test -f "$ARTICLE_DIR/python/weather_sensing_readiness.py"
test -f "$ARTICLE_DIR/r/weather_sensing_reporting.R"
test -f "$ARTICLE_DIR/sql/schema.sql"
test -f "$ARTICLE_DIR/schemas/atmospheric_observation.schema.json"
test -f "$ARTICLE_DIR/schemas/platform_registry.schema.json"
test -f "$ARTICLE_DIR/typescript/src/weather_sensing_types.ts"
test -f "$ARTICLE_DIR/data/weather_sensing_readiness_scores.csv"
test -f "$ARTICLE_DIR/data/telemetry_latency_log.csv"
test -f "$ARTICLE_DIR/data/assimilation_readiness_records.csv"

echo "Expected file test passed."
