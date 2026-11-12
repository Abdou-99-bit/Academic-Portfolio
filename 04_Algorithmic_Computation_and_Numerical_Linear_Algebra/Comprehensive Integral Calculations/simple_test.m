% Simple test script for Task 7 integral calculations
% This script provides basic verification of the main functionality

% Clear workspace
clear;
clc;

fprintf('Simple Test for Task 7 Integral Calculations\n');
fprintf('=============================================\n\n');

% Define function and parameters
f = @(x) x.^2 .* exp(-2*x);
a = 0;
b = 1.6;
epsilon = 1e-6;

fprintf('Function: f(x) = x^2 * e^(-2x)\n');
fprintf('Interval: [%.1f, %.1f]\n', a, b);
fprintf('Accuracy: ε = %.0e\n\n', epsilon);

% Test 1: Basic numerical integration
fprintf('Test 1: Basic Numerical Integration\n');
fprintf('----------------------------------\n');

% Simple trapezoidal integration
n = 1000;
x_points = linspace(a, b, n);
y_points = f(x_points);
integral_trapz = trapz(x_points, y_points);
fprintf('Trapezoidal rule (n=%d): %.10f\n', n, integral_trapz);

% Built-in integration
try
    integral_builtin = integral(f, a, b, 'AbsTol', epsilon, 'RelTol', epsilon);
    fprintf('Built-in integral(): %.10f\n', integral_builtin);
    fprintf('Difference: %.2e\n', abs(integral_trapz - integral_builtin));
catch ME
    fprintf('Built-in integration failed: %s\n', ME.message);
end

fprintf('\n');

% Test 2: Symbolic integration (if available)
fprintf('Test 2: Symbolic Integration\n');
fprintf('---------------------------\n');

try
    syms x;
    f_sym = x^2 * exp(-2*x);
    
    % Indefinite integral
    F_sym = int(f_sym, x);
    fprintf('Indefinite integral: %s\n', char(F_sym));
    
    % Definite integral
    definite_sym = int(f_sym, x, a, b);
    definite_numeric = double(definite_sym);
    fprintf('Definite integral: %s\n', char(definite_sym));
    fprintf('Numerical value: %.10f\n', definite_numeric);
    
    % Verification by differentiation
    dF_sym = diff(F_sym, x);
    if simplify(dF_sym - f_sym) == 0
        fprintf('✓ Differentiation verification successful\n');
    else
        fprintf('✗ Differentiation verification failed\n');
    end
    
catch ME
    fprintf('Symbolic integration not available: %s\n', ME.message);
end

fprintf('\n');

% Test 3: Multiple integrals
fprintf('Test 3: Multiple Integrals\n');
fprintf('------------------------\n');

% Double integral (analytical: should be 2 * single integral)
double_integral_analytical = 2 * integral_trapz;
fprintf('Double integral (analytical): %.10f\n', double_integral_analytical);

% Triple integral (analytical: should be 2 * single integral)
triple_integral_analytical = 2 * integral_trapz;
fprintf('Triple integral (analytical): %.10f\n', triple_integral_analytical);

% Numerical verification (if available)
try
    f_double = @(x, y) x.^2 .* exp(-2*x);
    double_integral_numeric = integral2(f_double, a, b, 0, 2, 'AbsTol', epsilon, 'RelTol', epsilon);
    fprintf('Double integral (numerical): %.10f\n', double_integral_numeric);
    fprintf('Difference: %.2e\n', abs(double_integral_analytical - double_integral_numeric));
    
    f_triple = @(x, y, z) x.^2 .* exp(-2*x);
    triple_integral_numeric = integral3(f_triple, a, b, 0, 2, 0, 1, 'AbsTol', epsilon, 'RelTol', epsilon);
    fprintf('Triple integral (numerical): %.10f\n', triple_integral_numeric);
    fprintf('Difference: %.2e\n', abs(triple_integral_analytical - triple_integral_numeric));
    
catch ME
    fprintf('Multiple integral numerical verification failed: %s\n', ME.message);
end

fprintf('\n');

% Test 4: Convergence test
fprintf('Test 4: Convergence Test\n');
fprintf('-----------------------\n');

n_values = [10, 20, 50, 100, 200, 500];
reference_value = integral_trapz;  % Use high-resolution as reference

fprintf('Subintervals | Integral Value | Error\n');
fprintf('-------------|----------------|------\n');

for i = 1:length(n_values)
    n_test = n_values(i);
    x_test = linspace(a, b, n_test);
    y_test = f(x_test);
    integral_test = trapz(x_test, y_test);
    error_test = abs(integral_test - reference_value);
    
    fprintf('%12d | %14.10f | %6.2e\n', n_test, integral_test, error_test);
end

fprintf('\n');

% Test 5: Function properties
fprintf('Test 5: Function Properties\n');
fprintf('--------------------------\n');

% Find maximum
[x_max, idx_max] = max(f(x_points));
x_at_max = x_points(idx_max);
fprintf('Maximum value: %.6f at x = %.6f\n', x_max, x_at_max);

% Calculate some statistics
mean_value = mean(y_points);
std_value = std(y_points);
fprintf('Mean value: %.6f\n', mean_value);
fprintf('Standard deviation: %.6f\n', std_value);

% Check function values at boundaries
f_at_a = f(a);
f_at_b = f(b);
fprintf('f(%.1f) = %.6f\n', a, f_at_a);
fprintf('f(%.1f) = %.6f\n', b, f_at_b);

fprintf('\n✓ Simple tests completed!\n');
fprintf('Run "integral_calculations" for comprehensive analysis.\n');
fprintf('Run "visualization" for graphical analysis.\n');
