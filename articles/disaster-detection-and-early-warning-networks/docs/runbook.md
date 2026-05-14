# Runbook

## Validate manifests

```bash
bash bash/validate_manifests.sh
```

## Run Python workflow

```bash
python3 python/warning_chain_readiness.py
```

## Run R workflow

```bash
Rscript r/warning_reach_response_reporting.R
```

## Build SQLite database

```bash
mkdir -p outputs
sqlite3 outputs/early_warning.db < sql/schema.sql
sqlite3 outputs/early_warning.db < sql/sample_queries.sql
```

## Optional systems examples

```bash
cd go && go run warning_api_health.go
cd ../rust && cargo run
```
