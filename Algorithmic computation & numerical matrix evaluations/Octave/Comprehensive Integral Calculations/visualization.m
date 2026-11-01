% Task 7: Visualization of Integral Calculations
% This script creates visual representations of the function and integration areas

% Clear workspace and close figures
clear;
clc;
close all;

fprintf('Task 7: Visualization of Integral Calculations\n');
fprintf('=============================================\n\n');

% Define the function and parameters
f = @(x) x.^2 .* exp(-2*x);
a = 0;
b = 1.6;

fprintf('Creating visualizations for f(x) = x^2 * e^(-2x) on [0, 1.6]\n');

% Create fine grid for smooth plotting
x_fine = linspace(a-0.5, b+0.5, 1000);
y_fine = f(x_fine);

% Create grid for integration area
x_integration = linspace(a, b, 200);
y_integration = f(x_integration);

% Figure 1: Function plot with integration area
figure('Position', [100, 100, 800, 600]);

% Plot the function
plot(x_fine, y_fine, 'b-', 'LineWidth', 2.5, 'DisplayName', 'f(x) = x^2 * e^(-2x)');
hold on;

% Fill the integration area
fill([x_integration, x_integration(end:-1:1)], ...
     [y_integration, zeros(size(x_integration))], ...
     'r', 'Alpha', 0.3, 'DisplayName', 'Integration Area');

% Add vertical lines at integration limits
plot([a, a], [0, f(a)], 'k--', 'LineWidth', 1.5, 'DisplayName', 'x = 0');
plot([b, b], [0, f(b)], 'k--', 'LineWidth', 1.5, 'DisplayName', 'x = 1.6');

% Add horizontal line at y = 0
plot([a-0.5, b+0.5], [0, 0], 'k-', 'LineWidth', 1);

% Enhance the plot
grid on;
grid minor;
xlabel('x', 'FontSize', 12, 'FontWeight', 'bold');
ylabel('f(x)', 'FontSize', 12, 'FontWeight', 'bold');
title('Function f(x) = x^2 * e^(-2x) with Integration Area', 'FontSize', 14, 'FontWeight', 'bold');
legend('Location', 'northeast');
xlim([a-0.5, b+0.5]);
ylim([-0.1, max(y_fine)*1.1]);

% Add text annotations
text(a+0.1, f(a)/2, 'Integration\nArea', 'FontSize', 10, 'BackgroundColor', 'white', 'EdgeColor', 'black');
text(b/2, max(y_fine)*0.8, sprintf('∫[%.1f to %.1f] f(x) dx', a, b), 'FontSize', 12, 'BackgroundColor', 'white', 'EdgeColor', 'black');

% Figure 2: Function analysis
figure('Position', [150, 150, 1200, 800]);

% Subplot 1: Function and derivative
subplot(2, 3, 1);
plot(x_fine, y_fine, 'b-', 'LineWidth', 2);
hold on;

% Calculate and plot derivative
h = 1e-6;
derivative = (f(x_fine + h) - f(x_fine - h)) / (2*h);
plot(x_fine, derivative, 'r--', 'LineWidth', 1.5);
grid on;
xlabel('x');
ylabel('f(x) and f''(x)');
title('Function and Derivative');
legend('f(x)', "f'(x)", 'Location', 'best');
xlim([a, b]);

% Subplot 2: Function and second derivative
subplot(2, 3, 2);
plot(x_fine, y_fine, 'b-', 'LineWidth', 2);
hold on;

% Calculate and plot second derivative
second_derivative = (f(x_fine + h) - 2*f(x_fine) + f(x_fine - h)) / h^2;
plot(x_fine, second_derivative, 'g--', 'LineWidth', 1.5);
grid on;
xlabel('x');
ylabel('f(x) and f''''(x)');
title('Function and Second Derivative');
legend('f(x)', "f''(x)", 'Location', 'best');
xlim([a, b]);

% Subplot 3: Cumulative integral
subplot(2, 3, 3);
cumulative_integral = zeros(size(x_integration));
for i = 1:length(x_integration)
    if i == 1
        cumulative_integral(i) = trapz(x_integration(1:i), y_integration(1:i));
    else
        cumulative_integral(i) = cumulative_integral(i-1) + trapz(x_integration(i-1:i), y_integration(i-1:i));
    end
end

plot(x_integration, cumulative_integral, 'm-', 'LineWidth', 2);
grid on;
xlabel('x');
ylabel('∫f(x) dx');
title('Cumulative Integral');
xlim([a, b]);

% Subplot 4: Error analysis for different methods
subplot(2, 3, 4);
n_values = [10, 20, 50, 100, 200, 500, 1000];
trapz_errors = zeros(size(n_values));
simpson_errors = zeros(size(n_values));

% Calculate reference value using high-resolution integration
reference_value = trapz(linspace(a, b, 10000), f(linspace(a, b, 10000)));

for i = 1:length(n_values)
    n = n_values(i);
    x_test = linspace(a, b, n);
    y_test = f(x_test);
    
    % Trapezoidal rule
    trapz_value = trapz(x_test, y_test);
    trapz_errors(i) = abs(trapz_value - reference_value);
    
    % Simpson's rule
    if mod(n, 2) == 1
        n = n + 1;
        x_test = linspace(a, b, n);
        y_test = f(x_test);
    end
    
    h = (b - a) / n;
    simpson_value = y_test(1) + y_test(end);
    for j = 2:n
        if mod(j, 2) == 0
            simpson_value = simpson_value + 4 * y_test(j);
        else
            simpson_value = simpson_value + 2 * y_test(j);
        end
    end
    simpson_value = simpson_value * h / 3;
    simpson_errors(i) = abs(simpson_value - reference_value);
end

semilogy(n_values, trapz_errors, 'bo-', 'LineWidth', 2, 'MarkerSize', 6, 'DisplayName', 'Trapezoidal');
hold on;
semilogy(n_values, simpson_errors, 'rs-', 'LineWidth', 2, 'MarkerSize', 6, 'DisplayName', 'Simpson');
grid on;
xlabel('Number of Subintervals');
ylabel('Absolute Error (log scale)');
title('Convergence Analysis');
legend('Location', 'northeast');

% Subplot 5: Function behavior analysis
subplot(2, 3, 5);
% Find critical points
[derivative_max, max_idx] = max(derivative);
[derivative_min, min_idx] = min(derivative);

plot(x_fine, y_fine, 'b-', 'LineWidth', 2);
hold on;
plot(x_fine(max_idx), y_fine(max_idx), 'ro', 'MarkerSize', 8, 'MarkerFaceColor', 'red');
plot(x_fine(min_idx), y_fine(min_idx), 'go', 'MarkerSize', 8, 'MarkerFaceColor', 'green');
grid on;
xlabel('x');
ylabel('f(x)');
title('Critical Points');
legend('f(x)', 'Max slope', 'Min slope', 'Location', 'best');
xlim([a, b]);

% Add annotations
text(x_fine(max_idx), y_fine(max_idx), sprintf('  Max slope\n  at x=%.3f', x_fine(max_idx)), 'FontSize', 8);
text(x_fine(min_idx), y_fine(min_idx), sprintf('  Min slope\n  at x=%.3f', x_fine(min_idx)), 'FontSize', 8);

% Subplot 6: Integration convergence
subplot(2, 3, 6);
n_convergence = 10:10:500;
convergence_values = zeros(size(n_convergence));

for i = 1:length(n_convergence)
    n = n_convergence(i);
    x_conv = linspace(a, b, n);
    y_conv = f(x_conv);
    convergence_values(i) = trapz(x_conv, y_conv);
end

plot(n_convergence, convergence_values, 'b-', 'LineWidth', 2);
hold on;
plot([n_convergence(1), n_convergence(end)], [reference_value, reference_value], 'r--', 'LineWidth', 2);
grid on;
xlabel('Number of Subintervals');
ylabel('Integral Value');
title('Integration Convergence');
legend('Calculated', 'Reference', 'Location', 'best');

% Add main title
sgtitle('Comprehensive Analysis of f(x) = x^2 * e^(-2x)', 'FontSize', 16, 'FontWeight', 'bold');

% Figure 3: 3D visualization for multiple integrals
figure('Position', [200, 200, 1000, 800]);

% Create 3D surface for double integral visualization
subplot(2, 2, 1);
[X, Y] = meshgrid(linspace(a, b, 50), linspace(0, 2, 50));
Z = X.^2 .* exp(-2*X);

surf(X, Y, Z, 'EdgeColor', 'none');
colormap('jet');
colorbar;
xlabel('x');
ylabel('y');
zlabel('f(x)');
title('3D Surface for Double Integral');
view(30, 30);

% Subplot 2: Contour plot
subplot(2, 2, 2);
contourf(X, Y, Z, 20);
colorbar;
xlabel('x');
ylabel('y');
title('Contour Plot of f(x,y)');

% Subplot 3: Cross-sections
subplot(2, 2, 3);
x_cross = linspace(a, b, 100);
y_cross = [0.5, 1.0, 1.5];

for i = 1:length(y_cross)
    z_cross = x_cross.^2 .* exp(-2*x_cross);
    plot(x_cross, z_cross, 'LineWidth', 2, 'DisplayName', sprintf('y = %.1f', y_cross(i)));
    hold on;
end
grid on;
xlabel('x');
ylabel('f(x)');
title('Cross-sections at Different y Values');
legend('Location', 'best');

% Subplot 4: Integration volume
subplot(2, 2, 4);
% Calculate and display the volume
volume = trapz(linspace(a, b, 100), f(linspace(a, b, 100))) * 2;  % Multiply by y-range
bar(volume);
set(gca, 'XTickLabel', {'Double Integral Volume'});
ylabel('Volume');
title('Double Integral Result');
grid on;

% Add main title
sgtitle('Multiple Integral Visualizations', 'FontSize', 14, 'FontWeight', 'bold');

fprintf('Visualizations created successfully!\n');
fprintf('Figure 1: Function plot with integration area\n');
fprintf('Figure 2: Comprehensive function analysis\n');
fprintf('Figure 3: Multiple integral visualizations\n');
