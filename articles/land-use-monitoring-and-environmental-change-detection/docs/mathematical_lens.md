# Mathematical Lens

Land-use monitoring should be evaluated as an evidence system, not only as a map product.

## Overall accuracy

\[
A_{\mathrm{overall}} = \frac{N_{\mathrm{correctly\ classified}}}{N_{\mathrm{reference\ samples}}}
\]

Overall accuracy measures the share of reference samples classified correctly, but it should be interpreted alongside class-specific accuracy and sampling design.

## Change confidence

\[
C_{\mathrm{change}} = \frac{N_{\mathrm{validated\ change\ samples}}}{N_{\mathrm{detected\ change\ samples}}}
\]

Change confidence increases when detected change is supported by reference data, persistence logic, or independent evidence.

## Persistence ratio

\[
R_{\mathrm{persistence}} = \frac{N_{\mathrm{persistent\ change\ observations}}}{N_{\mathrm{change\ observations}}}
\]

Persistence ratio helps distinguish durable land transformation from seasonal variation, temporary disturbance, or classification noise.

## Edge density

\[
F_{\mathrm{edge}} = \frac{L_{\mathrm{class\ boundary}}}{A_{\mathrm{class}}}
\]

Edge density is a simplified fragmentation indicator, showing boundary length relative to class area.

## Area-estimation error

\[
E_{\mathrm{area}} = \left|A_{\mathrm{map}} - A_{\mathrm{adjusted}}\right|
\]

Area-estimation error compares raw mapped area with accuracy-adjusted area.

## Land evidence quality

\[
Q_{\mathrm{land\ evidence}} = w_1A_c + w_2T_c + w_3P_{\mathrm{change}} + w_4V_r + w_5S_{\mathrm{condition}} + w_6F_{\mathrm{fragmentation}} + w_7U_c + w_8R_g
\]

Land evidence quality depends on classification accuracy, temporal consistency, validated change logic, reference data, condition sensitivity, fragmentation visibility, uncertainty communication, and governance readiness.
