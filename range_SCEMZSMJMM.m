function[range] = range_SCEMZSMJMM(bMass, weight, drag)

%3T    3/14/18    SCEMZ SMJMM

%{
This function will calculate the range of the drone prototype using a set
of given constants (described below) and taking the mass of the battery,
weight of the drone, and drag as inputs
%}

%Given constants:
    %Eta overall: 0.8
    %E star: .36 MJ/kg = 360000 J/kg
    %g (a due to gravity): 9.81 m/s^2
eta = 0.8;
estar = 360000;
g = 9.81;

%Calculate mass of total drone
dMass = weight/g;

%Calculate range
range = estar*(bMass/dMass)*(1/g)*(weight/drag)*eta;