# Flood Monitoring Systems and Hydrological Risk Detection

This companion directory supports the article **Flood Monitoring Systems and Hydrological Risk Detection**.

The article frames flood monitoring as hydrological early-warning infrastructure that connects:

- streamgages, rainfall gauges, radar, satellites, and hydrometeorological observations
- telemetry, latency, stale-data, and gauge-health review
- stage, discharge, rainfall, rate-of-rise, reservoir, soil-wetness, and snowmelt context
- forecast models, flash-flood guidance, and inundation-map linkages
- action stages, flood stages, local impact thresholds, and warning triggers
- protective lead time, emergency response, road closure, evacuation support, and public communication
- post-event review, coverage equity, governance, and flood accountability

## Technical focus

This scaffold models flood monitoring as an auditable early-warning evidence system rather than a set of gauges or maps.

Core engineering themes:

- gauge coverage
- rainfall coverage
- telemetry completeness
- forecast confidence
- inundation-map readiness
- protective lead time
- communication readiness
- response capacity
- governance readiness
- coverage equity and public evidence

## Run examples

```bash
bash bash/validate_manifests.sh
python3 python/flood_monitoring_readiness.py
Rscript r/flood_monitoring_reporting.R
sqlite3 outputs/flood_monitoring.db < sql/schema.sql
sqlite3 outputs/flood_monitoring.db < sql/sample_queries.sql
```
