% Task 4: Piecewise Function Plot - Standard Approach
% Using loops and conditional operators for element-wise array processing

% Clear workspace and close figures
clear;
clc;
close all;

fprintf('Task 4: Piecewise Function Plot - Standard Approach\n');
fprintf('===================================================\n\n');

% Define the piecewise function:
% For x <= 0: y = 3*sin(x) - cos^2(x)
% For x > 0: y = (3*sqrt(1 + x^2)) / ln(x + 5)

% Step 1: Define x range with appropriate resolution
x_min = -5;
x_max = 5;
num_points = 1000;

% Create x array using standard approach
x = linspace(x_min, x_max, num_points);
y = zeros(size(x));  % Initialize y array

% Step 2: Calculate y values using loops and conditional operators
fprintf('Calculating function values using standard approach...\n');

for i = 1:length(x)
    if x(i) <= 0
        % For x <= 0: y = 3*sin(x) - cos^2(x)
        y(i) = 3*sin(x(i)) - cos(x(i))^2;
    else
        % For x > 0: y = (3*sqrt(1 + x^2)) / ln(x + 5)
        y(i) = (3*sqrt(1 + x(i)^2)) / log(x(i) + 5);
    end
end

% Step 3: Create the plot with optimized parameters
fprintf('Creating plot with optimized visualization parameters...\n\n');

% Create figure with appropriate size
figure('Position', [100, 100, 800, 600]);

% Plot the function
plot(x, y, 'b-', 'LineWidth', 2.5, 'DisplayName', 'Piecewise Function');

% Enhance the plot for better visualization
grid on;
grid minor;

% Set appropriate axis limits and labels
xlim([x_min, x_max]);
ylim([-5, 8]);  % Adjusted based on function analysis

xlabel('x', 'FontSize', 12, 'FontWeight', 'bold');
ylabel('y = f(x)', 'FontSize', 12, 'FontWeight', 'bold');
title('Piecewise Function: Standard Approach', 'FontSize', 14, 'FontWeight', 'bold');

% Add legend
legend('Location', 'best');

% Add text annotations for function definitions
text(-4, 6, 'y = 3sin(x) - cos²(x)', 'FontSize', 10, 'BackgroundColor', 'white', ...
     'EdgeColor', 'black', 'Margin', 2);
text(2, 6, 'y = \frac{3\sqrt{1+x²}}{ln(x+5)}', 'FontSize', 10, 'BackgroundColor', 'white', ...
     'EdgeColor', 'black', 'Margin', 2);

% Add vertical line at x = 0 to show the transition point
hold on;
plot([0, 0], ylim, 'r--', 'LineWidth', 1.5, 'DisplayName', 'x = 0 (Transition)');
hold off;

% Set figure properties
set(gca, 'FontSize', 11);
set(gcf, 'Color', 'white');

% Step 4: Display function information
fprintf('Function Information:\n');
fprintf('====================\n');
fprintf('Domain: [%.1f, %.1f]\n', x_min, x_max);
fprintf('Number of points: %d\n', num_points);
fprintf('Function definition:\n');
fprintf('  For x <= 0: y = 3*sin(x) - cos^2(x)\n');
fprintf('  For x > 0:  y = (3*sqrt(1 + x^2)) / ln(x + 5)\n\n');

% Calculate and display some key points
fprintf('Key Points:\n');
fprintf('-----------\n');
fprintf('f(0) = %.4f\n', y(find(x >= 0, 1)));
fprintf('f(-1) = %.4f\n', y(find(x <= -1, 1, 'last')));
fprintf('f(1) = %.4f\n', y(find(x >= 1, 1)));
fprintf('f(-2) = %.4f\n', y(find(x <= -2, 1, 'last')));
fprintf('f(2) = %.4f\n', y(find(x >= 2, 1)));

% Find minimum and maximum values
[y_min, idx_min] = min(y);
[y_max, idx_max] = max(y);
fprintf('\nExtrema:\n');
fprintf('--------\n');
fprintf('Minimum value: %.4f at x = %.4f\n', y_min, x(idx_min));
fprintf('Maximum value: %.4f at x = %.4f\n', y_max, x(idx_max));

fprintf('\nStandard approach completed successfully!\n');
fprintf('The plot shows the piecewise function with clear visualization.\n');
