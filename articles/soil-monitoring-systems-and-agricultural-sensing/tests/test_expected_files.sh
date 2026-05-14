#!/usr/bin/env bash
set -euo pipefail

ARTICLE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
test -f "$ARTICLE_DIR/README.md"
test -f "$ARTICLE_DIR/python/soil_monitoring_readiness.py"
test -f "$ARTICLE_DIR/r/soil_monitoring_reporting.R"
test -f "$ARTICLE_DIR/sql/schema.sql"
test -f "$ARTICLE_DIR/schemas/soil_observation.schema.json"
echo "Expected file test passed."
