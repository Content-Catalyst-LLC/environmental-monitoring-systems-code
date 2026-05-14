# Mathematical Lens

Environmental analytics dashboards should be evaluated as decision-support systems, not only as visual interfaces.

## Freshness ratio

\[
R_{\mathrm{freshness}} = \frac{N_{\mathrm{fresh\ indicators}}}{N_{\mathrm{displayed\ indicators}}}
\]

Freshness ratio measures the share of displayed indicators current enough for their intended decision use.

## Provenance completeness

\[
P_{\mathrm{provenance}} = \frac{N_{\mathrm{traceable\ displays}}}{N_{\mathrm{displayed\ objects}}}
\]

Provenance completeness measures whether displayed charts, maps, values, and alerts can be traced to source data and transformations.

## Alert burden

\[
B_{\mathrm{alert}} = \frac{N_{\mathrm{alerts}}}{N_{\mathrm{actionable\ alerts}}}
\]

Alert burden rises when many alerts do not support meaningful action.

## Uncertainty visibility

\[
U_{\mathrm{visibility}} = \frac{N_{\mathrm{uncertainty\ labeled}}}{N_{\mathrm{modeled\ or\ estimated}}}
\]

Uncertainty visibility measures whether modeled, estimated, interpolated, or low-confidence objects are clearly labeled.

## Role fit

\[
F_{\mathrm{role}} = \frac{N_{\mathrm{tasks\ supported}}}{N_{\mathrm{priority\ user\ tasks}}}
\]

Role fit measures how well the dashboard supports the priority tasks of its intended users.

## Decision-support quality

\[
Q_{\mathrm{decision}} = w_1R_{\mathrm{freshness}} + w_2P_{\mathrm{provenance}} + w_3U_{\mathrm{visibility}} + w_4F_{\mathrm{role}} - w_5B_{\mathrm{alert}}
\]

Decision-support quality combines freshness, provenance, uncertainty visibility, role fit, and alert burden.
