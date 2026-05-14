# Monitoring Environmental Risk and Resilience

This companion directory supports the article **Monitoring Environmental Risk and Resilience: Hazards, Recovery, Thresholds, and Adaptive Capacity**.

The article frames environmental risk and resilience monitoring as a governed evidence infrastructure that connects:

- hazards
- exposure
- vulnerability
- coping capacity
- adaptive capacity
- threshold proximity
- ecological and infrastructure stress
- recovery trajectories
- resilience indicators
- equity and coverage audits
- post-event learning
- anticipatory governance

## Technical focus

This scaffold models risk and resilience as dynamic system conditions rather than isolated hazard events.

Core engineering themes:

- hazard-exposure-vulnerability-capacity scoring
- threshold registries and trigger governance
- recovery trajectory monitoring
- adaptive-capacity assessment
- ecological and infrastructure resilience indicators
- environmental justice and unequal recovery
- post-event learning records
- decision-support readiness gates
- reproducible risk and resilience workflows

## Directory structure

```text
articles/monitoring-environmental-risk-and-resilience/
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
python3 python/risk_resilience_scoring.py
Rscript r/recovery_trajectory_reporting.R
sqlite3 outputs/risk_resilience.db < sql/schema.sql
sqlite3 outputs/risk_resilience.db < sql/sample_queries.sql
```
