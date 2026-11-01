% Task 4: Comparison of Both Approaches
% This script compares the standard loop-based approach with vectorized operations

% Clear workspace and close figures
clear;
clc;
close all;

fprintf('Task 4: Comparison of Standard and Vectorized Approaches\n');
fprintf('========================================================\n\n');

% Define the piecewise function:
% For x <= 0: y = 3*sin(x) - cos^2(x)
% For x > 0: y = (3*sqrt(1 + x^2)) / ln(x + 5)

% Common parameters
x_min = -5;
x_max = 5;
num_points = 1000;
x = linspace(x_min, x_max, num_points);

% Initialize arrays for both approaches
y_standard = zeros(size(x));
y_vectorized = zeros(size(x));

fprintf('Testing both approaches with %d data points...\n\n', num_points);

% Approach 1: Standard loop-based method
fprintf('Approach 1: Standard Loop-Based Method\n');
fprintf('=====================================\n');
tic;  % Start timer

for i = 1:length(x)
    if x(i) <= 0
        y_standard(i) = 3*sin(x(i)) - cos(x(i))^2;
    else
        y_standard(i) = (3*sqrt(1 + x(i)^2)) / log(x(i) + 5);
    end
end

time_standard = toc;  % Stop timer
fprintf('Execution time: %.6f seconds\n', time_standard);

% Approach 2: Vectorized method
fprintf('\nApproach 2: Vectorized Method\n');
fprintf('============================\n');
tic;  % Start timer

% Create logical masks
mask_negative = x <= 0;
mask_positive = x > 0;

% Vectorized calculation
y_vectorized(mask_negative) = 3*sin(x(mask_negative)) - cos(x(mask_negative)).^2;
y_vectorized(mask_positive) = (3*sqrt(1 + x(mask_positive)).^2) ./ log(x(mask_positive) + 5);

time_vectorized = toc;  % Stop timer
fprintf('Execution time: %.6f seconds\n', time_vectorized);

% Verify results are identical
max_difference = max(abs(y_standard - y_vectorized));
fprintf('\nResult Verification:\n');
fprintf('====================\n');
fprintf('Maximum difference between approaches: %.2e\n', max_difference);

if max_difference < 1e-10
    fprintf('✓ Both approaches produce identical results\n');
else
    fprintf('✗ Approaches produce different results\n');
end

% Performance comparison
speedup = time_standard / time_vectorized;
fprintf('\nPerformance Comparison:\n');
fprintf('=======================\n');
fprintf('Speedup factor: %.2fx\n', speedup);
if speedup > 1
    fprintf('Vectorized approach is %.1f%% faster\n', (speedup - 1) * 100);
else
    fprintf('Standard approach is %.1f%% faster\n', (1/speedup - 1) * 100);
end

% Create comparison plot
fprintf('\nCreating comparison plot...\n');

figure('Position', [200, 200, 1200, 800]);

% Plot 1: Standard approach
subplot(2, 2, 1);
plot(x, y_standard, 'b-', 'LineWidth', 2);
title('Standard Approach', 'FontSize', 12, 'FontWeight', 'bold');
xlabel('x');
ylabel('f(x)');
grid on;
xlim([x_min, x_max]);
ylim([-6, 10]);

% Plot 2: Vectorized approach
subplot(2, 2, 2);
plot(x, y_vectorized, 'r-', 'LineWidth', 2);
title('Vectorized Approach', 'FontSize', 12, 'FontWeight', 'bold');
xlabel('x');
ylabel('f(x)');
grid on;
xlim([x_min, x_max]);
ylim([-6, 10]);

% Plot 3: Difference between approaches
subplot(2, 2, 3);
plot(x, y_standard - y_vectorized, 'g-', 'LineWidth', 2);
title('Difference (Standard - Vectorized)', 'FontSize', 12, 'FontWeight', 'bold');
xlabel('x');
ylabel('Difference');
grid on;
xlim([x_min, x_max]);

% Plot 4: Combined plot
subplot(2, 2, 4);
plot(x, y_standard, 'b-', 'LineWidth', 2, 'DisplayName', 'Standard');
hold on;
plot(x, y_vectorized, 'r--', 'LineWidth', 2, 'DisplayName', 'Vectorized');
hold off;
title('Both Approaches Overlay', 'FontSize', 12, 'FontWeight', 'bold');
xlabel('x');
ylabel('f(x)');
grid on;
legend('Location', 'best');
xlim([x_min, x_max]);
ylim([-6, 10]);

% Add main title
sgtitle('Comparison of Standard and Vectorized Approaches', 'FontSize', 14, 'FontWeight', 'bold');

% Code comparison display
fprintf('\nCode Comparison:\n');
fprintf('================\n');
fprintf('Standard Approach:\n');
fprintf('  for i = 1:length(x)\n');
fprintf('      if x(i) <= 0\n');
fprintf('          y(i) = 3*sin(x(i)) - cos(x(i))^2;\n');
fprintf('      else\n');
fprintf('          y(i) = (3*sqrt(1 + x(i)^2)) / log(x(i) + 5);\n');
fprintf('      end\n');
fprintf('  end\n\n');

fprintf('Vectorized Approach:\n');
fprintf('  mask_negative = x <= 0;\n');
fprintf('  mask_positive = x > 0;\n');
fprintf('  y(mask_negative) = 3*sin(x(mask_negative)) - cos(x(mask_negative)).^2;\n');
fprintf('  y(mask_positive) = (3*sqrt(1 + x(mask_positive)).^2) ./ log(x(mask_positive) + 5);\n\n');

fprintf('Key Differences:\n');
fprintf('  - Vectorized: No explicit loops\n');
fprintf('  - Vectorized: Logical indexing for conditional operations\n');
fprintf('  - Vectorized: Element-wise operations on entire arrays\n');
fprintf('  - Standard: Element-by-element processing\n');
fprintf('  - Standard: Traditional programming paradigm\n\n');

fprintf('Comparison completed successfully!\n');
