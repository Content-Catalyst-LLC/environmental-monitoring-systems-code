# Environmental Sensor Networks

This companion directory supports the article **Environmental Sensor Networks: Distributed Sensing, Telemetry, and Environmental Accountability**.

The article frames environmental sensor networks as distributed evidence infrastructures that connect:

- sensing nodes and field sites
- topology and coverage strategy
- telemetry and latency management
- metadata and semantic interoperability
- calibration and validation
- network QA/QC
- proxy measurement and partial observability
- alerts, thresholds, and action pathways
- coverage and equity audits
- data platforms and dashboards
- governance, public evidence, and accountability

## Technical focus

This scaffold models sensor networks as environmental observing systems rather than collections of devices.

Core engineering themes:

- spatial coverage
- temporal completeness
- node availability
- representativeness
- valid-data share
- metadata maturity
- latency readiness
- action fit
- telemetry completeness
- cross-node QA/QC
- topology governance
- public evidence integrity

## Directory structure

```text
articles/environmental-sensor-networks/
  config/
  data/
  docs/
  model_cards/
  outputs/
  python/
  r/
  sql/
  schemas/
  go/
  rust/
  typescript/
  c/
  cpp/
  micropython/
  tinyml/
  pynq/
  hdl/
  bash/
  tests/
```

## Run examples

```bash
bash bash/validate_manifests.sh
python3 python/sensor_network_readiness.py
Rscript r/sensor_network_reporting.R
sqlite3 outputs/sensor_network_monitoring.db < sql/schema.sql
sqlite3 outputs/sensor_network_monitoring.db < sql/sample_queries.sql
```
