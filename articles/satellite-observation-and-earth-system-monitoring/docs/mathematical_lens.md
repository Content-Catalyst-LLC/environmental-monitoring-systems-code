# Mathematical Lens

Satellite observation products should be evaluated as evidence chains, not only as imagery or maps.

## Revisit rate

\[
R_{\mathrm{revisit}} = \frac{1}{\Delta t_{\mathrm{repeat}}}
\]

Revisit rate increases as the repeat interval decreases.

## Usable coverage

\[
C_{\mathrm{usable}} = \frac{A_{\mathrm{clear\ or\ valid}}}{A_{\mathrm{target}}}
\]

Usable coverage measures the share of the target area observed under conditions suitable for the product.

## Retrieval quality

\[
Q_{\mathrm{retrieval}} = w_1C_{\mathrm{calibration}} + w_2V_{\mathrm{validation}} + w_3U_{\mathrm{characterized}} + w_4D_{\mathrm{domain}}
\]

Retrieval quality combines calibration, validation, uncertainty characterization, and domain suitability.

## Continuity strength

\[
K_{\mathrm{continuity}} = \frac{N_{\mathrm{documented\ transitions}}}{N_{\mathrm{mission\ or\ algorithm\ transitions}}}
\]

Continuity strength measures how many mission or algorithm transitions have documented overlap, cross-calibration, or reprocessing support.

## Proxy transparency

\[
P_{\mathrm{proxy}} = \frac{N_{\mathrm{proxy\ products\ labeled}}}{N_{\mathrm{retrieved\ or\ inferred\ products}}}
\]

Proxy transparency measures whether retrieved, classified, modeled, or inferred products are clearly distinguished from direct observations.

## Satellite evidence quality

\[
Q_{\mathrm{satellite\ evidence}} = w_1C_{\mathrm{usable}} + w_2Q_{\mathrm{retrieval}} + w_3K_{\mathrm{continuity}} + w_4P_{\mathrm{proxy}} + w_5V_{\mathrm{in situ}}
\]

Satellite evidence quality can be approximated as a function of usable coverage, retrieval quality, continuity, proxy transparency, and in situ validation.
