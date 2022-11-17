function objective_function(ϵ,parameters)

	# get data from the parameters -
	G_formation_array = parameters["G_formation_array"]
	S = parameters["S"]
	n_initial_array = parameters["n_initial_array"]
	RT = R*T

	# compute the ΔG/RT terms -
	ΔG_terms = (1/RT)*transpose(S)*G_formation_array
	term_1 = sum(ΔG_terms.*ϵ)
	
	# compute mols -
	tmp = n_initial_array + S*ϵ
	n_array = max.(0.0,tmp) # hack: if we have a mol count less than 0, correct -
	n_total = sum(n_array)
	x_array = (1/n_total)*n_array	
	activity_terms = log.(x_array)
	term_2 = sum(n_array.*activity_terms)

	# penalty terms -
	penalty_terms_array = Array{Float64,1}()
	for species_index = 1:ℳ
		penalty_term = max(0,-1*tmp[species_index])^2
		push!(penalty_terms_array, penalty_term)
	end
	
	# return -
	return (term_1 + term_2)
end