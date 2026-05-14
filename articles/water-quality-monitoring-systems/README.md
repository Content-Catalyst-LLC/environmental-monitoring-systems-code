# Water Quality Monitoring Systems

This companion directory supports the article **Water Quality Monitoring Systems**.

The article frames water quality monitoring as aquatic knowledge infrastructure that connects:

- field sensors, grab samples, composite samples, autosamplers, laboratory analysis, and biological assessment
- site registries, hydrological context, watershed position, flow linkage, and event timing
- QA/QC procedures, calibration, fouling checks, blanks, duplicates, detection limits, and chain of custody
- concentration, discharge, load, exceedance, exposure, threshold alignment, and uncertainty
- public-health protection, aquatic-life assessment, operational response, regulatory assessment, and watershed accountability

## Technical focus

This scaffold models water quality monitoring as an auditable aquatic evidence system rather than a loose parameter list.

Core engineering themes:

- sampling representativeness
- analytical validity
- hydrological context
- QA/QC completeness
- load readiness
- threshold alignment
- uncertainty communication
- data interoperability
- governance readiness
- public evidence and aquatic accountability

## Run examples

```bash
bash bash/validate_manifests.sh
python3 python/water_quality_monitoring_readiness.py
Rscript r/water_quality_monitoring_reporting.R
sqlite3 outputs/water_quality_monitoring.db < sql/schema.sql
sqlite3 outputs/water_quality_monitoring.db < sql/sample_queries.sql
```
