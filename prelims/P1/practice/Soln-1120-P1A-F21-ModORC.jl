### A Pluto.jl notebook ###
# v0.19.12

using Markdown
using InteractiveUtils

# ╔═╡ 2b00f9f2-53f3-4525-a3e4-708109259b6c
# Julia environment -
begin
	using PlutoUI
	using PrettyTables
end

# ╔═╡ c7822c42-2f57-11ec-3b48-2b2ea80c6f23
md"""$(PlutoUI.LocalResource("./figs/Fig-ModRankine-Heat-Recycle-F20.png"))
__Fig 1.__ Schematic of the unit operations of a modified organic Rankine cycle in which α percent of the heat from the condenser is recycled to the boiler through a heat exchanger."""

# ╔═╡ 796a9adb-7573-4ec1-881f-ab39d98032ae
md"""
The Organic Rankine Cycle (ORC) is an _open_ four step thermodynamic process used to generate power that uses organic compounds as working fluids (Fig. 1). In the cycle, path $\mathcal{P}_{ij}$ connects operating point $\mathcal{O}_{i}$ to $\mathcal{O}_{j}$:


* Path $\mathcal{P}_{12}$: $\left(1~\rightarrow~2\right)$: _isobaric_ heating in a boiler from operating point $\mathcal{O}_{1}$ to $\mathcal{O}_{2}$
* Path $\mathcal{P}_{23}$: $\left(2~\rightarrow~3\right)$: _adiabatic_ expansion in a turbine from operating point $\mathcal{O}_{2}$ to $\mathcal{O}_{3}$
* Path $\mathcal{P}_{34}$: $\left(3~\rightarrow~4\right)$: _isobaric_ cooling in a condenser from operating point $\mathcal{O}_{3}$ to $\mathcal{O}_{4}$
* Path $\mathcal{P}_{41}$: $\left(4~\rightarrow~1\right)$: _adiabatic_ compression in a pump from operating point $\mathcal{O}_{4}$ to $\mathcal{O}_{1}$


"""

# ╔═╡ d65087c7-1b55-4aeb-bda6-fd4039b64863
md"""

__Assumptions:__

* (i) the cycle operates at steady-state; 
* (ii) the working fluid R-508B (Suva 95) has a mass flow rate of $\dot{m}$ = 1.25 kg s$^{-1}$;
* (iii) the turbine efficiency is $\eta_{T}$ = 70\%; 
* (iv) _neglect_ the enthalpy and temperature change from the pump (assume T$_{4}\simeq$~T$_{1}$ and H$_{4}\simeq$~H$_{1}$);
* (v) neglect changes in the kinetic and potential energy in the system and streams.
    
"""

# ╔═╡ 1d0dbac8-8a12-4ba0-862b-e7a2860e2b6e
md"""
###### Example State Table for the Mod Rankine Problem
You get the $H$, $S$, $T$ and $P$ values from the problem statement, and from the working fluid PH-diagram (or data sheets). When completing the state table, always assume _unless explicitly asked otherwise_ reversibility for turbine.
"""

# ╔═╡ f561e6bd-63d0-43db-9bcb-5135afdfe7d4
begin

# 	# Version: δ
# 	# setup the state table -
# 	state_table_data_array = zeros(4,5)
	
# 	# setup each row -
# 	# row 1:
# 	state_table_data_array[1,1] = -100.0
# 	state_table_data_array[1,2] = 2200.0
# 	state_table_data_array[1,3] = 78.1
# 	state_table_data_array[1,4] = 0.4716
# 	state_table_data_array[1,5] = 0.0
	
# 	# row 2:
# 	state_table_data_array[2,1] = 20.0
# 	state_table_data_array[2,2] = 2200.0
# 	state_table_data_array[2,3] = 307.2
# 	state_table_data_array[2,4] = 1.4038
# 	state_table_data_array[2,5] = 1.0
	
# 	# row 3:
# 	state_table_data_array[3,1] = -100.0
# 	state_table_data_array[3,2] = 48.0
# 	state_table_data_array[3,3] = 240.3
# 	state_table_data_array[3,4] = 1.4038
# 	state_table_data_array[3,5] = 0.97
	
# 	# row 4:
# 	state_table_data_array[4,1] = -100.0
# 	state_table_data_array[4,2] = 48.0
# 	state_table_data_array[4,3] = 78.1
# 	state_table_data_array[4,4] = 0.4716
# 	state_table_data_array[4,5] = 0.0
	
	# show -
	nothing 
end

# ╔═╡ 2cef6853-6624-428a-81c4-4e8fdb8727f7
begin
	
	# Version: γ (don't forget to change mdot, ηₜ and α)
	
	# setup the state table -
	state_table_data_array = zeros(4,5)
	
	# setup each row -
	# row 1:
	state_table_data_array[1,1] = -90.0
	state_table_data_array[1,2] = 2200.0
	state_table_data_array[1,3] = 86.8
	state_table_data_array[1,4] = 0.5184
	state_table_data_array[1,5] = 0.0
	
	# row 2:
	state_table_data_array[2,1] = 20.0
	state_table_data_array[2,2] = 2200.0
	state_table_data_array[2,3] = 307.2
	state_table_data_array[2,4] = 1.4038
	state_table_data_array[2,5] = 1.0
	
	# row 3:
	state_table_data_array[3,1] = -90.0
	state_table_data_array[3,2] = 90.0
	state_table_data_array[3,3] = 249.
	state_table_data_array[3,4] = 1.4038
	state_table_data_array[3,5] = 0.99
	
	# row 4:
	state_table_data_array[4,1] = -90.0
	state_table_data_array[4,2] = 90.0
	state_table_data_array[4,3] = 86.8
	state_table_data_array[4,4] = 0.5184
	state_table_data_array[4,5] = 0.0
	
	# show -
	nothing 
end

# ╔═╡ 50bcce4a-981b-4b70-9fa6-98ad9f7b39e4
with_terminal() do
	
	# header row -
	state_table_header_row = (["T","P","H","S","θ"],["°C","kPa","kJ/kg","kJ/kg-K","dimensionless"]);

	# write the table -
	pretty_table(state_table_data_array; header=state_table_header_row)
end

# ╔═╡ d2bd39f1-8d81-404d-bea6-70ea8e19cea1
# do this computation in matrix - vector form
begin

	# setup process connectivity array A - change for γ and δ
	m_dot = 1.5 	# units: kg/s
	ηₜ = 0.75 		# units: dimensionless
	A = [-m_dot m_dot 0; 0 -m_dot m_dot ; m_dot 0 -m_dot];
	
	# get the H's
	H₁ = state_table_data_array[1,3] # units: kJ/kg
	H₂ = state_table_data_array[2,3] # units: kJ/kg
	H₃ = state_table_data_array[3,3] # units: kJ/kg
	H₄ = state_table_data_array[4,3] # units: kJ/kg
	H_vec = [H₁ ; H₂ ; H₃]; 
	
	# compute the RHS -
	bV = A*H_vec	
end

# ╔═╡ 37101508-f1a7-42ed-b446-a9b21001c7b0
with_terminal() do
	
	# path table -
	path_table_data_array = zeros(5,3)
	
	# values -
	# row 1:
	path_table_data_array[1,1] = bV[1]
	path_table_data_array[1,2] = 0.0
	path_table_data_array[1,3] = 0.0
	
	# row 2:
	path_table_data_array[2,1] = 0.0
	path_table_data_array[2,2] = bV[2]
	path_table_data_array[2,3] = (ηₜ)*bV[2]
	
	# row 3:
	path_table_data_array[3,1] = bV[3]
	path_table_data_array[3,2] = 0.0
	path_table_data_array[3,3] = 0.0
	
	# row 4:
	path_table_data_array[4,1] = 0.0
	path_table_data_array[4,2] = 0.0
	path_table_data_array[4,3] = 0.0
	
	# row 5:
	path_table_data_array[5,1] = bV[1]+bV[3]
	path_table_data_array[5,2] = bV[2]
	path_table_data_array[5,3] = 0.0
	
	# header row -
	path_table_header_row = (["Qdot","Wdot (ideal)","Wdot (actual)"],["kJ/s","kJ/s","kJ/s"]);

	# write the table -
	pretty_table(path_table_data_array; header=path_table_header_row)
end

# ╔═╡ eab84d4f-1a60-478e-9d3e-92d1b466e142
md"""
###### Efficiency w/no heat recycle
"""

# ╔═╡ c6eca5d9-48b9-48bf-9bfa-de7359549e00
eff_no_recyle = -1*(bV[2])/(bV[1])

# ╔═╡ b7153ddf-b153-4b9c-9fea-aab1fe30471d
md"""
###### Efficiency w/heat recycle
"""

# ╔═╡ ac0f2a28-a8aa-4031-b69c-71e8f6047574
begin
	
	# what is the fraction of heat that we are going to recycle?
	α = 0.10
	
	# What is the amount of recycled heat -
	Q_dot_recycled = α*abs(bV[3])
	
	# what is the new amount of heat put into the boiler?
	Q_dot_new = bV[1] - Q_dot_recycled
	
	# compute new efficiency -
	eff_recyle = -1*(bV[2])/(Q_dot_new)
end

# ╔═╡ 15dbf654-25cc-43e5-8526-d3e62ca3271a
html"""
<style>
main {
    max-width: 1200px;
    width: 95%;
    margin: auto;
    font-family: "Roboto, monospace";
}

a {
    color: blue;
    text-decoration: none;
}

.H1 {
    padding: 0px 30px;
}
</style>"""

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
PrettyTables = "08abe8d2-0d0c-5749-adfa-8a2ac140af0d"

[compat]
PlutoUI = "~0.7.43"
PrettyTables = "~2.1.1"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

[[AbstractPlutoDingetjes]]
deps = ["Pkg"]
git-tree-sha1 = "8eaf9f1b4921132a4cff3f36a1d9ba923b14a481"
uuid = "6e696c72-6542-2067-7265-42206c756150"
version = "1.1.4"

[[ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"
version = "1.1.1"

[[Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"

[[Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"

[[ColorTypes]]
deps = ["FixedPointNumbers", "Random"]
git-tree-sha1 = "eb7f0f8307f71fac7c606984ea5fb2817275d6e4"
uuid = "3da002f7-5984-5a60-b8a6-cbb66c0b333f"
version = "0.11.4"

[[CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"
version = "0.5.2+0"

[[Crayons]]
git-tree-sha1 = "249fe38abf76d48563e2f4556bebd215aa317e15"
uuid = "a8cc5b0e-0ffa-5ad4-8c14-923d3ee1735f"
version = "4.1.1"

[[DataAPI]]
git-tree-sha1 = "1106fa7e1256b402a86a8e7b15c00c85036fef49"
uuid = "9a962f9c-6df0-11e9-0e5d-c546b8b5ee8a"
version = "1.11.0"

[[DataValueInterfaces]]
git-tree-sha1 = "bfc1187b79289637fa0ef6d4436ebdfe6905cbd6"
uuid = "e2d170a0-9d28-54be-80f0-106bbe20a464"
version = "1.0.0"

[[Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"

[[Downloads]]
deps = ["ArgTools", "FileWatching", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"
version = "1.6.0"

[[FileWatching]]
uuid = "7b1f6079-737a-58dc-b8bc-7a2ca5c1b5ee"

[[FixedPointNumbers]]
deps = ["Statistics"]
git-tree-sha1 = "335bfdceacc84c5cdf16aadc768aa5ddfc5383cc"
uuid = "53c48c17-4a7d-5ca2-90c5-79b7896eea93"
version = "0.8.4"

[[Formatting]]
deps = ["Printf"]
git-tree-sha1 = "8339d61043228fdd3eb658d86c926cb282ae72a8"
uuid = "59287772-0a20-5a39-b81b-1366585eb4c0"
version = "0.4.2"

[[Hyperscript]]
deps = ["Test"]
git-tree-sha1 = "8d511d5b81240fc8e6802386302675bdf47737b9"
uuid = "47d2ed2b-36de-50cf-bf87-49c2cf4b8b91"
version = "0.0.4"

[[HypertextLiteral]]
deps = ["Tricks"]
git-tree-sha1 = "c47c5fa4c5308f27ccaac35504858d8914e102f9"
uuid = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"
version = "0.9.4"

[[IOCapture]]
deps = ["Logging", "Random"]
git-tree-sha1 = "f7be53659ab06ddc986428d3a9dcc95f6fa6705a"
uuid = "b5f81e59-6552-4d32-b1f0-c071b021bf89"
version = "0.2.2"

[[InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"

[[IteratorInterfaceExtensions]]
git-tree-sha1 = "a3f24677c21f5bbe9d2a714f95dcd58337fb2856"
uuid = "82899510-4779-5014-852e-03e436cf321d"
version = "1.0.0"

[[JSON]]
deps = ["Dates", "Mmap", "Parsers", "Unicode"]
git-tree-sha1 = "3c837543ddb02250ef42f4738347454f95079d4e"
uuid = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
version = "0.21.3"

[[LibCURL]]
deps = ["LibCURL_jll", "MozillaCACerts_jll"]
uuid = "b27032c2-a3e7-50c8-80cd-2d36dbcbfd21"
version = "0.6.3"

[[LibCURL_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "MbedTLS_jll", "Zlib_jll", "nghttp2_jll"]
uuid = "deac9b47-8bc7-5906-a0fe-35ac56dc84c0"
version = "7.84.0+0"

[[LibGit2]]
deps = ["Base64", "NetworkOptions", "Printf", "SHA"]
uuid = "76f85450-5226-5b5a-8eaa-529ad045b433"

[[LibSSH2_jll]]
deps = ["Artifacts", "Libdl", "MbedTLS_jll"]
uuid = "29816b5a-b9ab-546f-933c-edad1886dfa8"
version = "1.10.2+0"

[[Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"

[[LinearAlgebra]]
deps = ["Libdl", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"

[[Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"

[[Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"

[[MbedTLS_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "c8ffd9c3-330d-5841-b78e-0817d7145fa1"
version = "2.28.0+0"

[[Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"

[[MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"
version = "2022.2.1"

[[NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"
version = "1.2.0"

[[OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"
version = "0.3.20+0"

[[OrderedCollections]]
git-tree-sha1 = "85f8e6578bf1f9ee0d11e7bb1b1456435479d47c"
uuid = "bac558e1-5e72-5ebc-8fee-abe8a469f55d"
version = "1.4.1"

[[Parsers]]
deps = ["Dates"]
git-tree-sha1 = "3d5bf43e3e8b412656404ed9466f1dcbf7c50269"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.4.0"

[[Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "REPL", "Random", "SHA", "Serialization", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"
version = "1.8.0"

[[PlutoUI]]
deps = ["AbstractPlutoDingetjes", "Base64", "ColorTypes", "Dates", "Hyperscript", "HypertextLiteral", "IOCapture", "InteractiveUtils", "JSON", "Logging", "Markdown", "Random", "Reexport", "UUIDs"]
git-tree-sha1 = "2777a5c2c91b3145f5aa75b61bb4c2eb38797136"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.43"

[[PrettyTables]]
deps = ["Crayons", "Formatting", "Markdown", "Reexport", "StringManipulation", "Tables"]
git-tree-sha1 = "9be26cbb85be86e293e2f65404139102c5c652d9"
uuid = "08abe8d2-0d0c-5749-adfa-8a2ac140af0d"
version = "2.1.1"

[[Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"

[[REPL]]
deps = ["InteractiveUtils", "Markdown", "Sockets", "Unicode"]
uuid = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"

[[Random]]
deps = ["SHA", "Serialization"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[[Reexport]]
git-tree-sha1 = "45e428421666073eab6f2da5c9d310d99bb12f9b"
uuid = "189a3867-3050-52da-a836-e630ba90ab69"
version = "1.2.2"

[[SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"
version = "0.7.0"

[[Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"

[[Sockets]]
uuid = "6462fe0b-24de-5631-8697-dd941f90decc"

[[SparseArrays]]
deps = ["LinearAlgebra", "Random"]
uuid = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"

[[Statistics]]
deps = ["LinearAlgebra", "SparseArrays"]
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"

[[StringManipulation]]
git-tree-sha1 = "46da2434b41f41ac3594ee9816ce5541c6096123"
uuid = "892a3eda-7b42-436c-8928-eab12a02cf0e"
version = "0.3.0"

[[TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"
version = "1.0.0"

[[TableTraits]]
deps = ["IteratorInterfaceExtensions"]
git-tree-sha1 = "c06b2f539df1c6efa794486abfb6ed2022561a39"
uuid = "3783bdb8-4a98-5b6b-af9a-565f29a5fe9c"
version = "1.0.1"

[[Tables]]
deps = ["DataAPI", "DataValueInterfaces", "IteratorInterfaceExtensions", "LinearAlgebra", "OrderedCollections", "TableTraits", "Test"]
git-tree-sha1 = "2d7164f7b8a066bcfa6224e67736ce0eb54aef5b"
uuid = "bd369af6-aec1-5ad0-b16a-f7cc5008161c"
version = "1.9.0"

[[Tar]]
deps = ["ArgTools", "SHA"]
uuid = "a4e569a6-e804-4fa4-b0f3-eef7a1d5b13e"
version = "1.10.0"

[[Test]]
deps = ["InteractiveUtils", "Logging", "Random", "Serialization"]
uuid = "8dfed614-e22c-5e08-85e1-65c5234f0b40"

[[Tricks]]
git-tree-sha1 = "6bac775f2d42a611cdfcd1fb217ee719630c4175"
uuid = "410a4b4d-49e4-4fbc-ab6d-cb71b17b3775"
version = "0.1.6"

[[UUIDs]]
deps = ["Random", "SHA"]
uuid = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"

[[Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"

[[Zlib_jll]]
deps = ["Libdl"]
uuid = "83775a58-1f1d-513f-b197-d71354ab007a"
version = "1.2.12+3"

[[libblastrampoline_jll]]
deps = ["Artifacts", "Libdl", "OpenBLAS_jll"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"
version = "5.1.1+0"

[[nghttp2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850ede-7688-5339-a07c-302acd2aaf8d"
version = "1.48.0+0"

[[p7zip_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "3f19e933-33d8-53b3-aaab-bd5110c3b7a0"
version = "17.4.0+0"
"""

# ╔═╡ Cell order:
# ╟─c7822c42-2f57-11ec-3b48-2b2ea80c6f23
# ╟─796a9adb-7573-4ec1-881f-ab39d98032ae
# ╟─d65087c7-1b55-4aeb-bda6-fd4039b64863
# ╟─1d0dbac8-8a12-4ba0-862b-e7a2860e2b6e
# ╠═f561e6bd-63d0-43db-9bcb-5135afdfe7d4
# ╠═2cef6853-6624-428a-81c4-4e8fdb8727f7
# ╠═50bcce4a-981b-4b70-9fa6-98ad9f7b39e4
# ╠═d2bd39f1-8d81-404d-bea6-70ea8e19cea1
# ╠═37101508-f1a7-42ed-b446-a9b21001c7b0
# ╟─eab84d4f-1a60-478e-9d3e-92d1b466e142
# ╠═c6eca5d9-48b9-48bf-9bfa-de7359549e00
# ╟─b7153ddf-b153-4b9c-9fea-aab1fe30471d
# ╠═ac0f2a28-a8aa-4031-b69c-71e8f6047574
# ╠═2b00f9f2-53f3-4525-a3e4-708109259b6c
# ╟─15dbf654-25cc-43e5-8526-d3e62ca3271a
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
