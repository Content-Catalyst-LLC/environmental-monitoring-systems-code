# Runbook

## Validate manifests

```bash
bash bash/validate_manifests.sh
```

## Run Python workflow

```bash
python3 python/satellite_product_readiness.py
```

## Run R workflow

```bash
Rscript r/satellite_product_reporting.R
```

## Build SQLite database

```bash
mkdir -p outputs
sqlite3 outputs/satellite_observation.db < sql/schema.sql
sqlite3 outputs/satellite_observation.db < sql/sample_queries.sql
```

## Optional systems examples

```bash
cd go && go run satellite_product_api_health.go
cd ../rust && cargo run
```
