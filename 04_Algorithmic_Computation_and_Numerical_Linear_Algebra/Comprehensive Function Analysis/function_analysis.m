% Task 9: Comprehensive Function Analysis
% Function: f(x) = cos(x) - exp(-x) + 0.5

% Clear workspace and command window
clear;
clc;
close all;

fprintf('Task 9: Comprehensive Function Analysis\n');
fprintf('=====================================\n\n');

% Define the function
f = @(x) cos(x) - exp(-x) + 0.5;

fprintf('Function: f(x) = cos(x) - exp(-x) + 0.5\n\n');

% Step 1: Plot the function graph
fprintf('Step 1: Plotting the Function Graph\n');
fprintf('=================================\n');

% Define plotting range
x_min = -10;
x_max = 10;
x_plot = linspace(x_min, x_max, 1000);
y_plot = f(x_plot);

% Create main plot
figure('Position', [100, 100, 1000, 700]);

% Plot the function
plot(x_plot, y_plot, 'b-', 'LineWidth', 2.5, 'DisplayName', 'f(x) = cos(x) - e^(-x) + 0.5');
hold on;

% Add horizontal line at y = 0
plot([x_min, x_max], [0, 0], 'k--', 'LineWidth', 1, 'DisplayName', 'y = 0');

% Add vertical line at x = 0
plot([0, 0], [min(y_plot)*1.1, max(y_plot)*1.1], 'r--', 'LineWidth', 1, 'DisplayName', 'x = 0');

% Enhance the plot
grid on;
grid minor;
xlabel('x', 'FontSize', 12, 'FontWeight', 'bold');
ylabel('f(x)', 'FontSize', 12, 'FontWeight', 'bold');
title('Function f(x) = cos(x) - e^(-x) + 0.5', 'FontSize', 14, 'FontWeight', 'bold');
legend('Location', 'best');
xlim([x_min, x_max]);

% Add text annotations
text(0, max(y_plot)*0.9, 'Taylor Series Center', 'FontSize', 10, ...
     'BackgroundColor', 'white', 'EdgeColor', 'black', 'Margin', 2);

fprintf('Function plotted on interval [%.1f, %.1f]\n', x_min, x_max);
fprintf('Function range: [%.3f, %.3f]\n', min(y_plot), max(y_plot));

% Step 2: Find the zeros of the function
fprintf('\nStep 2: Finding Function Zeros\n');
fprintf('=============================\n');

% Find zeros using multiple methods
zeros_found = [];

% Method 1: Find sign changes in the plot
for i = 1:length(x_plot)-1
    if y_plot(i) * y_plot(i+1) < 0  % Sign change detected
        % Refine using fzero
        try
            zero_guess = (x_plot(i) + x_plot(i+1)) / 2;
            zero_val = fzero(f, zero_guess);

            % Check if this zero is already found
            if isempty(zeros_found) || all(abs(zeros_found - zero_val) > 1e-6)
                zeros_found = [zeros_found, zero_val];
            end
        catch
            % If fzero fails, use bisection method
            zero_val = bisection_method(f, x_plot(i), x_plot(i+1), 1e-8);
            if ~isnan(zero_val) && (isempty(zeros_found) || all(abs(zeros_found - zero_val) > 1e-6))
                zeros_found = [zeros_found, zero_val];
            end
        end
    end
end

% Method 2: Try specific initial guesses
initial_guesses = -5:1:5;
for guess = initial_guesses
    try
        zero_val = fzero(f, guess);
        if ~isnan(zero_val) && (isempty(zeros_found) || all(abs(zeros_found - zero_val) > 1e-6))
            zeros_found = [zeros_found, zero_val];
        end
    catch
        % fzero failed, continue
    end
end

% Sort zeros
zeros_found = sort(zeros_found);

fprintf('Zeros found: %d\n', length(zeros_found));
for i = 1:length(zeros_found)
    fprintf('  Zero %d: x = %.6f, f(x) = %.2e\n', i, zeros_found(i), f(zeros_found(i)));
    % Add zero markers to plot
    plot(zeros_found(i), 0, 'ro', 'MarkerSize', 8, 'MarkerFaceColor', 'red');
end

% Step 3: Find the extremes (maxima and minima)
fprintf('\nStep 3: Finding Function Extremes\n');
fprintf('===============================\n');

% Calculate derivative
h = 1e-6;
f_derivative = @(x) (f(x + h) - f(x - h)) / (2*h);

% Find critical points (where derivative = 0)
critical_points = [];

% Find sign changes in derivative
y_derivative = f_derivative(x_plot);
for i = 1:length(x_plot)-1
    if y_derivative(i) * y_derivative(i+1) < 0  % Sign change in derivative
        try
            critical_guess = (x_plot(i) + x_plot(i+1)) / 2;
            critical_val = fzero(f_derivative, critical_guess);

            % Check if this critical point is already found
            if isempty(critical_points) || all(abs(critical_points - critical_val) > 1e-6)
                critical_points = [critical_points, critical_val];
            end
        catch
            % If fzero fails, use bisection
            critical_val = bisection_method(f_derivative, x_plot(i), x_plot(i+1), 1e-8);
            if ~isnan(critical_val) && (isempty(critical_points) || all(abs(critical_points - critical_val) > 1e-6))
                critical_points = [critical_points, critical_val];
            end
        end
    end
end

% Sort critical points
critical_points = sort(critical_points);

% Classify critical points as maxima or minima
maxima = [];
minima = [];

for i = 1:length(critical_points)
    x_cp = critical_points(i);
    y_cp = f(x_cp);

    % Second derivative test
    h2 = 1e-4;
    second_derivative = (f(x_cp + h2) - 2*f(x_cp) + f(x_cp - h2)) / h2^2;

    if second_derivative < 0
        maxima = [maxima, x_cp];
        fprintf('  Maximum at x = %.6f, f(x) = %.6f\n', x_cp, y_cp);
        plot(x_cp, y_cp, 'g^', 'MarkerSize', 10, 'MarkerFaceColor', 'green');
    elseif second_derivative > 0
        minima = [minima, x_cp];
        fprintf('  Minimum at x = %.6f, f(x) = %.6f\n', x_cp, y_cp);
        plot(x_cp, y_cp, 'mv', 'MarkerSize', 10, 'MarkerFaceColor', 'magenta');
    else
        fprintf('  Saddle point at x = %.6f, f(x) = %.6f\n', x_cp, y_cp);
        plot(x_cp, y_cp, 'ko', 'MarkerSize', 8, 'MarkerFaceColor', 'black');
    end
end

fprintf('Total critical points found: %d\n', length(critical_points));
fprintf('Maxima: %d, Minima: %d\n', length(maxima), length(minima));

% Step 4: Taylor series decomposition around x = 0
fprintf('\nStep 4: Taylor Series Decomposition (around x = 0)\n');
fprintf('=================================================\n');

try
    % Symbolic Taylor series
    syms x_sym;
    f_sym = cos(x_sym) - exp(-x_sym) + 0.5;

    % Calculate Taylor series up to different orders
    orders = [2, 4, 6, 8];

    fprintf('Taylor series of f(x) around x = 0:\n');
    fprintf('f(x) = cos(x) - e^(-x) + 0.5\n\n');

    for i = 1:length(orders)
        n = orders(i);
        taylor_series = taylor(f_sym, x_sym, 0, 'Order', n);
        fprintf('Order %d: %s\n', n, char(taylor_series));

        % Create function handle for plotting
        taylor_handle = matlabFunction(taylor_series);
        y_taylor = taylor_handle(x_plot);

        % Plot Taylor series approximation
        plot(x_plot, y_taylor, '--', 'LineWidth', 1.5, 'DisplayName', sprintf('Taylor Order %d', n));
    end

    % Show the general Taylor series form
    fprintf('\nGeneral Taylor series form:\n');
    fprintf('f(x) = (1 - 1 + 0.5) + (0 + 1)x + (-1/2 - 1/2)x²/2! + ...\n');
    fprintf('     = 0.5 + x - x²/2 + x³/6 - x⁴/24 + ...\n');

catch ME
    fprintf('Symbolic Taylor series not available: %s\n', ME.message);

    % Numerical Taylor series approximation
    fprintf('Numerical Taylor series approximation:\n');

    % Calculate derivatives at x = 0
    x0 = 0;
    f0 = f(x0);

    % First derivative
    h = 1e-6;
    f1 = (f(x0 + h) - f(x0 - h)) / (2*h);

    % Second derivative
    f2 = (f(x0 + h) - 2*f(x0) + f(x0 - h)) / h^2;

    % Third derivative
    f3 = (f(x0 + 2*h) - 2*f(x0 + h) + 2*f(x0 - h) - f(x0 - 2*h)) / (2*h^3);

    % Fourth derivative
    f4 = (f(x0 + 2*h) - 4*f(x0 + h) + 6*f(x0) - 4*f(x0 - h) + f(x0 - 2*h)) / h^4;

    fprintf('f(0) = %.6f\n', f0);
    fprintf('f''(0) = %.6f\n', f1);
    fprintf('f''''(0) = %.6f\n', f2);
    fprintf('f(3)(0) = %.6f\n', f3);
    fprintf('f(4)(0) = %.6f\n', f4);

    fprintf('\nTaylor series (up to 4th order):\n');
    fprintf('f(x) ≈ %.6f + %.6fx + %.6fx²/2! + %.6fx³/3! + %.6fx⁴/4!\n', ...
            f0, f1, f2, f3, f4);
end

% Step 5: Find limits as x approaches ±∞
fprintf('\nStep 5: Finding Limits at Infinity\n');
fprintf('=================================\n');

% Limit as x → +∞
fprintf('lim(x→+∞) f(x):\n');
fprintf('  As x → +∞:\n');
fprintf('    cos(x) oscillates between [-1, 1]\n');
fprintf('    exp(-x) → 0\n');
fprintf('    Therefore: f(x) → cos(x) + 0.5\n');
fprintf('    Since cos(x) oscillates, the limit does not exist\n');
fprintf('    However, the function is bounded: f(x) ∈ [-0.5, 1.5]\n');

% Numerical verification for large positive x
large_x_pos = [10, 20, 50, 100];
fprintf('\nNumerical verification for large positive x:\n');
for x_val = large_x_pos
    f_val = f(x_val);
    fprintf('  f(%.0f) = %.6f\n', x_val, f_val);
end

% Limit as x → -∞
fprintf('\nlim(x→-∞) f(x):\n');
fprintf('  As x → -∞:\n');
fprintf('    cos(x) oscillates between [-1, 1]\n');
fprintf('    exp(-x) = exp(|x|) → +∞\n');
fprintf('    Therefore: f(x) = cos(x) - exp(-x) + 0.5 → -∞\n');
fprintf('    The dominant term is -exp(-x)\n');

% Numerical verification for large negative x
large_x_neg = [-1, -2, -5, -10];
fprintf('\nNumerical verification for large negative x:\n');
for x_val = large_x_neg
    f_val = f(x_val);
    fprintf('  f(%.0f) = %.6f\n', x_val, f_val);
end

% Summary
fprintf('\nSummary\n');
fprintf('=======\n');
fprintf('Function: f(x) = cos(x) - exp(-x) + 0.5\n');
fprintf('Zeros found: %d\n', length(zeros_found));
fprintf('Critical points: %d\n', length(critical_points));
fprintf('Taylor series center: x = 0\n');
fprintf('lim(x→+∞) f(x): Does not exist (oscillatory)\n');
fprintf('lim(x→-∞) f(x): -∞\n');

% Final plot enhancements
legend('Location', 'best');
title('Function Analysis: f(x) = cos(x) - e^(-x) + 0.5', 'FontSize', 14, 'FontWeight', 'bold');

fprintf('\nTask 9 completed successfully!\n');

% Helper function for bisection method
function root = bisection_method(f, a, b, tol)
    if f(a) * f(b) >= 0
        root = NaN;
        return;
    end

    max_iter = 100;
    iter = 0;

    while (b - a) > tol && iter < max_iter
        c = (a + b) / 2;
        if f(c) == 0
            root = c;
            return;
        elseif f(a) * f(c) < 0
            b = c;
        else
            a = c;
        end
        iter = iter + 1;
    end

    root = (a + b) / 2;
end
