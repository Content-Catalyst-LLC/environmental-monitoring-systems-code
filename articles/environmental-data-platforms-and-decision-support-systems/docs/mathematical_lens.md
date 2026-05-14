# Mathematical Lens

Environmental data platforms should be evaluated as evidence systems, not only as storage or access systems.

## Metadata completeness

\[
M_{\mathrm{complete}} = \frac{N_{\mathrm{required\ metadata\ fields\ complete}}}{N_{\mathrm{required\ metadata\ fields}}}
\]

Metadata completeness measures whether datasets carry the source, method, unit, time, space, provenance, and uncertainty information needed for reuse.

## Semantic compatibility

\[
C_{\mathrm{semantic}} = \frac{N_{\mathrm{semantically\ compatible\ fields}}}{N_{\mathrm{mapped\ fields}}}
\]

Semantic compatibility measures how many mapped variables can be compared without definition, unit, temporal, or spatial conflict.

## Lineage completeness

\[
P_{\mathrm{lineage}} = \frac{N_{\mathrm{traceable\ outputs}}}{N_{\mathrm{platform\ outputs}}}
\]

Lineage completeness measures whether indicators, models, dashboards, and reports can be traced back to source data and transformations.

## Uncertainty visibility

\[
U_{\mathrm{visibility}} = \frac{N_{\mathrm{uncertainty\ labeled}}}{N_{\mathrm{modeled\ estimated\ or\ scenario\ outputs}}}
\]

Uncertainty visibility measures whether modeled, estimated, interpolated, forecast, or scenario-based outputs are clearly labeled for users.

## Decision fit

\[
F_{\mathrm{decision}} = \frac{N_{\mathrm{decision\ questions\ supported}}}{N_{\mathrm{priority\ decision\ questions}}}
\]

Decision fit measures whether the platform actually supports the priority questions users need to answer.

## Platform evidence quality

\[
Q_{\mathrm{platform}} = w_1M_{\mathrm{complete}} + w_2C_{\mathrm{semantic}} + w_3P_{\mathrm{lineage}} + w_4U_{\mathrm{visibility}} + w_5F_{\mathrm{decision}}
\]

Overall platform evidence quality can be approximated as a weighted combination of metadata completeness, semantic compatibility, lineage, uncertainty visibility, and decision fit.
