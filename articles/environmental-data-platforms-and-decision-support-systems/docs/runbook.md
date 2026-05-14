# Runbook

## Validate manifests

```bash
bash bash/validate_manifests.sh
```

## Run Python workflow

```bash
python3 python/platform_evidence_quality.py
```

## Run R workflow

```bash
Rscript r/platform_evidence_reporting.R
```

## Build SQLite database

```bash
mkdir -p outputs
sqlite3 outputs/environmental_data_platform.db < sql/schema.sql
sqlite3 outputs/environmental_data_platform.db < sql/sample_queries.sql
```

## Optional systems examples

```bash
cd go && go run platform_api_health.go
cd ../rust && cargo run
```
