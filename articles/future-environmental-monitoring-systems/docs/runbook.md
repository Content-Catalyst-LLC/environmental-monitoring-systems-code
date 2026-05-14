# Runbook

## Validate manifests

```bash
bash bash/validate_manifests.sh
```

## Run Python workflow

```bash
python3 python/environmental_intelligence_pipeline.py
```

## Run R workflow

```bash
Rscript r/indicator_reporting.R
```

## Build SQLite database

```bash
mkdir -p outputs
sqlite3 outputs/environmental_monitoring.db < sql/schema.sql
sqlite3 outputs/environmental_monitoring.db < sql/sample_queries.sql
```

## Optional systems examples

```bash
cd go && go run monitoring_api_health.go
cd ../rust && cargo run
```
