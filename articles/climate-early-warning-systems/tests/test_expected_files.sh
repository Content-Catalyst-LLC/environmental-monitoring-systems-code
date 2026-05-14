#!/usr/bin/env bash
set -euo pipefail

ARTICLE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

test -f "$ARTICLE_DIR/README.md"
test -f "$ARTICLE_DIR/companion_manifest.yml"
test -f "$ARTICLE_DIR/python/early_warning_readiness.py"
test -f "$ARTICLE_DIR/r/early_warning_reporting.R"
test -f "$ARTICLE_DIR/sql/schema.sql"
test -f "$ARTICLE_DIR/schemas/warning_decision.schema.json"
test -f "$ARTICLE_DIR/schemas/communication_channel.schema.json"
test -f "$ARTICLE_DIR/typescript/src/early_warning_types.ts"
test -f "$ARTICLE_DIR/data/early_warning_readiness_scores.csv"
test -f "$ARTICLE_DIR/data/warning_decision_log.csv"
test -f "$ARTICLE_DIR/data/communication_channel_registry.csv"

echo "Expected file test passed."
