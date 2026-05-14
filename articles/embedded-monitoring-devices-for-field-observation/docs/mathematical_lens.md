# Mathematical Lens

Embedded monitoring devices should be evaluated as field evidence systems, not only as sensors.

## Device availability

\[
A_{\mathrm{device}} = \frac{T_{\mathrm{valid\ operation}}}{T_{\mathrm{deployment}}}
\]

Device availability measures the share of deployment time in which the device operated in a valid measurement state.

## Record completeness

\[
C_{\mathrm{record}} = \frac{N_{\mathrm{valid\ records}}}{N_{\mathrm{expected\ records}}}
\]

Record completeness measures whether expected observations were captured, stored, and available for interpretation.

## Power margin

\[
P_{\mathrm{margin}} = \frac{E_{\mathrm{available}} - E_{\mathrm{required}}}{E_{\mathrm{required}}}
\]

Power margin measures whether available energy exceeds expected energy demand for sensing, processing, storage, diagnostics, and telemetry.

## Drift

\[
D_{\mathrm{drift}} = \left|x_{\mathrm{field}} - x_{\mathrm{reference}}\right|
\]

Drift can be approximated as the difference between a field measurement and reference or comparison value under comparable conditions.

## Timing consistency

\[
K_{\mathrm{time}} = 1 - \min\left(\frac{\Delta t_{\mathrm{clock}}}{\Delta t_{\mathrm{allowed}}}, 1\right)
\]

Timing consistency decreases as clock drift approaches or exceeds the allowed timing error for the monitoring purpose.

## Field evidence quality

\[
Q_{\mathrm{field\ evidence}} = w_1A_{\mathrm{device}} + w_2C_{\mathrm{record}} + w_3P_{\mathrm{margin}} + w_4C_{\mathrm{calibration}} + w_5K_{\mathrm{time}} + w_6Q_{\mathrm{qc}} + w_7H_{\mathrm{health}}
\]

Field evidence quality depends on device availability, record completeness, power margin, calibration validity, timing consistency, QA/QC readiness, and health telemetry visibility.
