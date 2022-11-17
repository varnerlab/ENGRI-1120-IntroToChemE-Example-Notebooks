function objective_function(epsilon,parameters)
	
	# get stuff from the parameters dict -
	initial_mol_array = parameters["initial_mol_array"]
	G_formation_array = parameters["G_formation_array"]
	S = parameters["stoichiometric_array"]
	
	# what extent are we looking at?
	ϵ = sum(initial_mol_array)*epsilon[1]
	RT = R*T
	
	# compute the ΔG/RT term -
	ΔG_initial_term = ((1/(RT))*sum(S.*G_formation_array))*ϵ
	
	# compute the current number of mols -
	n_array = initial_mol_array + S*ϵ
	
	# compute the mol total -
	n_total = sum(n_array)
	
	# compute the mol fractions for each component -
	ln_x_array = log.((1/n_total)*n_array)
	
	# compute the second "reaction" term -
	reaction_term = sum(n_array.*ln_x_array)
	
	# put all together -
	energy_total = ΔG_initial_term + reaction_term
	
	# return -
	return energy_total
end