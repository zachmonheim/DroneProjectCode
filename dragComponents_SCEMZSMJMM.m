function[comp] = dragComponents_SCEMZSMJMM(avg, thick, wet, area)

%3T    3/14/18    SCEMZ SMJMM

%{
WING OR TAIL:
This function will calculate components of parasite drag of the drone
prototype using the average (MAC) length, thickness, and wetted area, then
divides it by the wing area
%}

%Given constants
    %RE: 36000 for wing/tail, 182000 for fuselage
RE = 36000;

%Calculate Cf value
Cf = 0.455/((log10(RE)).^2.58);

%Calculate form factor
FF = 1 + 2*(thick/avg) + 60*(thick/avg).^4;

%Calculate the overall component
comp = (Cf*FF*wet)/area;