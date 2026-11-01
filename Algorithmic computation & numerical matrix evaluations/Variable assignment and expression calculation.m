% Task 1: Variable assignment and expression calculation
% Set values for variables
k = 2;
x = 0.32;
d = 1.25;
n = -4;
b = 0.75;
c = 2.2;

% Calculate the expression y
y = 10^-3 * tan(k*n) - ((x - d) * (x^2 + b^2)) / ...
    (cbrt(x^2 + b^2 - c*d)) * (cos(k*x) / sin(5))
