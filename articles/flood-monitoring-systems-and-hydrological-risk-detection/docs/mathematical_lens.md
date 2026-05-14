# Mathematical Lens

Flood monitoring should be evaluated as an early-warning evidence system, not only as a collection of water-level observations.

## Rate of rise

\[
R_{\mathrm{rise}} = \frac{h_t - h_{t-\Delta t}}{\Delta t}
\]

Rate of rise measures how quickly water level is increasing. It is especially important where warning lead time is short.

## Telemetry completeness

\[
C_{\mathrm{telemetry}} = \frac{N_{\mathrm{received\ observations}}}{N_{\mathrm{expected\ observations}}}
\]

Telemetry completeness measures whether enough expected observations are arriving to support operational awareness.

## Protective lead time

\[
L_{\mathrm{protective}} = T_{\mathrm{impact}} - T_{\mathrm{warning}}
\]

Protective lead time is the time between warning and expected impact.

## Flood probability

\[
P_{\mathrm{flood}} = f(P_{\mathrm{rain}}, S_{\mathrm{soil}}, Q_{\mathrm{upstream}}, C_{\mathrm{channel}}, O_{\mathrm{operations}})
\]

Flood probability depends on rainfall, antecedent soil wetness, upstream flow, channel conveyance, and operational controls.

## Flood risk

\[
R_{\mathrm{risk}} = H_f \times E_x \times V_u
\]

Flood risk depends on hazard, exposure, and vulnerability.

## Flood-warning quality

\[
Q_{\mathrm{flood\ warning}} =
w_1C_g +
w_2C_r +
w_3C_t +
w_4C_f +
w_5M_i +
w_6L_p +
w_7C_w +
w_8R_c +
w_9G_r
\]

Flood-warning quality depends on gauge coverage, rainfall coverage, telemetry completeness, forecast confidence, inundation-map readiness, protective lead time, communication readiness, response capacity, and governance readiness.
