# Air Quality Monitoring Systems

This companion directory supports the article **Air Quality Monitoring Systems**.

The article frames air quality monitoring as atmospheric evidence infrastructure that connects:

- regulatory stations, supplemental sensors, mobile monitoring, satellite products, meteorological context, and community monitoring
- calibration, collocation, validation, correction, quality control, telemetry, and sensor-maintenance workflows
- pollutant observations, exposure interpretation, environmental justice layers, source-proximity context, and decision-support systems
- dashboards, AQI logic, public advisories, intervention evaluation, public evidence packages, and governance records

## Technical focus

This scaffold models air quality monitoring as an auditable atmospheric evidence system rather than a loose collection of pollutant readings or dashboards.

Core engineering themes:

- calibration quality
- data completeness
- spatial coverage
- temporal coverage
- meteorological context
- exposure relevance
- uncertainty communication
- governance readiness
- sensor validation and collocation
- environmental justice and coverage equity

## Run examples

```bash
bash bash/validate_manifests.sh
python3 python/air_quality_monitoring_readiness.py
Rscript r/air_quality_monitoring_reporting.R
sqlite3 outputs/air_quality_monitoring.db < sql/schema.sql
sqlite3 outputs/air_quality_monitoring.db < sql/sample_queries.sql
```
