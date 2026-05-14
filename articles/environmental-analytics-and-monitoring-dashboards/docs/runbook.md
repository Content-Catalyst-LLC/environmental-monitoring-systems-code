# Runbook

## Validate manifests

```bash
bash bash/validate_manifests.sh
```

## Run Python workflow

```bash
python3 python/dashboard_signal_quality.py
```

## Run R workflow

```bash
Rscript r/dashboard_indicator_reporting.R
```

## Build SQLite database

```bash
mkdir -p outputs
sqlite3 outputs/dashboard_monitoring.db < sql/schema.sql
sqlite3 outputs/dashboard_monitoring.db < sql/sample_queries.sql
```

## Optional systems examples

```bash
cd go && go run dashboard_api_health.go
cd ../rust && cargo run
```
