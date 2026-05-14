# Mathematical Lens

Future environmental monitoring systems should be evaluated through evidence quality rather than data volume alone.

## Coverage

\[
C_{\mathrm{coverage}} = \frac{A_{\mathrm{observed}}}{A_{\mathrm{target}}}
\]

Coverage measures the share of the target area that is meaningfully observed.

## Freshness

\[
F_{\mathrm{freshness}} = t_{\mathrm{now}} - t_{\mathrm{latest}}
\]

Freshness measures how old the latest usable observation is.

## Interoperability

\[
I_{\mathrm{interop}} = \frac{N_{\mathrm{standardized}}}{N_{\mathrm{total}}}
\]

Interoperability measures the share of data sources that conform to documented formats, metadata rules, APIs, and semantic mappings.

## Provenance

\[
P_{\mathrm{provenance}} = \frac{R_{\mathrm{traceable}}}{R_{\mathrm{total}}}
\]

Provenance completeness measures whether outputs can be traced back to source observations, transformations, versions, and processing steps.

## Decision usefulness

\[
S_{\mathrm{usefulness}} = w_1Q + w_2C + w_3F + w_4I + w_5P + w_6G - w_7U
\]

Decision usefulness combines quality, coverage, freshness, interoperability, provenance, governance, and uncertainty.
