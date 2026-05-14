#!/usr/bin/env bash
set -euo pipefail

ARTICLE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

test -f "$ARTICLE_DIR/README.md"
test -f "$ARTICLE_DIR/companion_manifest.yml"
test -f "$ARTICLE_DIR/python/platform_evidence_quality.py"
test -f "$ARTICLE_DIR/r/platform_evidence_reporting.R"
test -f "$ARTICLE_DIR/sql/schema.sql"
test -f "$ARTICLE_DIR/schemas/environmental_dataset.schema.json"
test -f "$ARTICLE_DIR/typescript/src/platform_types.ts"

echo "Expected file test passed."
