# Runbook

```bash
bash bash/validate_manifests.sh
python3 python/iot_architecture_readiness.py
Rscript r/iot_architecture_reporting.R
mkdir -p outputs
sqlite3 outputs/iot_architecture_monitoring.db < sql/schema.sql
sqlite3 outputs/iot_architecture_monitoring.db < sql/sample_queries.sql
```
