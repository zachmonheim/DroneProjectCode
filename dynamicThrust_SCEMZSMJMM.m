function[thrust] = dynamicThrust_SCEMZSMJMM(RPM)

%3T    3/14/18    SCEMZ SMJMM

%{
This function will calculate the dynamic thrust of the drone prototype
using a set of given constants (described below) and taking the velocity
vector and RPM as input
%}

%Given constants:
    %propeller pitch: 0.0762 meters
    %propeller diameter: 0.1524 meters
pitch = 0.0762;
d = 0.1524;

syms v
%Calculate the dynamic thrust
thrust = 1.134*((pi*d.^2)/4)*((RPM*pitch*(1/60)).^2-(RPM*pitch*(1/60))*v)*(d/(3.29546*pitch)).^1.5;