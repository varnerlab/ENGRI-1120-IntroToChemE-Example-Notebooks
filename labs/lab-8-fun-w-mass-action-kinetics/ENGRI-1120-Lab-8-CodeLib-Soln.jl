function kinetics(x,k)::Float64
    
    # initialize -
    r̂₁ = 0.0;

    # alias the species
    A = x[1]
    B = x[2]
    C = x[3]

    # logic for the kinetics -
    # reaction: 2A + B --> C (irreversible)
    r̂₁ = k*(A^2)*(B)

    # retrurn -
    return r̂₁
end


function balances(dx, x, p, t)

    # grab data from the parameter vector 
    S = p[1];   # stoichiometric matrix
    D = p[2];   # dilution vector
    k = p[3];   # kinetic rate constant
    CM = p[4];  # concentration matrix for the feed streams
    number_of_dynamic_states = p[5];

    # compute the kinetics - powerlaw
    rV = kinetics(x,k);

    # compute the rhs -> store in a temp vector
    tmp = CM*D + S*rV - D[3]*x 

    # populate the dx vector with the tmp vector -
    for i ∈ 1:number_of_dynamic_states
        dx[i] = tmp[i]
    end
end

function evaluate(model::Dict{String,Any}; 
    tspan::Tuple{Float64,Float64} = (0.0,20.0), Δt::Float64 = 0.01)

    # get stuff from model -
    xₒ = model["initial_condition_array"]
    number_of_dynamic_states = model["number_of_dynamic_states"]

    # build parameter vector -
    p = Array{Any,1}(undef,5)
    p[1] = model["S"]
    p[2] = model["D"]
    p[3] = model["k"]
    p[4] = model["CM"]
    p[5] =  number_of_dynamic_states;

    # setup the solver -
    prob = ODEProblem(balances, xₒ, tspan, p; saveat = Δt)
    soln = solve(prob)

    # get the results from the solver -
    T = soln.t
    tmp = soln.u

    # build soln array -
    number_of_time_steps = length(T)
    X = Array{Float64,2}(undef, number_of_time_steps,  number_of_dynamic_states);

    for i ∈ 1:number_of_time_steps
        soln_vector = tmp[i]
        for j ∈ 1:number_of_dynamic_states
            X[i,j] = soln_vector[j]
        end
    end

    # return -
    return (T,X, tmp)
end


function objfunc(x::Array{Float64,1}, model::Dict{String, Any})::Float64

    # get some stuff from the model -
    SM = model["S"]
    DV = model["D"]
    CM = model["CM"]
    k = model["k"];

    # compute the rate vector -
    r_vector = kinetics(x,k)

    # compute error vector -
    ϵ  = CM*DV + SM*r_vector - DV[3]*x

    # return -
    return transpose(ϵ)*ϵ;
end