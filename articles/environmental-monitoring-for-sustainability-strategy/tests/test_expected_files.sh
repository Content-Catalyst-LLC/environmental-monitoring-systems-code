#!/usr/bin/env bash
set -euo pipefail

ARTICLE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

test -f "$ARTICLE_DIR/README.md"
test -f "$ARTICLE_DIR/companion_manifest.yml"
test -f "$ARTICLE_DIR/python/sustainability_indicator_integrity.py"
test -f "$ARTICLE_DIR/r/sustainability_progress_reporting.R"
test -f "$ARTICLE_DIR/sql/schema.sql"
test -f "$ARTICLE_DIR/schemas/sustainability_indicator.schema.json"

echo "Expected file test passed."
