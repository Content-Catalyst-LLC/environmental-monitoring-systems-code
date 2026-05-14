# Biodiversity Monitoring Systems

This companion directory supports the article **Biodiversity Monitoring Systems: Ecological Observation, Indicators, and Conservation Accountability**.

The article frames biodiversity monitoring as socio-ecological knowledge infrastructure that connects:

- field surveys, plots, transects, and repeated inventories
- camera traps, acoustic recorders, automated sensors, and eDNA
- remote sensing for habitat extent, structure, fragmentation, and ecosystem context
- Essential Biodiversity Variables and policy-facing indicators
- detectability, sampling effort, bias, and ecological inference
- community-based, Indigenous, local, and citizen-science monitoring
- national biodiversity strategy, GBF reporting, restoration, and conservation accountability
- uncertainty communication, governance, and public evidence review

## Technical focus

This scaffold models biodiversity monitoring as an auditable evidence system rather than a species-counting exercise.

Core engineering themes:

- taxonomic coverage
- spatial representativeness
- method diversity
- detectability adjustment
- observation quality
- EBV / indicator readiness
- habitat-context linkage
- community knowledge governance
- uncertainty communication
- reporting readiness
- conservation accountability

## Directory structure

```text
articles/biodiversity-monitoring-systems/
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
python3 python/biodiversity_monitoring_readiness.py
Rscript r/biodiversity_monitoring_reporting.R
sqlite3 outputs/biodiversity_monitoring.db < sql/schema.sql
sqlite3 outputs/biodiversity_monitoring.db < sql/sample_queries.sql
```
