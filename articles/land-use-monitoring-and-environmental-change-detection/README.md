# Land Use Monitoring and Environmental Change Detection

This companion directory supports the article **Land Use Monitoring and Environmental Change Detection: Landscape Change, Classification, and Environmental Accountability**.

The article frames land-use monitoring as a time-series landscape evidence system that connects:

- satellite, aerial, drone, and field observation
- imagery inventories and preprocessing manifests
- class legends and class crosswalks
- land-cover, land-use, condition, and change categories
- classification models and change-detection rules
- reference samples and validation workflows
- confusion matrices and area-adjusted estimates
- fragmentation, condition, and trajectory metrics
- uncertainty communication
- public evidence packages
- governance, revision, and accountability logs

## Technical focus

This scaffold models land-use monitoring as an auditable landscape evidence infrastructure rather than a static mapping exercise.

Core engineering themes:

- classification accuracy
- temporal consistency
- change confidence
- reference-data strength
- condition sensitivity
- fragmentation visibility
- uncertainty communication
- reporting readiness
- class-governance documentation
- change-rule versioning
- validation and area-estimation readiness
- public accountability

## Directory structure

```text
articles/land-use-monitoring-and-environmental-change-detection/
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
  bash/
  tests/
```

## Run examples

```bash
bash bash/validate_manifests.sh
python3 python/land_monitoring_readiness.py
Rscript r/land_monitoring_reporting.R
sqlite3 outputs/land_monitoring.db < sql/schema.sql
sqlite3 outputs/land_monitoring.db < sql/sample_queries.sql
```
