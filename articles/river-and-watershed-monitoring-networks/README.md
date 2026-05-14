# River and Watershed Monitoring Networks

This companion directory supports the article **River and Watershed Monitoring Networks**.

The article frames watershed monitoring as basin-scale knowledge infrastructure that connects:

- streamgages, water-quality stations, ecological assessment sites, rainfall records, groundwater observations, reservoirs, and telemetry
- basin topology, tributary hierarchy, confluences, outlets, sub-basins, and upstream–downstream inference
- concentration, discharge, instantaneous load, event load, basin export, residence time, and source attribution
- network representativeness, temporal continuity, event capture, interoperability, and governance readiness
- public evidence packages, data-sharing logs, cross-agency coordination, and hydrological accountability

## Technical focus

This scaffold models river and watershed monitoring as an auditable basin-scale evidence system rather than a loose collection of stations.

Core engineering themes:

- gauge coverage
- water-quality coverage
- ecological coverage
- network representativeness
- temporal continuity
- event capture
- uncertainty communication
- data interoperability
- governance readiness
- topology-aware monitoring design

## Run examples

```bash
bash bash/validate_manifests.sh
python3 python/watershed_monitoring_readiness.py
Rscript r/watershed_monitoring_reporting.R
sqlite3 outputs/watershed_monitoring.db < sql/schema.sql
sqlite3 outputs/watershed_monitoring.db < sql/sample_queries.sql
```
