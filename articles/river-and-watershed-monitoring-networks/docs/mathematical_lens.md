# Mathematical Lens

Watershed monitoring should be evaluated as a basin-scale evidence system, not only as a list of monitoring stations.

## Watershed network graph

\[
G = (V, E)
\]

A watershed can be represented as a graph of river reaches, tributaries, confluences, monitoring stations, reservoirs, and outlets.

## Instantaneous load

\[
L(t) = C(t)Q(t)
\]

Instantaneous load is concentration multiplied by discharge.

## Event load

\[
L_{\mathrm{event}} = \int_{t_0}^{t_1} C(t)Q(t)\,dt
\]

Event load estimates the total transported mass during a storm, pulse, flood, or management-relevant period.

## Coverage ratio

\[
C_{\mathrm{coverage}} = \frac{A_{\mathrm{monitored}}}{A_{\mathrm{basin}}}
\]

Coverage ratio estimates the fraction of basin area represented by monitoring nodes.

## Network readiness

\[
R_{\mathrm{network}} =
w_1C_{\mathrm{coverage}} +
w_2T_c +
w_3D_v +
w_4E_c +
w_5I_d +
w_6G_r
\]

Network readiness depends on coverage, temporal continuity, variable diversity, event capture, interoperability, and governance readiness.

## Watershed evidence quality

\[
Q_{\mathrm{watershed\ evidence}} =
w_1C_g +
w_2C_q +
w_3C_e +
w_4R_n +
w_5T_c +
w_6E_c +
w_7U_c +
w_8I_d +
w_9G_r
\]

Watershed evidence quality depends on gauge coverage, water-quality coverage, ecological coverage, network representativeness, temporal continuity, event capture, uncertainty communication, interoperability, and governance readiness.
