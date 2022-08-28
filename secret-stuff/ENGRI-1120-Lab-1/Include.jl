# Setup the fun with mass balance simulation 
# Varner, 8/28/22

# paths -
const _ROOT = pwd()
const _PATH_TO_SRC = joinpath(_ROOT, "src")
const _PATH_TO_DATA = joinpath(_ROOT, "data")
const _PATH_TO_CONFIG = joinpath(_ROOT, "config")

# packages -
using DataFrames
using CSV
using Plots
using Distributions
using JLD2
using FileIO
using TOML
