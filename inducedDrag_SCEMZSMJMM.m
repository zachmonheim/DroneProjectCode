function[induced] = inducedDrag_SCEMZSMJMM(wSpan, wArea, weight)

%3T    3/14/18    SCEMZ SMJMM

%{
This function will calculate the induced drag of the drone prototype using
the wing span, wing area, and drone weight
%}

%Given constants
    %rho: 1.1338 kg/m^3
    %e (span efficiency factor): 0.85
p = 1.1338;
e = 0.85;

%Calculate aspect ratio
AR = (wSpan).^2/wArea;

%{

%Create 2 arrays, initialize with 0 for the time being
lift = zeros(1, numel(velocity));
induced = zeros(1, numel(velocity));

%Calculate lift coefficient
x = 1;

while (x <= numel(velocity))
    lift(x) = (2*weight)/(p*(velocity(x)).^2*wArea);
    x = x + 1;
end

%Calculate the induced drag
i = 1;

while (i <= numel(lift))
    induced(i) = (lift(i))/(pi*AR*e);
    i = i + 1;
end
%}

syms v
%Calculate the lift coefficient
lift = (2*weight)/(p*(v).^2*wArea);

%Calculate the induced drag
induced = (lift).^2/(pi*AR*e);