#!/usr/bin/env bash
set -euo pipefail

ARTICLE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

test -f "$ARTICLE_DIR/README.md"
test -f "$ARTICLE_DIR/companion_manifest.yml"
test -f "$ARTICLE_DIR/python/biodiversity_monitoring_readiness.py"
test -f "$ARTICLE_DIR/r/biodiversity_monitoring_reporting.R"
test -f "$ARTICLE_DIR/sql/schema.sql"
test -f "$ARTICLE_DIR/schemas/species_observation.schema.json"
test -f "$ARTICLE_DIR/typescript/src/biodiversity_monitoring_types.ts"

echo "Expected file test passed."
