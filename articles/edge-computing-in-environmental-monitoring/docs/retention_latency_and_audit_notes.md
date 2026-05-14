# Retention, Latency, and Audit Notes

Edge systems become fragile when they are fast but not reconstructable.

## Retention questions

- What raw data are always retained?
- What is summarized locally?
- What is discarded?
- Are discarded records counted?
- Are low-confidence and ambiguous samples retained for audit?
- Are event windows stored before and after local triggers?
- Are raw-data retention rules different for high-stakes uses?

## Latency questions

- What is the target decision horizon?
- What is the observed end-to-end latency?
- Does the system distinguish phenomenon time, result time, ingestion time, and decision-available time?
- Are delayed replayed records labeled as delayed?

## Audit questions

- Can a local alert be traced to a sensor, rule, model, firmware version, trigger window, and retained context?
- Are edge transformations logged?
- Are inference outputs labeled as inferred?
- Are model confidence and version transmitted?
- Can central reviewers reproduce why a local decision occurred?
