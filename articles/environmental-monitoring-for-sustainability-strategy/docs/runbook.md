# Runbook

## Validate manifests

```bash
bash bash/validate_manifests.sh
```

## Run Python workflow

```bash
python3 python/sustainability_indicator_integrity.py
```

## Run R workflow

```bash
Rscript r/sustainability_progress_reporting.R
```

## Build SQLite database

```bash
mkdir -p outputs
sqlite3 outputs/sustainability_monitoring.db < sql/schema.sql
sqlite3 outputs/sustainability_monitoring.db < sql/sample_queries.sql
```

## Optional systems examples

```bash
cd go && go run indicator_status_api.go
cd ../rust && cargo run
```
