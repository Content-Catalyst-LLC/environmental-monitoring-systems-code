# Mathematical Lens

## Available water capacity

\[
AWC = \theta_{\mathrm{fc}} - \theta_{\mathrm{wp}}
\]

Available water capacity helps translate water content into plant-availability context.

## Root-zone storage

\[
S_{\mathrm{root}} = \int_{0}^{Z_r} \theta(z)\,dz
\]

Root-zone storage integrates water content across rooting depth.

## Depletion ratio

\[
D_{\mathrm{depletion}} = \frac{S_{\mathrm{field\ capacity}} - S_{\mathrm{current}}}{S_{\mathrm{field\ capacity}} - S_{\mathrm{wilting}}}
\]

Depletion ratio estimates how much available root-zone water has been used.

## Telemetry completeness

\[
C_{\mathrm{telemetry}} = \frac{N_{\mathrm{received\ records}}}{N_{\mathrm{expected\ records}}}
\]

Telemetry completeness measures whether operational decisions are based on sufficiently continuous data.

## Soil evidence quality

\[
Q_{\mathrm{soil\ evidence}} =
w_1R_{\mathrm{spatial}} +
w_2R_{\mathrm{depth}} +
w_3C_{\mathrm{cal}} +
w_4C_{\mathrm{telemetry}} +
w_5S_{\mathrm{lab}} +
w_6A_{\mathrm{remote}} +
w_7U_{\mathrm{uncertainty}} +
w_8D_{\mathrm{decision}}
\]
