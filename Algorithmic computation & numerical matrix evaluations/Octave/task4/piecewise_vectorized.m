% Task 4: Piecewise Function Plot - Octave Advanced Approach
% Using range formation and vectorized operations for group processing

% Clear workspace and close figures
clear;
clc;
close all;

fprintf('Task 4: Piecewise Function Plot - Octave Advanced Approach\n');
fprintf('==========================================================\n\n');

% Define the piecewise function:
% For x <= 0: y = 3*sin(x) - cos^2(x)
% For x > 0: y = (3*sqrt(1 + x^2)) / ln(x + 5)

% Step 1: Define x range using Octave's range formation
x_min = -5;
x_max = 5;
num_points = 1000;

% Create x array using range formation
x = linspace(x_min, x_max, num_points)';

fprintf('Using vectorized operations with %d points...\n', num_points);

% Step 2: Calculate y values using Octave's advanced capabilities
% Use logical indexing for vectorized conditional operations

% Create logical masks for different regions
mask_negative = x <= 0;
mask_positive = x > 0;

% Initialize y array
y = zeros(size(x));

% Vectorized calculation for each region
y(mask_negative) = 3*sin(x(mask_negative)) - cos(x(mask_negative)).^2;
y(mask_positive) = (3*sqrt(1 + x(mask_positive).^2)) ./ log(x(mask_positive) + 5);

% Alternative approach using arrayfun (demonstrates another Octave capability)
% y = arrayfun(@(x_val) piecewise_function(x_val), x);

fprintf('Vectorized calculation completed.\n\n');

% Step 3: Create enhanced plot with advanced visualization
fprintf('Creating enhanced plot with advanced visualization...\n\n');

% Create figure with advanced properties
figure('Position', [150, 150, 900, 700], 'Color', 'white');

% Create subplot layout for better analysis
subplot(2, 1, 1);

% Plot the main function
plot(x, y, 'b-', 'LineWidth', 2.5, 'DisplayName', 'f(x)');

% Advanced plot customization
grid on;
grid minor;
box on;

% Set enhanced axis properties
xlim([x_min, x_max]);
ylim([-6, 10]);

% Enhanced labels and title
xlabel('x', 'FontSize', 12, 'FontWeight', 'bold', 'Color', 'black');
ylabel('f(x)', 'FontSize', 12, 'FontWeight', 'bold', 'Color', 'black');
title('Piecewise Function: Vectorized Approach', 'FontSize', 14, 'FontWeight', 'bold');

% Add transition point visualization
hold on;
plot([0, 0], ylim, 'r--', 'LineWidth', 2, 'DisplayName', 'Transition at x=0');
plot(0, y(abs(x) < 0.01), 'ro', 'MarkerSize', 8, 'MarkerFaceColor', 'red', ...
     'DisplayName', 'f(0)');
hold off;

% Enhanced legend
legend('Location', 'best', 'FontSize', 10);

% Add function annotations with LaTeX-style formatting
annotation('textbox', [0.15, 0.75, 0.25, 0.1], 'String', ...
           'y = 3sin(x) - cos²(x (x ≤ 0)', ...
           'FontSize', 10, 'BackgroundColor', [1, 1, 0.9], 'EdgeColor', 'black');
annotation('textbox', [0.65, 0.75, 0.3, 0.1], 'String', ...
           'y = 3√(1+x²)/ln(x+5) (x > 0)', ...
           'FontSize', 10, 'BackgroundColor', [1, 1, 0.9], 'EdgeColor', 'black');

% Step 4: Add derivative plot for enhanced analysis
subplot(2, 1, 2);

% Calculate numerical derivative using gradient function
dy_dx = gradient(y, x);

plot(x, dy_dx, 'g-', 'LineWidth', 2, 'DisplayName', "f'(x)");
grid on;
grid minor;
box on;

xlim([x_min, x_max]);
xlabel('x', 'FontSize', 12, 'FontWeight', 'bold');
ylabel("f'(x)", 'FontSize', 12, 'FontWeight', 'bold');
title('Numerical Derivative', 'FontSize', 12, 'FontWeight', 'bold');

% Add horizontal line at y=0
hold on;
plot(xlim, [0, 0], 'k--', 'LineWidth', 1);
hold off;

legend('Location', 'best');

% Step 5: Advanced analysis and statistics
fprintf('Advanced Function Analysis:\n');
fprintf('==========================\n');

% Function statistics using vectorized operations
fprintf('Statistics:\n');
fprintf('  Mean value: %.4f\n', mean(y));
fprintf('  Standard deviation: %.4f\n', std(y));
fprintf('  Range: [%.4f, %.4f]\n', min(y), max(y));

% Find critical points (where derivative is close to zero)
critical_points = x(abs(dy_dx) < 0.01);
fprintf('  Approximate critical points: ');
fprintf('%.2f ', critical_points(1:min(5, length(critical_points))));
fprintf('\n');

% Calculate definite integrals for each region
integral_negative = trapz(x(mask_negative), y(mask_negative));
integral_positive = trapz(x(mask_positive), y(mask_positive));
fprintf('\nDefinite Integrals:\n');
fprintf('  ∫_{-5}^{0} f(x)dx = %.4f\n', integral_negative);
fprintf('  ∫_{0}^{5} f(x)dx = %.4f\n', integral_positive);
fprintf('  ∫_{-5}^{5} f(x)dx = %.4f\n', integral_negative + integral_positive);

% Performance comparison
fprintf('\nPerformance Benefits of Vectorization:\n');
fprintf('=====================================\n');
fprintf('  - No explicit loops required\n');
fprintf('  - Simultaneous processing of all elements\n');
fprintf('  - More efficient memory usage\n');
fprintf('  - Cleaner, more readable code\n');

fprintf('\nOctave advanced approach completed successfully!\n');
fprintf('The enhanced visualization shows both the function and its derivative.\n');

% Define the piecewise function as a separate function for arrayfun
function y = piecewise_function(x)
    if x <= 0
        y = 3*sin(x) - cos(x)^2;
    else
        y = (3*sqrt(1 + x^2)) / log(x + 5);
    end
end
