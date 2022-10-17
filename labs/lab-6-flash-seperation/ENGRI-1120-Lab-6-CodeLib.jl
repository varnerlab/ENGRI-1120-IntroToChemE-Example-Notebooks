mutable struct ChemicalCompoundModel

	# data -
	name::String
	formula::String
	A::Float64
	B::Float64
	C::Float64
	ΔH_vap::Float64
	boiling_point::Float64

	# constructor -
	ChemicalCompoundModel() = new()
end

function build_compound_dictionary(data::DataFrame)::Dict{String,ChemicalCompoundModel}

	# initialize -
	compound_dictionary = Dict{String,ChemicalCompoundModel}()

	# how many rows do we have in the compound dictionary?
	(number_of_rows, number_of_cols) = size(data)

	# process each row in the data -
	for i ∈ 1:number_of_rows

		# build a compound model -
		model = ChemicalCompoundModel()

		# grab the name -
		name = data[i,:Name]
		
		model.name = name
		model.formula = data[i,:Formula]
		model.A = data[i,:A]
		model.B = data[i,:B]
		model.C = data[i,:C]
		model.ΔH_vap = data[i,:DH_vap]
		model.boiling_point = data[i, :boiling_point_C]

		# cache -
		compound_dictionary[name] = model
	end

	# return -
	return compound_dictionary
end

function saturation_pressure(compound::String, data_dictionary::Dict{String,ChemicalCompoundModel},
	T::Float64)::Float64

	# use Antoine's equation to estimate saturation pressure

	# initialize -
	sat_pressure::Float64 = 0.0

	# look up the model, and get parameters -
	model = data_dictionary[compound]
	A = model.A
	B = model.B
	C = model.C

	# compute -
	sat_pressure = exp(A - B/(T+C))
	
	# return -
	return sat_pressure
end
