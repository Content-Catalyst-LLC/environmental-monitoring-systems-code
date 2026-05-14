#!/usr/bin/env bash
set -euo pipefail

ARTICLE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
test -f "$ARTICLE_DIR/README.md"
test -f "$ARTICLE_DIR/python/smart_water_readiness.py"
test -f "$ARTICLE_DIR/r/smart_water_reporting.R"
test -f "$ARTICLE_DIR/sql/schema.sql"
test -f "$ARTICLE_DIR/schemas/water_observation.schema.json"
echo "Expected file test passed."
