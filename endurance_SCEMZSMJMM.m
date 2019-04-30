function[endure] = endurance_SCEMZSMJMM(e, max, drag)

%3T    3/14/18    SCEMZ SMJMM

%{
This function will calculate the endurance of the drone prototype using a
set of given constants (described below) and taking the max speed and drag
as input
%}

%Given constants:
    %Eta overall: 0.8
eta = 0.8;

%Convert from Wh to J
eavail = (e*eta) * 3600;

%Calcuate endurance
endure = (eavail*eta)/(max*drag);