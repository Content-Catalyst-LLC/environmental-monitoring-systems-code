#!/usr/bin/env bash
set -euo pipefail

ARTICLE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

test -f "$ARTICLE_DIR/README.md"
test -f "$ARTICLE_DIR/companion_manifest.yml"
test -f "$ARTICLE_DIR/python/satellite_product_readiness.py"
test -f "$ARTICLE_DIR/r/satellite_product_reporting.R"
test -f "$ARTICLE_DIR/sql/schema.sql"
test -f "$ARTICLE_DIR/schemas/satellite_product.schema.json"
test -f "$ARTICLE_DIR/typescript/src/satellite_product_types.ts"

echo "Expected file test passed."
