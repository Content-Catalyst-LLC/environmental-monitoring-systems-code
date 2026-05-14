# Runbook

## Validate manifests

```bash
bash bash/validate_manifests.sh
```

## Run Python workflow

```bash
python3 python/edge_readiness.py
```

## Run R workflow

```bash
Rscript r/edge_readiness_reporting.R
```

## Build SQLite database

```bash
mkdir -p outputs
sqlite3 outputs/edge_computing_monitoring.db < sql/schema.sql
sqlite3 outputs/edge_computing_monitoring.db < sql/sample_queries.sql
```

## Optional systems examples

```bash
cd go && go run edge_health_endpoint.go
cd ../rust && cargo run
```
