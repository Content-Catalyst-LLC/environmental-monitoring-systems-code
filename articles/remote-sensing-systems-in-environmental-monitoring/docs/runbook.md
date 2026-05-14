# Runbook

## Validate manifests

```bash
bash bash/validate_manifests.sh
```

## Run Python workflow

```bash
python3 python/remote_sensing_product_readiness.py
```

## Run R workflow

```bash
Rscript r/remote_sensing_product_reporting.R
```

## Build SQLite database

```bash
mkdir -p outputs
sqlite3 outputs/remote_sensing_monitoring.db < sql/schema.sql
sqlite3 outputs/remote_sensing_monitoring.db < sql/sample_queries.sql
```

## Optional systems examples

```bash
cd go && go run remote_sensing_product_api_health.go
cd ../rust && cargo run
```
