# Mathematical Lens

Environmental IoT architecture can be evaluated as a chain of evidence rather than merely as a connectivity system.

## Device availability

\[
A_{\mathrm{device}} = \frac{T_{\mathrm{valid\ operation}}}{T_{\mathrm{deployment}}}
\]

## Delivery completeness

\[
C_{\mathrm{delivery}} = \frac{N_{\mathrm{delivered\ records}}}{N_{\mathrm{expected\ records}}}
\]

## Semantic completeness

\[
S_{\mathrm{semantic}} = \frac{N_{\mathrm{records\ with\ required\ semantics}}}{N_{\mathrm{records}}}
\]

## Edge traceability

\[
R_{\mathrm{edge}} = \frac{N_{\mathrm{logged\ edge\ transformations}}}{N_{\mathrm{edge\ transformations}}}
\]

## End-to-end latency

\[
L_{\mathrm{end\ to\ end}} = t_{\mathrm{decision\ available}} - t_{\mathrm{phenomenon}}
\]

## IoT evidence quality

\[
Q_{\mathrm{iot\ evidence}} = w_1A_{\mathrm{device}} + w_2C_{\mathrm{delivery}} + w_3S_{\mathrm{semantic}} + w_4Q_{\mathrm{qc}} + w_5R_{\mathrm{edge}} + w_6F_{\mathrm{decision}} - w_7L_{\mathrm{penalty}}
\]
