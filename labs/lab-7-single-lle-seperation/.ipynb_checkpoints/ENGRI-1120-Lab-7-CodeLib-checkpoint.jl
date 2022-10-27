function compute_gibbs_excess_energy(x::Array{Float64,1}, Λ::Array{Float64,2}; 
    temperature::Float64 = 298.15, R::Float64 = 8.314)::Float64

    M = length(composition)
    inner_terms = ln.(Λ*x)
    gE = 0.0;
    for i ∈ 1:M
        gE = gE + x[i]*inner_terms[i]
    end

    # normalize and return -
    return -1*(gE/(R*T))
end
