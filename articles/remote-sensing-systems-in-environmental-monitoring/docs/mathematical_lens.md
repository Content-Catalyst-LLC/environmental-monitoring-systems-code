# Mathematical Lens

Remote-sensing products should be evaluated as evidence chains, not only as images or maps.

## Spatial resolving power

\[
R_{\mathrm{spatial}} = \frac{1}{A_{\mathrm{pixel}}}
\]

Spatial resolving power increases as pixel area decreases, but finer pixels do not automatically create stronger environmental interpretation.

## Revisit rate

\[
R_{\mathrm{revisit}} = \frac{1}{\Delta t_{\mathrm{repeat}}}
\]

Revisit rate increases as repeat interval decreases. It should be matched to the speed of the monitored environmental process.

## Valid coverage

\[
C_{\mathrm{valid}} = \frac{A_{\mathrm{usable}}}{A_{\mathrm{target}}}
\]

Valid coverage measures the share of the target area usable after clouds, shadows, quality masks, missing data, or invalid retrievals are removed.

## Inference quality

\[
Q_{\mathrm{inference}} = w_1C_{\mathrm{correction}} + w_2V_{\mathrm{validation}} + w_3U_{\mathrm{characterized}} + w_4D_{\mathrm{domain}}
\]

Inference quality combines correction quality, validation strength, uncertainty characterization, and suitability for the environmental domain.

## Classification accuracy

\[
A_{\mathrm{classification}} = \frac{N_{\mathrm{correct\ reference\ labels}}}{N_{\mathrm{reference\ labels}}}
\]

Classification accuracy compares product labels with reference labels, but should be disaggregated by class, region, and condition when decisions depend on it.

## Remote-sensing evidence quality

\[
Q_{\mathrm{remote\ evidence}} = w_1C_{\mathrm{valid}} + w_2Q_{\mathrm{inference}} + w_3T_{\mathrm{continuity}} + w_4P_{\mathrm{proxy}} + w_5V_{\mathrm{field}}
\]

Remote-sensing evidence quality depends on valid coverage, inference quality, temporal continuity, proxy transparency, and field validation.
