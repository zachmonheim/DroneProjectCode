function[drag] = drag_SCEMZSMJMM(coefficient, wArea)

%3T    3/14/18    SCEMZ SMJMM

%{
This function will calculate the total drag of the drone prototype using
the drag coefficient, theoretical wing area, and a set of given constants
%}

%Given constants
    %rho: 1.1338 kg/m^3
p = 1.1338;

syms v
%Calculate drag
drag = (1/2)*p*v.^2*coefficient*wArea;