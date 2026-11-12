% Simple test script for Task 9 function analysis
% This script provides basic verification of the main functionality

% Clear workspace
clear;
clc;

fprintf('Simple Test for Task 9 Function Analysis\n');
fprintf('======================================\n\n');

% Define the function
f = @(x) cos(x) - exp(-x) + 0.5;

fprintf('Function: f(x) = cos(x) - exp(-x) + 0.5\n\n');

% Test 1: Basic function evaluation
fprintf('Test 1: Basic Function Evaluation\n');
fprintf('--------------------------------\n');

test_points = [-2, -1, 0, 1, 2];
for i = 1:length(test_points)
    x_val = test_points(i);
    y_val = f(x_val);
    fprintf('f(%.1f) = %.6f\n', x_val, y_val);
end

fprintf('\n');

% Test 2: Zero finding verification
fprintf('Test 2: Zero Finding Verification\n');
fprintf('---------------------------------\n');

% Test around expected zero near x = -0.5
x_range = linspace(-2, 2, 100);
y_range = f(x_range);

% Find sign changes
zeros_test = [];
for i = 1:length(x_range)-1
    if y_range(i) * y_range(i+1) < 0
        zeros_test = [zeros_test, (x_range(i) + x_range(i+1))/2];
    end
end

fprintf('Sign changes detected at: ');
fprintf('%.3f ', zeros_test);
fprintf('\n');

% Verify zeros using fzero
for i = 1:length(zeros_test)
    try
        zero_val = fzero(f, zeros_test(i));
        fprintf('Refined zero: %.6f, f(x) = %.2e\n', zero_val, f(zero_val));
    catch
        fprintf('fzero failed at guess %.3f\n', zeros_test(i));
    end
end

fprintf('\n');

% Test 3: Derivative calculation
fprintf('Test 3: Derivative Calculation\n');
fprintf('------------------------------\n');

% Numerical derivative
h = 1e-6;
f_derivative = @(x) (f(x + h) - f(x - h)) / (2*h);

test_derivatives = [-1, 0, 1];
for i = 1:length(test_derivatives)
    x_val = test_derivatives(i);
    deriv_val = f_derivative(x_val);
    fprintf('f''(%.1f) = %.6f\n', x_val, deriv_val);
end

fprintf('\n');

% Test 4: Taylor series approximation
fprintf('Test 4: Taylor Series Approximation\n');
fprintf('---------------------------------\n');

% Calculate derivatives at x = 0
x0 = 0;
f0 = f(x0);
f1 = f_derivative(x0);
f2 = (f(x0 + h) - 2*f(x0) + f(x0 - h)) / h^2;
f3 = (f(x0 + 2*h) - 2*f(x0 + h) + 2*f(x0 - h) - f(x0 - 2*h)) / (2*h^3);

fprintf('Derivatives at x = 0:\n');
fprintf('f(0) = %.6f\n', f0);
fprintf('f''(0) = %.6f\n', f1);
fprintf('f''''(0) = %.6f\n', f2);
fprintf('f'''''(0) = %.6f\n', f3);

% Taylor series approximation (up to 3rd order)
taylor_approx = @(x) f0 + f1*x + f2*x^2/2 + f3*x^3/6;

test_taylor = [-0.5, -0.2, 0.2, 0.5];
fprintf('\nTaylor series approximation test:\n');
for i = 1:length(test_taylor)
    x_val = test_taylor(i);
    actual = f(x_val);
    approx = taylor_approx(x_val);
    error = abs(actual - approx);
    fprintf('x = %.1f: Actual = %.6f, Approx = %.6f, Error = %.2e\n', ...
            x_val, actual, approx, error);
end

fprintf('\n');

% Test 5: Limit behavior
fprintf('Test 5: Limit Behavior\n');
fprintf('---------------------\n');

% Test large positive x
large_pos = [5, 10, 20];
fprintf('Behavior as x → +∞:\n');
for x_val = large_pos
    y_val = f(x_val);
    fprintf('f(%.0f) = %.6f (should be bounded)\n', x_val, y_val);
end

% Test large negative x
large_neg = [-1, -2, -5];
fprintf('\nBehavior as x → -∞:\n');
for x_val = large_neg
    y_val = f(x_val);
    fprintf('f(%.0f) = %.6f (should tend to -∞)\n', x_val, y_val);
end

fprintf('\n');

% Test 6: Basic plotting
fprintf('Test 6: Basic Plotting\n');
fprintf('--------------------\n');

try
    figure('Position', [100, 100, 800, 600]);
    
    % Create basic plot
    x_plot = linspace(-5, 5, 200);
    y_plot = f(x_plot);
    
    plot(x_plot, y_plot, 'b-', 'LineWidth', 2);
    hold on;
    plot([x_plot(1), x_plot(end)], [0, 0], 'k--', 'LineWidth', 1);
    plot([0, 0], [min(y_plot)*1.1, max(y_plot)*1.1], 'r--', 'LineWidth', 1);
    
    grid on;
    xlabel('x');
    ylabel('f(x)');
    title('f(x) = cos(x) - exp(-x) + 0.5');
    
    fprintf('Basic plot created successfully\n');
    
    % Add some markers
    for i = 1:length(zeros_test)
        try
            zero_val = fzero(f, zeros_test(i));
            plot(zero_val, 0, 'ro', 'MarkerSize', 6, 'MarkerFaceColor', 'red');
        catch
            % Skip if fzero fails
        end
    end
    
    legend('f(x)', 'y = 0', 'x = 0', 'Zeros', 'Location', 'best');
    
catch ME
    fprintf('Plot creation failed: %s\n', ME.message);
end

fprintf('\n');

% Test 7: Function properties
fprintf('Test 7: Function Properties\n');
fprintf('--------------------------\n');

% Check periodicity of cos component
fprintf('cos(x) component:\n');
fprintf('  Period: 2π ≈ %.6f\n', 2*pi);
fprintf('  Range: [-1, 1]\n');

% Check exponential component
fprintf('exp(-x) component:\n');
fprintf('  Monotonically decreasing\n');
fprintf('  Range: (0, +∞)\n');

% Combined function behavior
fprintf('Combined function:\n');
fprintf('  As x → +∞: f(x) → cos(x) + 0.5 (oscillatory)\n');
fprintf('  As x → -∞: f(x) → -∞\n');
fprintf('  At x = 0: f(0) = %.6f\n', f(0));

fprintf('\n✓ Simple tests completed!\n');
fprintf('Run "function_analysis" for comprehensive analysis.\n');
