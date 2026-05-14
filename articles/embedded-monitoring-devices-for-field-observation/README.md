# Embedded Monitoring Devices for Field Observation

This companion directory supports the article **Embedded Monitoring Devices for Field Observation: Edge Sensing, Reliability, and Field Data Integrity**.

The article frames embedded field devices as edge-resident infrastructures of environmental observability that connect:

- sensors and transducers
- embedded control and firmware
- timing and local logging
- power budgets and duty cycles
- rugged enclosures and deployment mechanics
- calibration and maintenance records
- local storage and store-and-forward buffering
- telemetry and delayed-record handling
- field QA/QC
- device-health telemetry
- drift, fouling, and quiet-failure detection
- evidence governance and public caveats

## Technical focus

This scaffold models embedded monitoring devices as full field evidence systems rather than isolated sensor packages.

Core engineering themes:

- device availability
- record completeness
- power margin
- calibration validity
- timing consistency
- QA/QC readiness
- device-health visibility
- telemetry completeness
- storage integrity
- enclosure and exposure risk
- field maintainability
- decision-use readiness

## Directory structure

```text
articles/embedded-monitoring-devices-for-field-observation/
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
python3 python/embedded_device_readiness.py
Rscript r/embedded_device_reporting.R
sqlite3 outputs/embedded_device_monitoring.db < sql/schema.sql
sqlite3 outputs/embedded_device_monitoring.db < sql/sample_queries.sql
```
