function[fuse] = dragFuselage_SCEMZSMJMM(diam, length, wet, area)

%3T    3/14/18    SCEMZ SMJMM

%{
FUSELAGE:
This function will calculate components of parasite drag of the drone
prototype using the average (MAC) length, thickness, and wetted area, then
divides it by the wing area
%}

%Given constants
    %RE: 36000 for wing/tail, 182000 for fuselage
RE = 182000;

%Calculate Cf value
Cf = 0.455/((log10(RE)).^2.58);

%Calculate form factor
FF = 1 + 1.5*(diam/length).^(3/2) + 7*(diam/length).^3;

%Calculate the overall component
fuse = (Cf*FF*wet)/area;