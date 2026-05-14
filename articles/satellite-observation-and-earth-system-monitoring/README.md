# Satellite Observation and Earth System Monitoring

This companion directory supports the article **Satellite Observation and Earth System Monitoring: Orbital Evidence, Coupled Systems, and Planetary Change**.

The article frames satellite observation as orbital-scale environmental evidence infrastructure that connects:

- mission and sensor inventories
- orbit and revisit logic
- optical, infrared, microwave, radar, lidar, altimetry, and related sensing modes
- calibration and geolocation records
- retrieval algorithms
- satellite product registries
- uncertainty and proxy-transparency policies
- in situ validation records
- mission-continuity plans
- product governance logs
- Earth-system integration workflows
- public and operational decision-support services

## Technical focus

This scaffold models satellite products as governed evidence objects rather than self-explanatory images.

Core engineering themes:

- orbit and mission design
- usable coverage
- revisit rate
- retrieval quality
- calibration and validation
- proxy transparency
- continuity across missions
- mission overlap and cross-calibration
- in situ validation
- satellite product governance
- decision-use readiness
- Earth-system evidence quality

## Directory structure

```text
articles/satellite-observation-and-earth-system-monitoring/
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
python3 python/satellite_product_readiness.py
Rscript r/satellite_product_reporting.R
sqlite3 outputs/satellite_observation.db < sql/schema.sql
sqlite3 outputs/satellite_observation.db < sql/sample_queries.sql
```
