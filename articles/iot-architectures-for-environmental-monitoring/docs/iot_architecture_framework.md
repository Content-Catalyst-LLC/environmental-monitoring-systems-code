# IoT Architecture Framework

Environmental IoT architecture is a chain from device signal to accountable decision.

| Layer | Question | Evidence artifact |
|---|---|---|
| Objective | What process, decision use, latency class, and evidence standard are supported? | Objective manifest |
| Device | Which sensors, firmware, calibration records, and deployment contexts produce observations? | Device registry |
| Embedded control | How are sampling, power, timestamping, local storage, and local QC handled? | Firmware manifest |
| Gateway / edge | How are records buffered, filtered, translated, prioritized, and traced? | Gateway registry |
| Network | How are observations delivered under constraints of latency, reliability, security, and geography? | Connectivity manifest |
| Platform | How are records ingested, validated, stored, exposed, and governed? | Platform schema |
| Semantics | Are properties, units, locations, timestamps, quality flags, and provenance coherent? | Observation schema |
| Analytics | How are thresholds, anomalies, models, and alerts created and reviewed? | Alert registry |
| Governance | Who owns, maintains, reviews, secures, explains, and corrects the system? | Governance log |
