function compute_gibbs_excess_energy(x::Array{Float64,1}, Λ::Array{Float64,2}; 
    T::Float64 = 298.15, R::Float64 = 8.314)::Float64

    M = length(x)
    inner_terms = log.(Λ*x)
    gE = 0.0;
    for i ∈ 1:M
        gE = gE + x[i]*inner_terms[i]
    end

    # normalize and return -
    return -1*(gE/(R*T))
end

function γ₁(x::Array{Float64,1}, Λ::Array{Float64,2})::Float64

    # hard code for binary -
    x₁ = x[1]
    x₂ = x[2]

    tmp_vector = Λ*x

    N₁ = x₁*Λ[1,1]
    D₁ = tmp_vector[1]
    N₂ = x₂*Λ[2,1]
    D₂ = tmp_vector[2]

    # first summation term -
    term_1 = log(tmp_vector[1])
    term_2 = N₁/D₁ + N₂/D₂
    value = 1 - term_1 - term_2

    # return -
    return exp(value)
end

function γ₂(x::Array{Float64,1}, Λ::Array{Float64,2})::Float64

    # hard code for binary -
    x₁ = x[1]
    x₂ = x[2]

    tmp_vector = Λ*x

    N₁ = x₁*Λ[1,2]
    D₁ = tmp_vector[1]
    N₂ = x₂*Λ[2,2]
    D₂ = tmp_vector[2]

    # first summation term -
    term_1 = log(tmp_vector[2])
    term_2 = N₁/D₁ + N₂/D₂
    value = 1 - term_1 - term_2

    # return -
    return exp(value)
end