# Mathematical Lens

## Telemetry completeness

\[
C_{\mathrm{telemetry}} = \frac{N_{\mathrm{received\ readings}}}{N_{\mathrm{expected\ readings}}}
\]

Telemetry completeness measures whether the system receives enough expected readings to support operations.

## Response latency

\[
L_{\mathrm{response}} = T_{\mathrm{action}} - T_{\mathrm{detection}}
\]

Response latency measures the time between detection and action.

## Water loss ratio

\[
R_{\mathrm{loss}} = \frac{V_{\mathrm{produced}} - V_{\mathrm{billed}}}{V_{\mathrm{produced}}}
\]

Water loss ratio compares produced water with billed or accounted water.

## Alert confidence

\[
P_{\mathrm{alert}} = f(S_{\mathrm{signal}}, Q_d, B_{\mathrm{baseline}}, H_{\mathrm{history}})
\]

Alert confidence depends on signal strength, data quality, baseline behavior, and historical context.

## Smart-water evidence quality

\[
Q_{\mathrm{smart\ water}} =
w_1C_s +
w_2Q_d +
w_3C_t +
w_4L_r +
w_5A_c +
w_6R_c +
w_7M_r +
w_8S_{\mathrm{control}} +
w_9G_r
\]
