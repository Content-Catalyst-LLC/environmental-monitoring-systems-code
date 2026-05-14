# Runbook

## Validate manifests

```bash
bash bash/validate_manifests.sh
```

## Run Python workflow

```bash
python3 python/risk_resilience_scoring.py
```

## Run R workflow

```bash
Rscript r/recovery_trajectory_reporting.R
```

## Build SQLite database

```bash
mkdir -p outputs
sqlite3 outputs/risk_resilience.db < sql/schema.sql
sqlite3 outputs/risk_resilience.db < sql/sample_queries.sql
```

## Optional systems examples

```bash
cd go && go run risk_api_health.go
cd ../rust && cargo run
```
