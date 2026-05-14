# Mathematical Lens

Disaster detection and early warning networks should be evaluated as end-to-end systems for creating actionable time.

## Usable lead time

\[
L_{\mathrm{usable}} = t_{\mathrm{impact}} - t_{\mathrm{actionable\ warning}}
\]

Usable lead time measures the time people and institutions actually have to act after receiving an actionable warning.

## Warning reach

\[
R_{\mathrm{reach}} = \frac{N_{\mathrm{reached}}}{N_{\mathrm{exposed}}}
\]

Warning reach measures the share of exposed people who received the warning through a usable channel.

## Protective action

\[
A_{\mathrm{protective}} = \frac{N_{\mathrm{acted}}}{N_{\mathrm{warned}}}
\]

Protective action rate measures how many warned recipients took the recommended action.

## False-alarm ratio

\[
FAR = \frac{N_{\mathrm{false\ alarms}}}{N_{\mathrm{warnings}}}
\]

False-alarm ratio measures the share of warnings not followed by the forecast event.

## Probability of detection

\[
POD = \frac{N_{\mathrm{hits}}}{N_{\mathrm{hits}} + N_{\mathrm{misses}}}
\]

Probability of detection measures how often actual events were successfully warned.

## Warning effectiveness

\[
S_{\mathrm{warning}} = w_1D + w_2L + w_3R + w_4T + w_5C + w_6A - w_7M
\]

Warning effectiveness combines detection confidence, lead time, reach, trust, response capacity, protective action, and missed-event penalty.
