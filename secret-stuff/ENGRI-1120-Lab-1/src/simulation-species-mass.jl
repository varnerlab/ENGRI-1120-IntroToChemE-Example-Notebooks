# setup my environment -
include("../Include.jl")

function main(config::Dict{String,Any}; σ::Float64=0.0)

    # setup:
    # we have a mixing process
    # two streams in (A, B), one stream out (A+B)

    # setup the simulation parameters -
    T₀ = config["simulation"]["T1"]              # initial time
    T₁ = config["simulation"]["T2"]              # final time (units: hr)
    h = config["simulation"]["h"]                # timestep units: hr (equiv to 1 min)
    T = range(T₀, stop=T₁, step=h) |> collect    # simulation time range
    Z = Normal(0.0, 1.0)

    # how many states?
    ℳ = config["parameters"]["M"]

    # how many steps?
    ℒ = length(T)
    X = zeros(ℒ, ℳ)

    # setup the input and outputs -
    ṁ₁ = config["parameters"]["m_dot_in_1"]     # total mass flow rate stream 1 (units: kg/hr)
    ṁ₂ = config["parameters"]["m_dot_in_2"]     # total mass flow rate stream 2 (units: kg/hr)

    # mass fractions for the input streams 
    w_in_1 = config["parameters"]["w_in_1"]     # stream 1
    w_in_2 = config["parameters"]["w_in_2"]     # stream 2

    # κ value -
    κ = config["parameters"]["kappa"]

    # main loop -
    for t ∈ 1:(ℒ-1)
        for state = 1:ℳ

            # compute ṁ₃ -
            ṁ₃_i = κ * X[t, state]

            # update the state array -
            X[t+1, state] = X[t, state] + h * (ṁ₁ * w_in_1[state] + ṁ₂ * w_in_2[state] - ṁ₃_i) + σ * sqrt(h) * rand(Z)
        end
    end

    # return -
    return (T, X)
end

# load the configuration dictionary -
config = TOML.parsefile(joinpath(_PATH_TO_CONFIG, "Tank.toml"))

# execute me -
(T₁, X₁) = main(config; σ=0.0) # no noise
(T₂, X₂) = main(config; σ=0.5) # w/noise

# dump raw simulation data to disk as jld2 file -
filename = "RAW-Simulation-Species-Mass-Mixing-Tank.jld2"
dd = Dict("T1" => T₁, "X1" => X₁, "T2" => T₂, "X2" => X₂)
save(joinpath(_PATH_TO_DATA, filename), dd)
