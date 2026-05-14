# Weather Sensing and Atmospheric Data Systems

This companion directory supports the article **Weather Sensing and Atmospheric Data Systems**.

The article frames weather sensing as real-time atmospheric evidence infrastructure that connects:

- surface stations, upper-air profiles, radar, satellites, aircraft observations, marine observations, and specialty platforms
- telemetry, latency budgets, platform metadata, timestamping, geolocation, and operational data exchange
- quality control, range checks, spatial checks, temporal consistency, station health, and valid-use caveats
- observation freshness, platform coverage, vertical constraint, assimilation readiness, representativeness, and uncertainty
- nowcasting, numerical weather prediction, severe-weather warning, aviation, marine, hydrometeorology, and decision support

## Technical focus

This scaffold models weather sensing as an auditable real-time atmospheric evidence system rather than a loose collection of station feeds or platform products.

Core engineering themes:

- observation freshness
- spatial coverage
- vertical coverage
- quality-control completeness
- assimilation readiness
- representativeness
- uncertainty communication
- governance readiness
- latency and telemetry health
- platform ecology and observational inequality

## Run examples

```bash
bash bash/validate_manifests.sh
python3 python/weather_sensing_readiness.py
Rscript r/weather_sensing_reporting.R
sqlite3 outputs/weather_sensing.db < sql/schema.sql
sqlite3 outputs/weather_sensing.db < sql/sample_queries.sql
```
