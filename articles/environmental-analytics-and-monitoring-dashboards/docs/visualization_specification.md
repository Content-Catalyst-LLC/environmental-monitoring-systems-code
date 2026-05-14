# Visualization Specification

Dashboard visualization should support valid environmental reasoning rather than visual persuasion.

## Requirements

- Show units beside values.
- Show last updated timestamp.
- Distinguish measured, modeled, estimated, interpolated, and inferred values.
- Link each displayed object to provenance.
- Use accessible color scales.
- Avoid color-only status encoding.
- Provide legends for maps and thresholds.
- Show uncertainty labels for modeled or estimated values.
- Keep alert severity connected to action guidance.
- Allow drill-down from summary card to source evidence.
- Keep dashboard changes documented in a release or change log.

## Review questions

- Does the map imply more precision than the data support?
- Does the color scale exaggerate or minimize severity?
- Does the ranking imply priority without decision context?
- Does the alert badge show what action is expected?
- Can users reconstruct the source and method?
