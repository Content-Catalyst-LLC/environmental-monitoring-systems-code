# Mathematical Lens

Environmental edge computing should be evaluated as an evidence architecture, not only as local performance optimization.

## End-to-end latency

\[
L_{\mathrm{end\ to\ end}} = t_{\mathrm{decision\ available}} - t_{\mathrm{phenomenon}}
\]

End-to-end latency measures how long it takes an environmental condition or event to become decision-ready evidence.

## Latency readiness

\[
L_{\mathrm{readiness}} = 1 - \min\left(\frac{L_{\mathrm{observed}}}{L_{\mathrm{target}}}, 1\right)
\]

Latency readiness is higher when observed latency remains below the target decision horizon.

## Bandwidth reduction

\[
B_{\mathrm{reduction}} = 1 - \frac{D_{\mathrm{transmitted}}}{D_{\mathrm{raw}}}
\]

Bandwidth reduction measures how much local filtering, compression, summarization, or event selection reduces transmission.

## Loss penalty

\[
D_{\mathrm{loss}} = \frac{D_{\mathrm{discarded\ without\ audit}}}{D_{\mathrm{raw}}}
\]

Loss penalty increases when raw data are discarded without audit sampling or retained context.

## Edge traceability

\[
R_{\mathrm{edge}} = \frac{N_{\mathrm{logged\ edge\ transformations}}}{N_{\mathrm{edge\ transformations}}}
\]

Edge traceability measures whether local filters, thresholds, model outputs, adaptive sampling changes, and local actions are logged.

## Retained context

\[
C_{\mathrm{retained}} = \frac{D_{\mathrm{raw\ or\ audit\ retained}}}{D_{\mathrm{raw}}}
\]

Retained context measures how much raw or audit-sample information remains available for validation, retraining, and later interpretation.

## Inference transparency

\[
P_{\mathrm{inference}} = \frac{N_{\mathrm{inferred\ outputs\ with\ confidence}}}{N_{\mathrm{inferred\ outputs}}}
\]

Inference transparency measures whether local classifications, anomaly labels, model outputs, and predictions include confidence, version, and evidence-status labels.

## Edge evidence quality

\[
Q_{\mathrm{edge\ evidence}} = w_1L_{\mathrm{readiness}} + w_2R_{\mathrm{edge}} + w_3C_{\mathrm{retained}} + w_4Q_{\mathrm{qc}} + w_5P_{\mathrm{inference}} + w_6F_{\mathrm{decision}} - w_7D_{\mathrm{loss}}
\]

Edge evidence quality depends on latency readiness, traceability, retained context, quality control, inference transparency, decision fit, and loss penalty.
