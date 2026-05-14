# Field Device Fault Model Card

## Purpose

This placeholder card documents a future device-fault or quiet-failure detection model.

## Intended use

- identify drift
- identify fouling
- identify battery decline
- identify storage risk
- identify internal humidity rise
- identify repeated reboot behavior
- distinguish device anomaly from environmental anomaly

## Required documentation

- model or rule ID
- device type
- input health signals
- input observation signals
- threshold or model version
- output labels
- confidence or severity
- false-positive risks
- false-negative risks
- field validation status
- owner and review cadence

## Known risks

- confusing environmental extremes with device faults
- weak reference data
- changing seasonal behavior
- missing health telemetry
- unreviewed firmware changes
- public overinterpretation of automated fault labels
