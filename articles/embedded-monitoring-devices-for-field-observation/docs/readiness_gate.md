# Deployment Readiness Gate

Before an embedded monitoring device is used for public communication, environmental reporting, hazard alerting, infrastructure monitoring, ecological assessment, water-quality review, air-quality monitoring, sustainability strategy, or regulatory support, it should pass a readiness gate.

## Readiness checks

1. Device design matches the environmental variable, process timescale, deployment duration, and decision use.
2. Sensor is appropriate for the range, medium, exposure, and intended use.
3. Predeployment calibration is current and documented.
4. Power budget supports sampling, processing, storage, telemetry, diagnostics, and worst-case field conditions.
5. Timing system preserves time accurately enough for event reconstruction and data integration.
6. Local storage can preserve expected records during normal operation and outages.
7. Telemetry supports required latency, completeness, delayed-record handling, and recovery.
8. Enclosure and mounting strategy survive field conditions without distorting measurement.
9. Diagnostics allow operators to distinguish environmental anomaly from device anomaly.
10. Maintenance, firmware, QA/QC, public caveats, and review responsibilities are defined.
