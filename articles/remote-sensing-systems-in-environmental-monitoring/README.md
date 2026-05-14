# Remote Sensing Systems in Environmental Monitoring

This companion directory supports the article **Remote Sensing Systems in Environmental Monitoring: Scale, Spectral Inference, and Environmental Change**.

The article frames remote sensing as environmental evidence infrastructure that connects:

- observation objectives
- platforms and sensors
- optical, thermal, hyperspectral, radar, microwave, lidar, aircraft, drone, satellite, and tower observations
- calibration and preprocessing
- atmospheric correction and quality masks
- product registries
- inference and proxy logic
- field validation
- time-series and change detection
- uncertainty and proxy-transparency policies
- product governance logs
- decision-support workflows

## Technical focus

This scaffold models remote-sensing products as governed evidence objects rather than self-explanatory images.

Core engineering themes:

- signal-to-claim evidence chains
- valid coverage
- revisit and temporal continuity
- inference quality
- correction and preprocessing quality
- proxy transparency
- field validation
- classification and retrieval review
- time-series continuity
- product governance
- decision-use readiness
- public evidence accountability

## Directory structure

```text
articles/remote-sensing-systems-in-environmental-monitoring/
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
python3 python/remote_sensing_product_readiness.py
Rscript r/remote_sensing_product_reporting.R
sqlite3 outputs/remote_sensing_monitoring.db < sql/schema.sql
sqlite3 outputs/remote_sensing_monitoring.db < sql/sample_queries.sql
```
