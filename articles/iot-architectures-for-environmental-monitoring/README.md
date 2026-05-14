# IoT Architectures for Environmental Monitoring

This companion directory supports the article **IoT Architectures for Environmental Monitoring: Devices, Platforms, and Environmental Intelligence**.

The scaffold treats environmental IoT as a device-to-decision evidence architecture. It connects devices, embedded control, gateways, constrained networks, semantic observation schemas, quality-control rules, alert governance, platform services, and environmental decision workflows.

## Technical focus

- device availability and calibration
- record delivery and latency
- semantic completeness
- gateway buffering and edge traceability
- environmental observation schemas
- quality-control rules
- alert-rule governance
- platform health and observability
- graceful degradation
- evidence-quality scoring

## Run examples

```bash
bash bash/validate_manifests.sh
python3 python/iot_architecture_readiness.py
Rscript r/iot_architecture_reporting.R
sqlite3 outputs/iot_architecture_monitoring.db < sql/schema.sql
sqlite3 outputs/iot_architecture_monitoring.db < sql/sample_queries.sql
```
