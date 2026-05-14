# Embedded Device Field Evidence Framework

Embedded monitoring devices are field-resident evidence systems.

## Core layers

| Layer | Question | Evidence artifact |
|---|---|---|
| Objective | What environmental process, variable, deployment duration, cadence, and decision use are being supported? | Device objective manifest |
| Sensing | What field signal is observed and how suitable is the sensor for the medium and range? | Device and sensor registry |
| Conditioning | How is the environmental signal converted, filtered, corrected, or digitized? | Signal chain note and firmware manifest |
| Timing | How are phenomenon time, result time, clock source, and drift managed? | Timing policy and clock drift log |
| Power | Can the device support sensing, processing, storage, telemetry, and diagnostics across the deployment interval? | Power budget manifest |
| Storage | Can records survive outages, retrieval delay, and local storage limits? | Storage and telemetry manifest |
| Telemetry | How are values, alerts, status, and delayed records transmitted? | Connectivity manifest and transmission log |
| Enclosure | Can the device survive exposure while preserving measurement validity? | Enclosure and deployment record |
| QA/QC | How are range, spike, flatline, missingness, clock, stale calibration, and drift handled? | Field QA/QC policy |
| Governance | Who owns maintenance, calibration, firmware, data integrity, public caveats, and review? | Governance log |
