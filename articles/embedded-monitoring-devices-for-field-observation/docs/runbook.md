# Runbook

## Validate manifests

```bash
bash bash/validate_manifests.sh
```

## Run Python workflow

```bash
python3 python/embedded_device_readiness.py
```

## Run R workflow

```bash
Rscript r/embedded_device_reporting.R
```

## Build SQLite database

```bash
mkdir -p outputs
sqlite3 outputs/embedded_device_monitoring.db < sql/schema.sql
sqlite3 outputs/embedded_device_monitoring.db < sql/sample_queries.sql
```

## Optional systems examples

```bash
cd go && go run device_health_endpoint.go
cd ../rust && cargo run
```
