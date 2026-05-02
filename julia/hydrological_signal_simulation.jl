# Hydrological Signal Simulation
# ------------------------------
# Simple synthetic hydrograph-style signal for monitoring examples.

using Random
using Statistics

Random.seed!(42)

n = 100
time = collect(1:n)
base_flow = 20 .+ 2 .* sin.(2π .* time ./ 30)
storm_pulse = [t > 45 && t < 60 ? 15 * exp(-0.15 * (t - 45)) : 0 for t in time]
noise = randn(n)

flow = base_flow .+ storm_pulse .+ noise

println("Mean flow: ", mean(flow))
println("Maximum flow: ", maximum(flow))
