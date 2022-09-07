# setup my paths -
const _PATH_TO_ROOT = pwd()
const _PATH_TO_SRC = joinpath(_PATH_TO_ROOT, "src");

# load my codes -
include(joinpath(_PATH_TO_SRC, "Parser.jl"))
include(joinpath(_PATH_TO_SRC, "Stoichiometry.jl"))
include(joinpath(_PATH_TO_SRC, "Flux.jl"))
