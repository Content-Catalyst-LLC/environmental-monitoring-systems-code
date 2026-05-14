#!/usr/bin/env bash
set -euo pipefail

ARTICLE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

test -f "$ARTICLE_DIR/README.md"
test -f "$ARTICLE_DIR/companion_manifest.yml"
test -f "$ARTICLE_DIR/python/edge_readiness.py"
test -f "$ARTICLE_DIR/r/edge_readiness_reporting.R"
test -f "$ARTICLE_DIR/sql/schema.sql"
test -f "$ARTICLE_DIR/schemas/edge_event.schema.json"
test -f "$ARTICLE_DIR/typescript/src/edge_computing_types.ts"

echo "Expected file test passed."
