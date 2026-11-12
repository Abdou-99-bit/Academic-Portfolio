% Simple test script for Task 8 differential equation solver
% This script provides basic verification of the main functionality

% Clear workspace
clear;
clc;

fprintf('Simple Test for Task 8 Differential Equation Solver\n');
fprintf('================================================\n\n');

% Define the differential equation parameters
% y'' - y = 2e^x - x^2
% Initial conditions: y(0) = 0, y'(0) = 0
% Interval: [0, 2]

x_start = 0;
x_end = 2;
y0_1 = 0;  % y(0) = 0
y0_2 = 0;  % y'(0) = 0

fprintf('Differential equation: y'''' - y = 2e^x - x^2\n');
fprintf('Initial conditions: y(0) = %.1f, y''(0) = %.1f\n', y0_1, y0_2);
fprintf('Interval: [%.1f, %.1f]\n\n', x_start, x_end);

% Test 1: Basic numerical solution
fprintf('Test 1: Basic Numerical Solution\n');
fprintf('-------------------------------\n');

% Define ODE system
ode_system = @(x, y) [y(2); y(1) + 2*exp(x) - x^2];

% Solve using ode45
options = odeset('RelTol', 1e-6, 'AbsTol', 1e-8);
[x_num, y_num] = ode45(ode_system, [x_start, x_end], [y0_1, y0_2], options);

fprintf('ode45 solution computed successfully\n');
fprintf('Number of points: %d\n', length(x_num));
fprintf('x range: [%.6f, %.6f]\n', min(x_num), max(x_num));
fprintf('y range: [%.6f, %.6f]\n', min(y_num(:,1)), max(y_num(:,1)));

% Check initial conditions
fprintf('Initial condition check:\n');
fprintf('  y(0) = %.6f (should be %.1f)\n', y_num(1,1), y0_1);
fprintf('  y''(0) = %.6f (should be %.1f)\n', y_num(1,2), y0_2);

% Check differential equation at some points
fprintf('Differential equation verification at sample points:\n');
test_points = [0, 0.5, 1.0, 1.5, 2.0];
for i = 1:length(test_points)
    x_test = test_points(i);
    % Find closest solution point
    [~, idx] = min(abs(x_num - x_test));
    y_val = y_num(idx, 1);
    y_prime_val = y_num(idx, 2);
    
    % Calculate y'' from ODE: y'' = y + 2e^x - x^2
    y_double_prime = y_val + 2*exp(x_test) - x_test^2;
    
    % Check if y'' - y ≈ 2e^x - x^2
    lhs = y_double_prime - y_val;
    rhs = 2*exp(x_test) - x_test^2;
    error = abs(lhs - rhs);
    
    fprintf('  x=%.1f: y''-y = %.6f, RHS = %.6f, error = %.2e\n', ...
            x_test, lhs, rhs, error);
end

fprintf('\n');

% Test 2: Symbolic solution (if available)
fprintf('Test 2: Symbolic Solution\n');
fprintf('-----------------------\n');

try
    syms y(x) x;
    
    % Define and solve ODE
    ode = diff(y, 2) - y == 2*exp(x) - x^2;
    y_general = dsolve(ode);
    
    fprintf('General solution: %s\n', char(y_general));
    
    % Apply initial conditions
    Dy = diff(y_general, x);
    constants = solve([subs(y_general, x, 0) == y0_1, ...
                      subs(Dy, x, 0) == y0_2], [sym('C1'), sym('C2')]);
    
    if ~isempty(constants)
        y_particular = subs(y_general, constants);
        fprintf('Particular solution: %s\n', char(y_particular));
        
        % Evaluate at some points
        y_handle = matlabFunction(y_particular);
        
        fprintf('Symbolic solution values:\n');
        for i = 1:length(test_points)
            x_test = test_points(i);
            y_sym = y_handle(x_test);
            fprintf('  y(%.1f) = %.6f\n', x_test, y_sym);
        end
        
    else
        fprintf('Could not apply initial conditions\n');
    end
    
catch ME
    fprintf('Symbolic solution not available: %s\n', ME.message);
end

fprintf('\n');

% Test 3: Method comparison
fprintf('Test 3: Method Comparison\n');
fprintf('--------------------------\n');

% Solve with different methods
[x_23, y_23] = ode23(ode_system, [x_start, x_end], [y0_1, y0_2], options);
[x_15s, y_15s] = ode15s(ode_system, [x_start, x_end], [y0_1, y0_2], options);

% Compare at common points
x_common = linspace(x_start, x_end, 20);
y_45_interp = interp1(x_num, y_num(:,1), x_common);
y_23_interp = interp1(x_23, y_23(:,1), x_common);
y_15s_interp = interp1(x_15s, y_15s(:,1), x_common);

max_diff_23 = max(abs(y_45_interp - y_23_interp));
max_diff_15s = max(abs(y_45_interp - y_15s_interp));

fprintf('Maximum differences between methods:\n');
fprintf('  ode45 vs ode23: %.2e\n', max_diff_23);
fprintf('  ode45 vs ode15s: %.2e\n', max_diff_15s);

fprintf('\n');

% Test 4: Simple Euler method
fprintf('Test 4: Simple Euler Method\n');
fprintf('--------------------------\n');

n_steps = 100;
h = (x_end - x_start) / n_steps;
x_euler = linspace(x_start, x_end, n_steps + 1);
y_euler = zeros(n_steps + 1, 2);
y_euler(1, :) = [y0_1, y0_2];

for i = 1:n_steps
    dy = ode_system(x_euler(i), y_euler(i, :)');
    y_euler(i + 1, :) = y_euler(i, :) + h * dy';
end

% Compare with ode45 at end point
y_45_end = interp1(x_num, y_num(:,1), x_end);
y_euler_end = y_euler(end, 1);
error_euler = abs(y_45_end - y_euler_end);

fprintf('Euler method comparison at x = %.1f:\n', x_end);
fprintf('  ode45: %.6f\n', y_45_end);
fprintf('  Euler: %.6f\n', y_euler_end);
fprintf('  Error: %.2e\n', error_euler);

fprintf('\n');

% Test 5: Basic plot
fprintf('Test 5: Basic Visualization\n');
fprintf('---------------------------\n');

try
    figure('Position', [100, 100, 800, 600]);
    
    % Plot main solution
    plot(x_num, y_num(:,1), 'b-', 'LineWidth', 2.5, 'DisplayName', 'ode45');
    hold on;
    
    % Plot other methods
    plot(x_23, y_23(:,1), 'g--', 'LineWidth', 2, 'DisplayName', 'ode23');
    plot(x_15s, y_15s(:,1), 'm:', 'LineWidth', 2, 'DisplayName', 'ode15s');
    plot(x_euler, y_euler(:,1), 'c-', 'LineWidth', 1.5, 'DisplayName', 'Euler');
    
    % Add initial condition marker
    plot(x_start, y0_1, 'ko', 'MarkerSize', 8, 'MarkerFaceColor', 'red', ...
         'DisplayName', 'Initial Condition');
    
    grid on;
    xlabel('x', 'FontSize', 12, 'FontWeight', 'bold');
    ylabel('y(x)', 'FontSize', 12, 'FontWeight', 'bold');
    title('Differential Equation Solutions - Basic Test', 'FontSize', 14, 'FontWeight', 'bold');
    legend('Location', 'best');
    xlim([x_start, x_end]);
    
    fprintf('Basic comparison plot created successfully\n');
    
catch ME
    fprintf('Plot creation failed: %s\n', ME.message);
end

fprintf('\n✓ Simple tests completed!\n');
fprintf('Run "differential_solver" for comprehensive analysis.\n');
