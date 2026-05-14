#!/usr/bin/env bash
set -euo pipefail

ARTICLE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

test -f "$ARTICLE_DIR/README.md"
test -f "$ARTICLE_DIR/companion_manifest.yml"
test -f "$ARTICLE_DIR/python/sensor_network_readiness.py"
test -f "$ARTICLE_DIR/r/sensor_network_reporting.R"
test -f "$ARTICLE_DIR/sql/schema.sql"
test -f "$ARTICLE_DIR/schemas/network_observation.schema.json"
test -f "$ARTICLE_DIR/typescript/src/sensor_network_types.ts"

echo "Expected file test passed."
