# Embedded Device Readiness Model Card

## Model purpose

This placeholder model card documents an embedded field-device readiness scoring workflow.

## Intended use

- evaluate device availability
- evaluate record completeness
- evaluate power margin
- evaluate calibration validity
- evaluate timing consistency
- evaluate QA/QC readiness
- evaluate health telemetry visibility
- evaluate decision fit
- triage high-stakes field devices

## Not intended for

- replacing engineering validation
- replacing calibration protocols
- certifying public alerts without governance review
- treating nominal sensor accuracy as field evidence quality
- hiding field-device limitations inside a composite score

## Inputs

- valid operation hours
- deployment hours
- valid records
- expected records
- available energy
- required energy
- calibration validity
- clock drift
- allowed clock drift
- QA/QC readiness
- device-health visibility
- decision fit
- high-stakes use flag

## Known limitations

- simplified scoring
- domain-specific thresholds required
- power margin depends on seasonal and deployment assumptions
- calibration validity depends on intended use
- health telemetry visibility does not guarantee measurement validity
- decision fit depends on institutional action pathways
