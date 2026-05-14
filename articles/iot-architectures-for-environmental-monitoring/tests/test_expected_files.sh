#!/usr/bin/env bash
set -euo pipefail
ARTICLE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
test -f "$ARTICLE_DIR/README.md"
test -f "$ARTICLE_DIR/companion_manifest.yml"
test -f "$ARTICLE_DIR/python/iot_architecture_readiness.py"
test -f "$ARTICLE_DIR/r/iot_architecture_reporting.R"
test -f "$ARTICLE_DIR/sql/schema.sql"
test -f "$ARTICLE_DIR/schemas/environmental_observation.schema.json"
test -f "$ARTICLE_DIR/typescript/src/iot_architecture_types.ts"
echo "Expected file test passed."
