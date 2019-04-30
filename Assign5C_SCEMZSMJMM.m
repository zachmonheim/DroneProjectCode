%3T     5C-3/14/18     SCEMZ SMJMM

%Group Members:
%Erin Jones, Maureena Ma, Colin Maw, Zach Monheim, Sydney Silkroski

%{
This program will take inputs about the geometry of a drone design, some
initial conditions, and calculate the aerodynamic drag and dynamic thrust
of the design.

The code implements several functions in an attempt to clean up the overall
appearance and create a user-friendly experience
%}

%Outputs a message explaining the program
fprintf("This program will calculate the aerodynamic drag and dynamic thrust of a drone prototype. \n");
fprintf("Please make sure to keep your units consistent when entering values, or the results may not be correct. \n");
fprintf("Suggestion: Use standard SI units. \n");

%User Inputs:
%the vehicle
wArea = input('Please enter the theoretical area of the wings: ');
wSpan = input('Please enter the wing span of the drone: ');
wThickness = input('Please enter the thickness of the wings: ');
wWet = input('Please enter the wetted area of the wing: ');
fWet = input('Please enter the wetted area of the fuselage: ');
tHWet = input('Please enter the wetted area of the horizontal tails: ');
tVWet = input('Please enter the wetted area of the vertical tail: ');
fAvg = input('Please enter the average diameter of the fuselage: ');
fLength = input('Please enter the overall length of the fuselage: ');
wAvgThick = input('Please enter the average thickness of the wings: ');
tAvgThick = input('Please enter the average thickness of the tails: ');
wAvgLength = input('Please enter the average wing chord (MAC) length: ');
tHAvgLength = input('Please enter the average horizontal tail chord (MAC) length: ');
tVAvgLength = input('Please enter the average vertical tail chord (MAC) length: ');
weight = input('Please enter the weight of the drone: ');
battMass = input('Please enter the mass of the battery: ');
RPM = input('Please enter the RPM of the motor: ');
e = input('Please enter the available energy: ');
%the conditions
speed = input('Please enter the speed in vector form: ');

%Calculations:
%dynamic thrust
thrust = dynamicThrust_SCEMZSMJMM(RPM);

%drag coefficient - parasite (calls a function)
wing = dragComponents_SCEMZSMJMM(wAvgLength, wAvgThick, wWet, wArea);
hTail = dragComponents_SCEMZSMJMM(tHAvgLength, tAvgThick, tHWet, wArea);
vTail = dragComponents_SCEMZSMJMM(tVAvgLength, tAvgThick, tVWet, wArea);
fuselage = dragFuselage_SCEMZSMJMM(fAvg, fLength, fWet, wArea);

parasite = wing + hTail + vTail + fuselage;

%drag coefficient - induced (calls a function)
induced = inducedDrag_SCEMZSMJMM(wSpan, wArea, weight);

%drag coefficient
dragC = parasite + induced;

%overall drag (calls a function)
drag = drag_SCEMZSMJMM(dragC, wArea);

%create an array to store values of drag at each point in the speed array
dragA = dragV_SCEMZSMJMM(wSpan, wArea, weight, parasite, speed);

%Plot - Total Drag and Thrust vs Speed
ezplot(drag, [speed(1), speed(numel(speed))]);          %Plot drag vs speed
text(1, 1, 'Drag');                                     %Label drag curve
hold on;                                                %Add another graph
%plot(speed, thrust, 'r');                               %Plot thrust vs speed
ezplot(thrust, [speed(1), speed(numel(speed))]);
text(10, 4, 'Thrust');                                   %Label thrust curve
title('Thrust and Drag vs Speed');                      %Label graph
xlabel('Speed (m/s)');                                  %Label x axis
ylabel('Force (Newtons)');                              %Label y axis
grid;                                                   %Add a grid

%Find max speed and drag force
%{
[maxSpeed, dragInt] = polyxpoly(speed,thrust,speed,dragA);

maxSpeed = fzero(@(x) polyval(thrust-drag,x),3);
dragInt = polyval(thrust,maxSpeed);

intersection = find(thrust == drag);
x_points = -50:0.1:50;
maxSpeed = x_points(intersection);
dragInt = drag(intersection);

%}

p1 = polyfit(speed, thrust, 2);
p2 = polyfit(speed, dragA, 2);

maxSpeed = fzero(@(x) polyval(p1-p2,x),2);
dragInt = polyval(p1,maxSpeed);

    %plot a point at the intersection for visual aid
int = plot(maxSpeed, dragInt, 'Marker', '*', 'MarkerSize', 6, 'Color', 'g');

%Endurance - calls a function
endurance = endurance_SCEMZSMJMM(e, maxSpeed, dragInt);
hours = endurance/3600;    %Convert seconds to hours

%Range - calls a function
range = range_SCEMZSMJMM(battMass, weight, dragInt);
miles = range/1609.344;    %Convert meters to miles
    
%Output
%Table:
    %fuselage overall length
    %total drone weight
    %theoretical wing area
    %wing span
    %fuselage average diameter
fprintf("\n");
fprintf("Drone Part:                    Input Parameter: \n");
fprintf("Fuselage Overall Length                   %5.2f \n", fLength);
fprintf("Total Drone Weight                        %5.2f \n", weight);
fprintf("Theoretical Wing Area                     %5.2f \n", wArea);
fprintf("Wing Span                                 %5.2f \n", wSpan);
fprintf("Fuselage Average Diameter                 %5.2f \n\n", fAvg);

%Max speed of prototype
fprintf("The max speed of the prototype is %5.2f m/s. \n", maxSpeed);

%Endurance and range prototype can fly at max speed
fprintf("The endurance of the prototype is %5.2f seconds, or %5.2f hours. \n", endurance, hours);
fprintf("The range of the prototype is %5.2f meters, or %5.2f miles. \n", range, miles);