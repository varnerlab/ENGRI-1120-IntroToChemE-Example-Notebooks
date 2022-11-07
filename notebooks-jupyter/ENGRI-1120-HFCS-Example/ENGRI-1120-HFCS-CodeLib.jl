abstract type AbstractSimulationModel end

mutable struct HFCSParameterModel <: AbstractSimulationModel

    # data -
    k₁::Float64
    k₂::Float64
    Kₘ::Float64

    # dilution rate -
    D₁::Float64
    D₂::Float64
    D₃::Float64

    # stoichiometric array -
    SM::Array{Float64,2}
    CM::Array{Float64,2}

    # constructor -
    HFCSParameterModel() = new();
end

function r̂(concentration_array::Array{Float64,1}, model::HFCSParameterModel)

    # initialize -
    r_vector = Array{Float64,1}(undef, 2);
    
    S = concentration_array[1];
    E = concentration_array[2];
    P = concentration_array[3];

    # grab the parameters -
    k₁ = model.k₁
    k₂ = model.k₂
    Kₘ = model.Kₘ

    # compute rate -
    r_vector[1] = k₁*E*((S)/(Kₘ+S));
    r_vector[2] = k₂*E;

    # return -
    return r_vector;
end

function objfunc(x, model)

    # get some stuff from the model -
    SM = model.SM;
    CM = model.CM;
    
    D₁ = model.D₁
    D₂ = model.D₂
    D₃ = model.D₃


    # setup D-vector -
    DV = [D₁, D₂, D₃];

    # compute the rate vector -
    r_vector = r̂(x, model);

    # compute error vector -
    ϵ  = CM*DV + SM*r_vector - D₃*x

    # return -
    return transpose(ϵ)*ϵ;
end

function testfunc(x, model)

    # get some stuff from the model -
    SM = model.SM;
    CM = model.CM;
    D₁ = model.D₁
    D₂ = model.D₂
    D₃ = model.D₃


    # setup D-vector -
    DV = [D₁, D₂, D₃];

    # compute the rate vector -
    r_vector = r̂(x, model);

    # compute error vector -
    ϵ  = CM*DV + SM*r_vector - D₃*x

    # return -
    return (ϵ, CM, DV)
end