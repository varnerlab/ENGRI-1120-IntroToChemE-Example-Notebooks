function evaluate(model::Dict{String,Any}; 
    tspan::Tuple{Float64,Float64} = (0.0, 20.0), Δt::Float64 = 0.01)

    # get stuff from model -
    xₒ = model["initial_condition_vector"]

    # build parameter vector -
    p = Array{Any,1}(undef,3)
    p[1] = model["S"]
    p[2] = model["k"]
    p[3] = model["number_of_dynamic_states"]

    # setup the solver -
    prob = ODEProblem(balances, xₒ, tspan, p; saveat = Δt)
    soln = solve(prob)

    # get the results from the solver -
    T = soln.t
    tmp = soln.u

    # build soln array -
    number_of_time_steps = length(T)
    number_of_dynamic_states = model["number_of_dynamic_states"]
    X = Array{Float64,2}(undef, number_of_time_steps,  number_of_dynamic_states);

    for i ∈ 1:number_of_time_steps
        soln_vector = tmp[i]
        for j ∈ 1:number_of_dynamic_states
            X[i,j] = soln_vector[j]
        end
    end

    # return -
    return (T,X)
end

function balances(dx,x,p,t)

    # grab parameters from the array -
    S = p[1]
    k = p[2]
    number_of_dynamic_states = p[3]    

    # compute the kinetics -
    rV = kinetics(x, S, k)

    # compute the rhs -> store in a temp vector
    tmp = S*rV

    # populate the dx vector with the tmp vector -
    for i ∈ 1:number_of_dynamic_states
        dx[i] = tmp[i]
    end
end

function kinetics(x, S, k)

    # initialize the rate array -
    rate_array = Array{Float64,1}(undef,1)
    rate_array[1] = k[1,1]*(x[1]^(-S[1,1]))*(x[2]^(-S[2,1])) - k[1,2]*(x[3]^(S[3,1]))

    # return -
    return rate_array
end