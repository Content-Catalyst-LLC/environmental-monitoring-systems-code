# Runbook

## Validate manifests

```bash
bash bash/validate_manifests.sh
```

## Run Python workflow

```bash
python3 python/land_monitoring_readiness.py
```

## Run R workflow

```bash
Rscript r/land_monitoring_reporting.R
```

## Build SQLite database

```bash
mkdir -p outputs
sqlite3 outputs/land_monitoring.db < sql/schema.sql
sqlite3 outputs/land_monitoring.db < sql/sample_queries.sql
```

## Optional systems examples

```bash
cd go && go run product_status_endpoint.go
cd ../rust && cargo run
```
