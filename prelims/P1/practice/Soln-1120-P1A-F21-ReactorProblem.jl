### A Pluto.jl notebook ###
# v0.19.12

using Markdown
using InteractiveUtils

# ╔═╡ 828b5fdc-2f57-11ec-2ba2-bd6c394912fa
begin
	using PlutoUI
	using PrettyTables
end

# ╔═╡ 8c65af87-71e1-45ed-a635-d97a6e6b7a3e
# ╠═╡ show_logs = false
md"""$(PlutoUI.LocalResource("./figs/Fig-ReactorFilter-F21.png"))

__Fig 1: Reactor-Filter problem schematic.__ Starting material A is converted to product B by enzyme E in a well-mixed reactor with volume V. The reactor is well insulated. The output from the reactor is fed into a filtration unit that has no moving parts and is NOT well insulated."""

# ╔═╡ b56695f3-68c1-4b76-8cc8-bb57d7e34699
md"""
Consider the reaction/separation process shown in Fig 1.
    A starting material $A$ is converted to product $B$ by enzyme $E$ in a well-mixed and well-insulated reactor.
    Mixing is achieved in the reactor using a mechanical stirring device. 
    The enzyme $E$ is immobilized in the reactor (does not flow out), and is stable. Downstream of the reactor,
    a filtration device separates unreacted starting material $A$ from product $B$.
    The filtration unit has no moving parts, and is NOT well insulated. 

 __Assumptions:__
* the reactor and filtration units operate at steady-state; 
* neglect changes in the kinetic and potential energy in the systems and streams;
* the volume of the reactor is $V$ = 14 L;
* the density of the systems and streams is constant $\rho$ = 1.2 kg/L.

"""

# ╔═╡ 59a9a683-e2da-4690-9950-80e2bcedbb18
md"""

__Compute:__
* (a) Compute the missing values for the mol and volumetric flow rates if the specific reaction rate $\hat{r}_{1}$ = 6.0 mmol L$^{-1}$ min$^{-1}$.
* (b) Compute the missing mass flow rate values.
* (c) Compute the rate of work $\dot{W}_{sh}$ (kJ/min) required to keep the reactor well mixed.
* (d) Compute the rate of heat flow $\dot{Q}$ (kJ/min) into (or from) the filtration unit.
"""

# ╔═╡ f198f507-e5ca-4ec1-a2bd-648965f94780
md"""
##### a) Compute the missing mol and volumetric flow rates in the table.

###### Volumetric flow rates:
Let's start with the volumetric flow rates. You can compute the volumetic flow rate from the _total mass balance_ equation. At steady state, for _any process unit_ we know that:

$$\sum_{s}v_{s}\dot{m}_{s} = 0$$
However, we know that $\dot{m}_{s}$ = $\rho_{s}\dot{F}_{s}$, where $\rho_{s}$ denotes the density of stream $s$ (units: kg/L), and $\dot{F}_{s}$ denotes the volumetric flow rate for stream $s$ (units: L/min). Thus, we can re-write the total mass balance in terms of the volumetric flow rates:

$$\sum_{s}v_{s}\rho_{s}\dot{F}_{s} = 0$$
In this problem (from the assumptions) we have assumed that the density of all streams was the same (and constant) i.e., $\rho_{1}=\rho_{2}\dots\rho_{\mathcal{S}}\equiv\rho$ which means we can pull the density out of the sum, and divide by $\rho$ to give:

$$\sum_{s}v_{s}\dot{F}_{s} = 0$$

For the __reactor__ we have a single in and a single out, so $\dot{F}_{1}$ = $\dot{F}_{2}$. However, for the __filter__ we have a single in, but two exit streams, thus: $\dot{F}_{2} = \dot{F}_{3}+\dot{F}_{4}$
"""

# ╔═╡ 3e17b4fe-1025-471b-ba7e-f257d3f9ef0b
md"""
###### Mol flow rates:

To compute the missing mol flow rates, we start with the steady-state species mol balance equation (which is true for any process unit):

$$\sum_{s}v_{s}\dot{n}_{k,s}+\dot{n}_{gen,k} = 0$$

where $\dot{n}_{k,s}$ denotes the flow of mols of species $k$ in stream $s$, and
$\dot{n}_{gen,k}$ denotes the generation (reaction) terms for species $k$ that are occuring inside the process unit (system). Lastly, we known (in the absence of cells) that the generation (reaction) term(s) are given by:

$$\dot{n}_{gen,k} = \left(\sum_{r}\sigma_{kr}\hat{r}_{r}\right)V$$

where $\sigma_{kr}$ denotes the stoichiometric coefficient for species $k$ in reaction $r$, and $\hat{r}_{r}$ denotes the _specific reaction rate_ for reaction $r$ (units: mmol/min-L) and $V$ denotes volume (units: L). For this problem, we have a single reaction whose rate $\hat{r}_{1}$ which was given in the problem, the volume $V$ was given, and $\sigma_{11}$ = -1 and $\sigma_{21}$ = +1, where $A$ = 1 and $B$ = 2.

For the __reactor__, the species mol balances are given by:

$$\begin{eqnarray}
\dot{n}_{11} -\dot{n}_{12} -\hat{r}_{1}V &=& 0\\
\dot{n}_{21} -\dot{n}_{22} +\hat{r}_{1}V &=& 0\\
\end{eqnarray}$$

For the __filtration unit__, the species mol balances are given by:

$$\begin{eqnarray}
\dot{n}_{12} -\dot{n}_{13} - \dot{n}_{14} &=& 0\\
\dot{n}_{22} -\dot{n}_{23} - \dot{n}_{24} &=& 0\\
\end{eqnarray}$$
"""

# ╔═╡ 75e41abc-bf6b-42b6-a400-3e68b49e53a1
begin
	
	# data given in the problem setup -
	n11 = 100.0 	# units: mol/min
	n21 = 0.0 		# units: mol/min
	n24 = 0.0 		# units: mol/min
	F1_dot = 10.0 	# units: L/min
	F3_dot = 4.0 	# units: L/min
	
	# reaction terms -> change for γ and δ versions of prelim
	r1_hat = 4.0    # units: mmol/min-L
	V = 14.0 		# units: L
	n14 = 8.0 		# units: mol/min
	
	# show - 
	nothing 
end

# ╔═╡ 51cf0922-fa58-4335-9f34-ae033203f4df
# matrix vector around reactor and filtration -
begin
	
	# setup both units - unknowns: n12, n22, n13, n23, F2_dot and F4_dot -
	AT = [-1 0 0 0 0 0; 0 -1 0 0 0 0; 1 0 -1 0 0 0; 0 1 0 -1 0 0; 0 0 0 0 -1 0; 0 0 0 0 1 -1];
	bT = [-n11 + r1_hat*V ; -n21 - r1_hat*V ; n14 ; n24 ; -F1_dot ; F3_dot]
	x_dot = inv(AT)*bT
	n12 = x_dot[1]
	n22 = x_dot[2]
	n13 = x_dot[3]
	n23 = x_dot[4]
	F2_dot = x_dot[5]
	F4_dot = x_dot[6]
	
	# show -
	nothing
end

# ╔═╡ 99d53a10-dc5e-43ae-8095-4ef594f9c420
begin
	# put all the data into a table, so we can display the solution using the PrettyTable.j package -
	data_table = zeros(4,4)
	
	# row 1 -
	data_table[1,1] = 1
	data_table[1,2] = n11
	data_table[1,3] = n21
	data_table[1,4] = F1_dot
	
	# row 2 -
	data_table[2,1] = 2
	data_table[2,2] = n12
	data_table[2,3] = n22
	data_table[2,4] = F2_dot
	
	# row 3 -
	data_table[3,1] = 3
	data_table[3,2] = n13
	data_table[3,3] = n23
	data_table[3,4] = F3_dot
	
	# row 4 -
	data_table[4,1] = 4
	data_table[4,2] = n14
	data_table[4,3] = n24
	data_table[4,4] = F4_dot
	
	
	with_terminal() do
		
		# setup the table -
		header_row = (["Stream","n1,i","n2,i","Vol Flow Rate"],["","[mmol/min]","[mmol/min]","[L/min]"]);
		
		# write the table -
		pretty_table(data_table; header=header_row)
	end
end

# ╔═╡ ccee2491-9a2e-45d2-a607-f27b54ad66ae
md"""
###### b) Compute the missing mass flow rates in the table.

To compute the missing mass flow rates, we apply a total mass balance to each process unit. At steady-state we know that:

$$\sum_{s}v_{s}\dot{m}_{s} = 0$$

For the __reactor__ we have a single in (given) and a single out, thus: $\dot{m}_{1}=\dot{m}_{2}$. However, for the filter we have a single in $\dot{m}_{2}$ but two output streams $\dot{m}_{3}$ and $\dot{m}_{4}$, thus:

$$\dot{m}_{2} = \dot{m}_{3} + \dot{m}_{4}$$

"""

# ╔═╡ c3967197-6c0c-4f7f-ac02-20a95ba921ca
begin
	
	# setup problem -
	m1_dot = 12.0 	# units: kg/min
	m3_dot = 4.8 	# units: kg/min
	
	# reactor -
	m2_dot = m1_dot
	
	# filter -
	m4_dot = m2_dot - m3_dot
	
	# show -
	nothing
end

# ╔═╡ 230abf7b-db83-49b9-a0d0-124aa2b328e5
begin
	
	# initialize -
	mass_data_table = zeros(4,4)
	
	# row 1
	mass_data_table[1,1] = 1
	mass_data_table[1,2] = 1.2
	mass_data_table[1,3] = m1_dot
	mass_data_table[1,4] = 120.0

	# row 2
	mass_data_table[2,1] = 2
	mass_data_table[2,2] = 1.2
	mass_data_table[2,3] = m2_dot
	mass_data_table[2,4] = 200.0

	# row 3
	mass_data_table[3,1] = 3
	mass_data_table[3,2] = 1.2
	mass_data_table[3,3] = m3_dot
	mass_data_table[3,4] = 125.0

	# row 3
	mass_data_table[4,1] = 4
	mass_data_table[4,2] = 1.2
	mass_data_table[4,3] = m4_dot
	mass_data_table[4,4] = 260.0
	
	with_terminal() do 
		
		# setup the table -
		mass_header_row = (["Stream","density","mdot_i","H"],["","[kg/L]","[kg/min]","[kJ/kg]"]);
		
		# write the table -
		pretty_table(mass_data_table; header=mass_header_row)
		
	end
end

# ╔═╡ 00a50f4a-838e-4f5a-b01d-0a754ca5a256
md"""
###### c) Compute the rate of work $\dot{W}_{sh}$ (kJ/min) required to keep the reactor well mixed.

To compute the rate of work, we start from the steady-state open energy balance equation:

$$\dot{Q}+\dot{W}_{sh}+\sum_{s}v_{s}\dot{m}_{s}H_{s} = 0$$

and throw out (or simplify) terms that don't apply to reactor process unit. First, 
for the reactor we have a single input and a single output, thus $\dot{m}_{1}=\dot{m}_{2}$. Next, the reactor is well-insulated, thus, we know that $\dot{Q}$ = 0. Putting these ideas together gives:

$$\dot{W}_{sh} + \dot{m}_{1}\left(H_{1}-H_{2}\right) = 0$$ or (after we solve for work):

$$\dot{W}_{sh} = \dot{m}_{1}\left(H_{2}-H_{1}\right)$$.
"""

# ╔═╡ 1f41d0db-abb1-48c6-8651-655ba4f73686
begin
	# alias the H's
	H₁ = mass_data_table[1,4];
	H₂ = mass_data_table[2,4];
	H₃ = mass_data_table[3,4];
	H₄ = mass_data_table[4,4];
	
	# compute the ΔH -
	ΔH = (H₂ - H₁)
	
	# compute the work -
	W = m1_dot*ΔH
end

# ╔═╡ ddaabaaa-f1dd-4853-9412-f7972dc4dc6d
md"""
###### d) Compute the rate of heat flow $\dot{Q}$ (kJ/min) into (or from) the filtration unit.

To compute the rate of heat transfer, we start from the steady-state open energy balance equation:

$$\dot{Q}+\dot{W}_{sh}+\sum_{s}v_{s}\dot{m}_{s}H_{s} = 0$$

and throw out (or simplify) terms that don't apply to filtration process unit.
First, the filtration unit has no moving parts, thus, the rate of shaft work $\dot{W}_{sh}$. However, unlike the reactor, we have a single input but multiple outputs, thus, the energy balance for the filtration unit is given by:

$$\dot{Q} + \dot{m}_{2}H_{2} - \dot{m}_{3}H_{3} - \dot{m}_{4}H_{4} = 0$$

All the enthalpies were given in the problem, and we know the $\dot{m}_{s}$ from part b). To compute $\dot{Q}$:

$$\dot{Q} = \dot{m}_{3}H_{3} + \dot{m}_{4}H_{4} - \dot{m}_{2}H_{2}$$

"""

# ╔═╡ 8196a83d-b705-479a-b8fd-551f1ef95bd3
begin
	# compute the Qdot -
	Q_dot = m3_dot*H₃ + m4_dot*H₄ - m2_dot*H₂
end

# ╔═╡ 9c476e5e-99f8-4040-8a60-1d81886d1850


# ╔═╡ db72171c-3964-4992-8d00-c9f8217a829d
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
# ╟─8c65af87-71e1-45ed-a635-d97a6e6b7a3e
# ╟─b56695f3-68c1-4b76-8cc8-bb57d7e34699
# ╟─59a9a683-e2da-4690-9950-80e2bcedbb18
# ╟─f198f507-e5ca-4ec1-a2bd-648965f94780
# ╟─3e17b4fe-1025-471b-ba7e-f257d3f9ef0b
# ╠═75e41abc-bf6b-42b6-a400-3e68b49e53a1
# ╠═99d53a10-dc5e-43ae-8095-4ef594f9c420
# ╟─51cf0922-fa58-4335-9f34-ae033203f4df
# ╟─ccee2491-9a2e-45d2-a607-f27b54ad66ae
# ╠═c3967197-6c0c-4f7f-ac02-20a95ba921ca
# ╠═230abf7b-db83-49b9-a0d0-124aa2b328e5
# ╟─00a50f4a-838e-4f5a-b01d-0a754ca5a256
# ╠═1f41d0db-abb1-48c6-8651-655ba4f73686
# ╟─ddaabaaa-f1dd-4853-9412-f7972dc4dc6d
# ╠═8196a83d-b705-479a-b8fd-551f1ef95bd3
# ╠═828b5fdc-2f57-11ec-2ba2-bd6c394912fa
# ╠═9c476e5e-99f8-4040-8a60-1d81886d1850
# ╟─db72171c-3964-4992-8d00-c9f8217a829d
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
