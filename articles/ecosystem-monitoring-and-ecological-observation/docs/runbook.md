# Runbook

## Validate manifests

```bash
bash bash/validate_manifests.sh
```

## Run Python workflow

```bash
python3 python/ecosystem_monitoring_readiness.py
```

## Run R workflow

```bash
Rscript r/ecosystem_monitoring_reporting.R
```

## Build SQLite database

```bash
mkdir -p outputs
sqlite3 outputs/ecosystem_monitoring.db < sql/schema.sql
sqlite3 outputs/ecosystem_monitoring.db < sql/sample_queries.sql
```

## Optional systems examples

```bash
cd go && go run program_status_endpoint.go
cd ../rust && cargo run
```
