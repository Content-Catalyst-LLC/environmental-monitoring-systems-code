# Deployment Readiness Gate

Before a weather sensing system is used for operational forecasting, severe-weather nowcasting, aviation services, marine guidance, hydrometeorological forecasting, energy operations, infrastructure decision support, or public warning, it should pass a readiness gate.

## Checks

1. Decision use, geography, variables, platforms, forecast workflow, and latency budget are defined.
2. Surface, upper-air, radar, satellite, aircraft, marine, and specialty platforms are documented.
3. Observations arrive within the operational time window with complete timestamps and geolocation.
4. Range checks, temporal checks, spatial checks, station-health checks, and review flags are defined.
5. Observations can be exchanged, decoded, interpreted, and reused across systems.
6. Observations are eligible for model initialization, nowcasting, or forecast correction where needed.
7. Spatial, vertical, marine, radar, satellite, and lower-capacity-region gaps are documented.
8. Observation limits, platform errors, freshness, retrieval uncertainty, and valid-use caveats are exposed.
9. Ownership, maintenance, data-sharing, corrective actions, and public accountability are documented.
