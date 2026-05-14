# Mathematical Lens

Weather sensing should be evaluated as a real-time atmospheric evidence system, not only as an observation feed.

## Observation latency

\[
L_o = T_a - T_o
\]

Observation latency is the time between measurement and operational availability.

## Observation freshness

\[
F_{\mathrm{fresh}} = \frac{N_{\mathrm{fresh}}}{N_{\mathrm{expected}}}
\]

Observation freshness measures the share of expected observations that arrive within the operational latency budget.

## Platform coverage

\[
C_{\mathrm{platform}} = \frac{P_{\mathrm{active}}}{P_{\mathrm{required}}}
\]

Platform coverage estimates the fraction of required observation platforms that are active and reporting.

## Assimilation readiness

\[
A_{\mathrm{ready}} = \frac{N_{\mathrm{assimilable}}}{N_{\mathrm{valid}}}
\]

Assimilation readiness measures the share of valid observations that meet metadata, format, freshness, and quality requirements for model or nowcast ingestion.

## Weather evidence quality

\[
Q_{\mathrm{weather\ evidence}} =
w_1F_{\mathrm{fresh}} +
w_2C_s +
w_3C_v +
w_4Q_c +
w_5A_r +
w_6R_p +
w_7U_c +
w_8G_r
\]

Weather evidence quality depends on freshness, spatial coverage, vertical coverage, quality-control completeness, assimilation readiness, representativeness, uncertainty communication, and governance readiness.
