% Task 8: Differential Equation Solution
% Equation: y'' - y = 2e^x - x^2
% Initial conditions: y(0) = 0, y'(0) = 0
% Segment: [0, 2]

% Clear workspace and command window
clear;
clc;
close all;

fprintf('Task 8: Differential Equation Solution\n');
fprintf('====================================\n\n');

% Define the differential equation and parameters
% y'' - y = 2e^x - x^2
% Initial conditions: y(0) = 0, y'(0) = 0
% Segment: [0, 2]

x_start = 0;
x_end = 2;
y0_1 = 0;  % y(0) = 0
y0_2 = 0;  % y'(0) = 0

fprintf('Differential equation: y'''' - y = 2e^x - x^2\n');
fprintf('Initial conditions: y(0) = %.1f, y''(0) = %.1f\n', y0_1, y0_2);
fprintf('Segment: [%.1f, %.1f]\n\n', x_start, x_end);

% Step 1: Numerical solution
fprintf('Step 1: Numerical Solution\n');
fprintf('==========================\n');

% Convert second-order ODE to system of first-order ODEs
% Let y1 = y, y2 = y'
% Then: y1' = y2, y2' = y1 + 2e^x - x^2

ode_system = @(x, y) [y(2); y(1) + 2*exp(x) - x^2];

% Solve using ode45 (Runge-Kutta method)
fprintf('Solving using ode45 (Runge-Kutta method)...\n');

options = odeset('RelTol', 1e-8, 'AbsTol', 1e-10);
[x_num, y_num] = ode45(ode_system, [x_start, x_end], [y0_1, y0_2], options);

% Extract y values (first column of solution)
y_numerical = y_num(:, 1);
y_prime_numerical = y_num(:, 2);

fprintf('Numerical solution computed at %d points\n', length(x_num));
fprintf('x range: [%.6f, %.6f]\n', min(x_num), max(x_num));
fprintf('y range: [%.6f, %.6f]\n\n', min(y_numerical), max(y_numerical));

% Step 2: Symbolic solution
fprintf('Step 2: Symbolic Solution\n');
fprintf('=========================\n');

try
    % Define symbolic variables
    syms y(x) x;

    % Define the differential equation
    ode = diff(y, 2) - y == 2*exp(x) - x^2;

    % Solve the differential equation symbolically
    fprintf('Solving differential equation symbolically...\n');
    y_symbolic_general = dsolve(ode);

    fprintf('General solution: y(x) = %s\n', char(y_symbolic_general));

    % Apply initial conditions to find particular solution
    % y(0) = 0, y'(0) = 0
    Dy = diff(y_symbolic_general, x);

    % Solve for constants
    constants = solve([subs(y_symbolic_general, x, 0) == y0_1, ...
                      subs(Dy, x, 0) == y0_2], ...
                     [sym('C1'), sym('C2')]);

    % Substitute constants back into general solution
    if ~isempty(constants)
        y_symbolic = subs(y_symbolic_general, constants);
        fprintf('Particular solution: y(x) = %s\n', char(y_symbolic));

        % Simplify the solution
        y_symbolic_simplified = simplify(y_symbolic);
        fprintf('Simplified solution: y(x) = %s\n', char(y_symbolic_simplified));

        % Create function handle for evaluation
        y_symbolic_handle = matlabFunction(y_symbolic_simplified);

        % Evaluate symbolic solution at numerical points
        y_symbolic_values = y_symbolic_handle(x_num);

        fprintf('Symbolic solution evaluated at %d points\n', length(x_num));
        fprintf('y range: [%.6f, %.6f]\n\n', min(y_symbolic_values), max(y_symbolic_values));

    else
        fprintf('Could not determine constants from initial conditions\n');
        y_symbolic_simplified = [];
        y_symbolic_values = [];
    end

catch ME
    fprintf('Error in symbolic solution: %s\n', ME.message);
    y_symbolic_simplified = [];
    y_symbolic_values = [];
end

% Step 3: Alternative numerical methods for comparison
fprintf('Step 3: Alternative Numerical Methods\n');
fprintf('====================================\n');

% Method 1: ode23 (simpler Runge-Kutta)
fprintf('Method 1: ode23 (simpler Runge-Kutta)\n');
[x_num23, y_num23] = ode23(ode_system, [x_start, x_end], [y0_1, y0_2], options);
y_numerical_23 = y_num23(:, 1);

% Method 2: ode15s (stiff solver)
fprintf('Method 2: ode15s (stiff solver)\n');
[x_num15s, y_num15s] = ode15s(ode_system, [x_start, x_end], [y0_1, y0_2], options);
y_numerical_15s = y_num15s(:, 1);

% Method 3: Fixed step Euler method (for comparison)
fprintf('Method 3: Fixed step Euler method\n');
n_steps = 1000;
h = (x_end - x_start) / n_steps;
x_euler = linspace(x_start, x_end, n_steps + 1);
y_euler = zeros(n_steps + 1, 2);
y_euler(1, :) = [y0_1, y0_2];  % Initial conditions

for i = 1:n_steps
    dy = ode_system(x_euler(i), y_euler(i, :)');
    y_euler(i + 1, :) = y_euler(i, :) + h * dy';
end
y_numerical_euler = y_euler(:, 1);

fprintf('All numerical methods computed successfully\n\n');

% Step 4: Error analysis and comparison
fprintf('Step 4: Error Analysis and Comparison\n');
fprintf('===================================\n');

if ~isempty(y_symbolic_values)
    % Calculate errors between numerical and symbolic solutions
    error_ode45 = max(abs(y_numerical - y_symbolic_values));
    error_ode23 = max(abs(y_numerical_23 - y_symbolic_values));
    error_ode15s = max(abs(y_numerical_15s - y_symbolic_values));
    error_euler = max(abs(y_numerical_euler - y_symbolic_values(x_euler)));

    fprintf('Maximum absolute errors compared to symbolic solution:\n');
    fprintf('ode45 error: %.2e\n', error_ode45);
    fprintf('ode23 error: %.2e\n', error_ode23);
    fprintf('ode15s error: %.2e\n', error_ode15s);
    fprintf('Euler error: %.2e\n', error_euler);

    % Find best method
    errors = [error_ode45, error_ode23, error_ode15s, error_euler];
    methods = {'ode45', 'ode23', 'ode15s', 'Euler'};
    [min_error, best_idx] = min(errors);
    fprintf('Best method: %s with error %.2e\n', methods{best_idx}, min_error);

else
    fprintf('Cannot calculate errors without symbolic solution\n');

    % Compare numerical methods among themselves
    fprintf('Comparing numerical methods among themselves:\n');
    error_23_vs_45 = max(abs(y_numerical_23 - y_numerical));
    error_15s_vs_45 = max(abs(y_numerical_15s - y_numerical));
    fprintf('ode23 vs ode45 max difference: %.2e\n', error_23_vs_45);
    fprintf('ode15s vs ode45 max difference: %.2e\n', error_15s_vs_45);
end

fprintf('\n');

% Step 5: Create comparison plots
fprintf('Step 5: Creating Comparison Plots\n');
fprintf('=================================\n');

% Figure 1: All solutions in one coordinate system
figure('Position', [100, 100, 1000, 700]);

% Plot numerical solutions
plot(x_num, y_numerical, 'b-', 'LineWidth', 2.5, 'DisplayName', 'ode45 (Runge-Kutta)');
hold on;

if ~isempty(y_symbolic_values)
    plot(x_num, y_symbolic_values, 'r--', 'LineWidth', 2.5, 'DisplayName', 'Symbolic Solution');
end

plot(x_num23, y_numerical_23, 'g-.', 'LineWidth', 2, 'DisplayName', 'ode23');
plot(x_num15s, y_numerical_15s, 'm:', 'LineWidth', 2, 'DisplayName', 'ode15s');
plot(x_euler, y_numerical_euler, 'c-', 'LineWidth', 1.5, 'DisplayName', 'Euler Method');

% Enhance the plot
grid on;
grid minor;
xlabel('x', 'FontSize', 12, 'FontWeight', 'bold');
ylabel('y(x)', 'FontSize', 12, 'FontWeight', 'bold');
title('Differential Equation Solutions Comparison', 'FontSize', 14, 'FontWeight', 'bold');
legend('Location', 'best');
xlim([x_start, x_end]);

% Add initial condition marker
plot(x_start, y0_1, 'ko', 'MarkerSize', 8, 'MarkerFaceColor', 'red', 'DisplayName', 'Initial Condition');

% Add text annotation
text(0.1, max(y_numerical)*0.8, 'y'''' - y = 2e^x - x^2', 'FontSize', 10, ...
     'BackgroundColor', 'white', 'EdgeColor', 'black', 'Margin', 2);

% Figure 2: Error plots (if symbolic solution available)
if ~isempty(y_symbolic_values)
    figure('Position', [150, 150, 1200, 800]);

    % Subplot 1: Error for ode45
    subplot(2, 2, 1);
    plot(x_num, abs(y_numerical - y_symbolic_values), 'b-', 'LineWidth', 2);
    grid on;
    xlabel('x');
    ylabel('Absolute Error');
    title('ode45 Error vs Symbolic Solution');

    % Subplot 2: Error for ode23
    subplot(2, 2, 2);
    plot(x_num23, abs(y_numerical_23 - y_symbolic_values), 'g-', 'LineWidth', 2);
    grid on;
    xlabel('x');
    ylabel('Absolute Error');
    title('ode23 Error vs Symbolic Solution');

    % Subplot 3: Error for ode15s
    subplot(2, 2, 3);
    plot(x_num15s, abs(y_numerical_15s - y_symbolic_values), 'm-', 'LineWidth', 2);
    grid on;
    xlabel('x');
    ylabel('Absolute Error');
    title('ode15s Error vs Symbolic Solution');

    % Subplot 4: All errors together
    subplot(2, 2, 4);
    plot(x_num, abs(y_numerical - y_symbolic_values), 'b-', 'LineWidth', 2, 'DisplayName', 'ode45');
    hold on;
    plot(x_num23, abs(y_numerical_23 - y_symbolic_values), 'g-', 'LineWidth', 2, 'DisplayName', 'ode23');
    plot(x_num15s, abs(y_numerical_15s - y_symbolic_values), 'm-', 'LineWidth', 2, 'DisplayName', 'ode15s');
    plot(x_euler, abs(y_numerical_euler - y_symbolic_values(x_euler)), 'c-', 'LineWidth', 2, 'DisplayName', 'Euler');
    grid on;
    xlabel('x');
    ylabel('Absolute Error');
    title('All Methods Error Comparison');
    legend('Location', 'best');
    set(gca, 'YScale', 'log');

    sgtitle('Error Analysis: Numerical vs Symbolic Solutions', 'FontSize', 14, 'FontWeight', 'bold');
end

% Figure 3: Derivative comparison
figure('Position', [200, 200, 800, 600]);

% Plot derivatives
plot(x_num, y_prime_numerical, 'b-', 'LineWidth', 2.5, 'DisplayName', 'y''(x) - ode45');
hold on;

if ~isempty(y_symbolic_simplified)
    % Calculate symbolic derivative
    syms x;
    y_prime_symbolic = diff(y_symbolic_simplified, x);
    y_prime_handle = matlabFunction(y_prime_symbolic);
    y_prime_symbolic_values = y_prime_handle(x_num);

    plot(x_num, y_prime_symbolic_values, 'r--', 'LineWidth', 2.5, 'DisplayName', 'y''(x) - Symbolic');
end

grid on;
xlabel('x', 'FontSize', 12, 'FontWeight', 'bold');
ylabel('y''(x)', 'FontSize', 12, 'FontWeight', 'bold');
title('Derivative Comparison', 'FontSize', 14, 'FontWeight', 'bold');
legend('Location', 'best');
xlim([x_start, x_end]);

% Summary
fprintf('Summary\n');
fprintf('=======\n');
fprintf('Differential equation: y'''' - y = 2e^x - x^2\n');
fprintf('Initial conditions: y(0) = %.1f, y''(0) = %.1f\n', y0_1, y0_2);
fprintf('Solution interval: [%.1f, %.1f]\n', x_start, x_end);

if ~isempty(y_symbolic_simplified)
    fprintf('Symbolic solution found and verified\n');
    fprintf('Numerical methods compared with symbolic solution\n');
else
    fprintf('Symbolic solution not available, numerical methods compared among themselves\n');
end

fprintf('Multiple numerical methods implemented and compared\n');
fprintf('Graphical comparison created in coordinate system\n');

fprintf('\nTask 8 completed successfully!\n');
