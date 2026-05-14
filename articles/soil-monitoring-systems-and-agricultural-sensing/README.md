# Soil Monitoring Systems and Agricultural Sensing

This companion directory supports the article **Soil Monitoring Systems and Agricultural Sensing**.

The article frames soil monitoring as root-zone knowledge infrastructure that connects:

- in situ soil moisture, temperature, salinity, and conductivity sensing
- soil profile metadata and field-zone context
- calibration, maintenance, telemetry, and data-quality checks
- laboratory soil analysis and soil-health indicators
- remote and modeled soil-moisture products
- irrigation, nutrient, drought, runoff, salinity, and stewardship decisions
- public evidence packages and soil information governance

## Technical focus

This scaffold models soil monitoring as an auditable root-zone evidence system rather than a loose set of sensor readings.

Core engineering themes:

- spatial representativeness
- depth representation
- calibration quality
- telemetry completeness
- laboratory support
- remote-product agreement
- uncertainty communication
- decision readiness
- threshold governance
- soil stewardship accountability

## Run examples

```bash
bash bash/validate_manifests.sh
python3 python/soil_monitoring_readiness.py
Rscript r/soil_monitoring_reporting.R
sqlite3 outputs/soil_monitoring.db < sql/schema.sql
sqlite3 outputs/soil_monitoring.db < sql/sample_queries.sql
```
