# Mathematical Lens

Environmental sensor networks should be evaluated as distributed evidence systems, not only as device inventories.

## Spatial coverage

\[
C_{\mathrm{spatial}} = \frac{A_{\mathrm{monitored}}}{A_{\mathrm{target}}}
\]

Spatial coverage measures the share of the target area, corridor, watershed, habitat, or risk zone represented by the network.

## Temporal completeness

\[
C_{\mathrm{temporal}} = \frac{N_{\mathrm{valid\ time\ steps}}}{N_{\mathrm{expected\ time\ steps}}}
\]

Temporal completeness measures whether the network captures the expected observation sequence without major gaps.

## Network availability

\[
A_{\mathrm{network}} = \frac{N_{\mathrm{active\ nodes}}}{N_{\mathrm{deployed\ nodes}}}
\]

Network availability measures how many deployed nodes are operating in a valid measurement state.

## Valid-data share

\[
Q_{\mathrm{valid}} = \frac{N_{\mathrm{records\ passing\ QC}}}{N_{\mathrm{records}}}
\]

Valid-data share measures how much of the network stream passes defined quality-control checks.

## Latency readiness

\[
L_{\mathrm{readiness}} = 1 - \min\left(\frac{L_{\mathrm{observed}}}{L_{\mathrm{target}}}, 1\right)
\]

Latency readiness measures whether observations arrive within the decision horizon.

## Network evidence quality

\[
Q_{\mathrm{network\ evidence}} = w_1C_{\mathrm{spatial}} + w_2C_{\mathrm{temporal}} + w_3A_{\mathrm{network}} + w_4R_{\mathrm{representativeness}} + w_5Q_{\mathrm{valid}} + w_6I_{\mathrm{metadata}} + w_7L_{\mathrm{readiness}} + w_8F_{\mathrm{action}}
\]

Network evidence quality depends on spatial coverage, temporal completeness, node availability, representativeness, valid-data share, metadata/interoperability maturity, latency readiness, and action fit.
