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
    ℳ = 1 # total mass

    # how many steps?
    ℒ = length(T)
    X = zeros(ℒ, ℳ)

    # setup the input and outputs -
    ṁ₁ = config["parameters"]["m_dot_in_1"]     # total mass flow rate stream 1 (units: kg/hr)
    ṁ₂ = config["parameters"]["m_dot_in_2"]     # total mass flow rate stream 2 (units: kg/hr)

    # κ value -
    κ = config["parameters"]["kappa"]

    # main loop -
    for t ∈ 1:(ℒ-1)

        # compute the mass out -
        ṁ₃ = κ * X[t, 1]

        # update the state array -
        X[t+1, 1] = X[t, 1] + h * (ṁ₁ + ṁ₂ - ṁ₃) + σ * sqrt(h) * rand(Z)
    end

    # return -
    return (T, X)
end

# load the configuration dictionary -
config = TOML.parsefile(joinpath(_PATH_TO_CONFIG, "Tank.toml"))

# execute me -
(T₁, X₁) = main(config; σ=0.0) # no noise