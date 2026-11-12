% Task 7: Comprehensive Integral Calculations
% Function: f(x) = x^2 * e^(-2x)
% Interval: [0, 1.6]
% Accuracy: ε = 10^(-6)

% Clear workspace and command window
clear;
clc;
close all;

fprintf('Task 7: Comprehensive Integral Calculations\n');
fprintf('==========================================\n\n');

% Define the function and parameters
syms x;
f = x^2 * exp(-2*x);
a = 0;
b = 1.6;
epsilon = 1e-6;

fprintf('Function: f(x) = x^2 * e^(-2x)\n');
fprintf('Interval: [%.1f, %.1f]\n', a, b);
fprintf('Required accuracy: ε = %.0e\n\n', epsilon);

% Step 1: Find indefinite integral using symbolic integration
fprintf('Step 1: Indefinite Integral (Symbolic Integration)\n');
fprintf('==================================================\n');

try
    % Calculate indefinite integral
    F = int(f, x);
    fprintf('Indefinite integral: ∫x^2 * e^(-2x) dx = %s\n', char(F));
    
    % Simplify the result
    F_simplified = simplify(F);
    fprintf('Simplified form: %s\n', char(F_simplified));
    
    % Check the result using differentiation
    fprintf('\nVerification by Differentiation:\n');
    dF_dx = diff(F_simplified, x);
    dF_simplified = simplify(dF_dx);
    fprintf('d/dx[F(x)] = %s\n', char(dF_simplified));
    
    % Check if derivative matches original function
    if simplify(dF_simplified - f) == 0
        fprintf('✓ Verification successful: derivative matches original function\n');
    else
        fprintf('✗ Verification failed: derivative does not match\n');
    end
    
catch ME
    fprintf('Error in symbolic integration: %s\n', ME.message);
end

fprintf('\n');

% Step 2: Find definite integral using symbolic integration
fprintf('Step 2: Definite Integral (Symbolic Integration)\n');
fprintf('===============================================\n');

try
    % Calculate definite integral symbolically
    definite_symbolic = int(f, x, a, b);
    fprintf('Symbolic definite integral: ∫[%.1f to %.1f] x^2 * e^(-2x) dx = %s\n', a, b, char(definite_symbolic));
    
    % Get numerical value
    definite_symbolic_numeric = double(definite_symbolic);
    fprintf('Numerical value: %.10f\n', definite_symbolic_numeric);
    
catch ME
    fprintf('Error in symbolic definite integration: %s\n', ME.message);
end

fprintf('\n');

% Step 3: Find definite integral using numerical methods
fprintf('Step 3: Definite Integral (Numerical Integration)\n');
fprintf('===============================================\n');

% Define the function for numerical integration
f_numeric = @(x) x.^2 .* exp(-2*x);

% Method 1: Trapezoidal rule with adaptive refinement
fprintf('Method 1: Trapezoidal Rule with Adaptive Refinement\n');
fprintf('---------------------------------------------------\n');

n = 10;  % Initial number of subintervals
integral_trap_prev = 0;
integral_trap_current = trapz(linspace(a, b, n), f_numeric(linspace(a, b, n)));
iteration = 1;

fprintf('Iteration | Subintervals | Integral Value    | Difference\n');
fprintf('----------|---------------|-------------------|------------\n');

while abs(integral_trap_current - integral_trap_prev) > epsilon && n < 1000000
    fprintf('%9d | %13d | %17.10f | %10.2e\n', iteration, n, integral_trap_current, ...
            abs(integral_trap_current - integral_trap_prev));
    
    integral_trap_prev = integral_trap_current;
    n = n * 2;  % Double the number of subintervals
    x_points = linspace(a, b, n);
    integral_trap_current = trapz(x_points, f_numeric(x_points));
    iteration = iteration + 1;
end

fprintf('%9d | %13d | %17.10f | %10.2e\n', iteration, n, integral_trap_current, ...
        abs(integral_trap_current - integral_trap_prev));
fprintf('Final trapezoidal result: %.10f\n', integral_trap_current);
fprintf('Number of subintervals used: %d\n', n);

% Method 2: Simpson's rule with adaptive refinement
fprintf('\nMethod 2: Simpson''s Rule with Adaptive Refinement\n');
fprintf('------------------------------------------------\n');

n_simpson = 10;  % Initial number of subintervals (must be even)
integral_simpson_prev = 0;
integral_simpson_current = 0;
iteration_simpson = 1;

fprintf('Iteration | Subintervals | Integral Value    | Difference\n');
fprintf('----------|---------------|-------------------|------------\n');

while abs(integral_simpson_current - integral_simpson_prev) > epsilon && n_simpson < 1000000
    if mod(n_simpson, 2) == 1
        n_simpson = n_simpson + 1;  % Make sure n is even
    end
    
    x_simpson = linspace(a, b, n_simpson + 1);
    y_simpson = f_numeric(x_simpson);
    
    % Simpson's rule implementation
    h = (b - a) / n_simpson;
    integral_simpson_current = y_simpson(1) + y_simpson(end);
    
    for i = 2:n_simpson
        if mod(i, 2) == 0
            integral_simpson_current = integral_simpson_current + 4 * y_simpson(i);
        else
            integral_simpson_current = integral_simpson_current + 2 * y_simpson(i);
        end
    end
    
    integral_simpson_current = integral_simpson_current * h / 3;
    
    fprintf('%9d | %13d | %17.10f | %10.2e\n', iteration_simpson, n_simpson, integral_simpson_current, ...
            abs(integral_simpson_current - integral_simpson_prev));
    
    integral_simpson_prev = integral_simpson_current;
    n_simpson = n_simpson * 2;
    iteration_simpson = iteration_simpson + 1;
end

fprintf('Final Simpson result: %.10f\n', integral_simpson_current);
fprintf('Number of subintervals used: %d\n', n_simpson);

% Method 3: Built-in numerical integration
fprintf('\nMethod 3: Built-in Numerical Integration (integral())\n');
fprintf('-----------------------------------------------------\n');

try
    integral_builtin = integral(f_numeric, a, b, 'AbsTol', epsilon, 'RelTol', epsilon);
    fprintf('Built-in integral result: %.10f\n', integral_builtin);
catch ME
    fprintf('Error in built-in integration: %s\n', ME.message);
end

fprintf('\n');

% Step 4: Compare results
fprintf('Step 4: Results Comparison\n');
fprintf('=========================\n');

fprintf('Method                              | Result          | Difference from Symbolic\n');
fprintf('-------------------------------------|-----------------|--------------------------\n');

if exist('definite_symbolic_numeric', 'var')
    fprintf('Symbolic Integration               | %15.10f | %24.2e\n', definite_symbolic_numeric, 0);
    fprintf('Trapezoidal Rule                   | %15.10f | %24.2e\n', integral_trap_current, abs(integral_trap_current - definite_symbolic_numeric));
    fprintf('Simpson''s Rule                     | %15.10f | %24.2e\n', integral_simpson_current, abs(integral_simpson_current - definite_symbolic_numeric));
    if exist('integral_builtin', 'var')
        fprintf('Built-in integral()               | %15.10f | %24.2e\n', integral_builtin, abs(integral_builtin - definite_symbolic_numeric));
    end
else
    fprintf('Trapezoidal Rule                   | %15.10f | %24s\n', integral_trap_current, 'N/A');
    fprintf('Simpson''s Rule                     | %15.10f | %24s\n', integral_simpson_current, 'N/A');
    if exist('integral_builtin', 'var')
        fprintf('Built-in integral()               | %15.10f | %24s\n', integral_builtin, 'N/A');
    end
end

fprintf('\n');

% Step 5: Calculate double integral
fprintf('Step 5: Double Integral\n');
fprintf('=====================\n');

% Define double integral: ∫∫ (x^2 * e^(-2x)) dy dx over y∈[0,2], x∈[0,1.6]
syms y;
f_double = x^2 * exp(-2*x);
y_limits = [0, 2];

fprintf('Double integral: ∫[x=0 to 1.6] ∫[y=0 to 2] (x^2 * e^(-2x)) dy dx\n');

try
    % Calculate double integral symbolically
    double_integral = int(int(f_double, y, y_limits(1), y_limits(2)), x, a, b);
    fprintf('Symbolic double integral: %s\n', char(double_integral));
    double_integral_numeric = double(double_integral);
    fprintf('Numerical value: %.10f\n', double_integral_numeric);
    
    % Verify with numerical integration
    f_double_numeric = @(x, y) x.^2 .* exp(-2*x);
    double_integral_numeric_check = integral2(@(x,y) f_double_numeric(x,y), a, b, y_limits(1), y_limits(2), 'AbsTol', epsilon, 'RelTol', epsilon);
    fprintf('Numerical verification: %.10f\n', double_integral_numeric_check);
    fprintf('Difference: %.2e\n', abs(double_integral_numeric - double_integral_numeric_check));
    
catch ME
    fprintf('Error in double integration: %s\n', ME.message);
end

fprintf('\n');

% Step 6: Calculate triple integral
fprintf('Step 6: Triple Integral\n');
fprintf('=====================\n');

% Define triple integral: ∫∫∫ (x^2 * e^(-2x)) dz dy dx over z∈[0,1], y∈[0,2], x∈[0,1.6]
syms z;
f_triple = x^2 * exp(-2*x);
z_limits = [0, 1];

fprintf('Triple integral: ∫[x=0 to 1.6] ∫[y=0 to 2] ∫[z=0 to 1] (x^2 * e^(-2x)) dz dy dx\n');

try
    % Calculate triple integral symbolically
    triple_integral = int(int(int(f_triple, z, z_limits(1), z_limits(2)), y, y_limits(1), y_limits(2)), x, a, b);
    fprintf('Symbolic triple integral: %s\n', char(triple_integral));
    triple_integral_numeric = double(triple_integral);
    fprintf('Numerical value: %.10f\n', triple_integral_numeric);
    
    % Verify with numerical integration
    f_triple_numeric = @(x, y, z) x.^2 .* exp(-2*x);
    triple_integral_numeric_check = integral3(@(x,y,z) f_triple_numeric(x,y,z), a, b, y_limits(1), y_limits(2), z_limits(1), z_limits(2), 'AbsTol', epsilon, 'RelTol', epsilon);
    fprintf('Numerical verification: %.10f\n', triple_integral_numeric_check);
    fprintf('Difference: %.2e\n', abs(triple_integral_numeric - triple_integral_numeric_check));
    
catch ME
    fprintf('Error in triple integration: %s\n', ME.message);
end

fprintf('\n');

% Summary
fprintf('Summary\n');
fprintf('=======\n');
fprintf('Function analyzed: f(x) = x^2 * e^(-2x)\n');
fprintf('Integration interval: [0, 1.6]\n');
fprintf('Required accuracy: ε = 10^(-6)\n');

if exist('definite_symbolic_numeric', 'var')
    fprintf('Final definite integral value: %.10f\n', definite_symbolic_numeric);
end

if exist('double_integral_numeric', 'var')
    fprintf('Double integral value: %.10f\n', double_integral_numeric);
end

if exist('triple_integral_numeric', 'var')
    fprintf('Triple integral value: %.10f\n', triple_integral_numeric);
end

fprintf('\nTask 7 completed successfully!\n');
