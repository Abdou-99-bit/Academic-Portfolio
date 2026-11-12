% Simple test script for Task 10 linear system analysis
% This script provides basic verification of the main functionality

% Clear workspace
clear;
clc;

fprintf('Simple Test for Task 10 Linear System Analysis\n');
fprintf('===============================================\n\n');

% Define the test system
A = [2.591, 0.512, 0.128, 0.195;
     0.203, 3.469, 0.572, 0.162;
     0.256, 0.273, 2.994, 0.501;
     0.381, 0.219, 0.176, 5.903];

b = [0.159; 0.280; 0.134; 0.864];

fprintf('Test System:\n');
fprintf('Matrix A (4x4):\n');
for i = 1:4
    fprintf('  [%.3f  %.3f  %.3f  %.3f]\n', A(i,1), A(i,2), A(i,3), A(i,4));
end
fprintf('Vector b:\n');
for i = 1:4
    fprintf('  [%.3f]\n', b(i));
end

fprintf('\n');

% Test 1: Basic matrix properties
fprintf('Test 1: Basic Matrix Properties\n');
fprintf('-------------------------------\n');

det_A = det(A);
rank_A = rank(A);
size_A = size(A);

fprintf('Matrix size: %dx%d\n', size_A(1), size_A(2));
fprintf('Determinant: %.6f\n', det_A);
fprintf('Rank: %d\n', rank_A);
fprintf('Is square: %s\n', char(size_A(1) == size_A(2)));

if abs(det_A) < 1e-12
    fprintf('Warning: Matrix is singular or nearly singular\n');
else
    fprintf('Matrix is non-singular - unique solution expected\n');
end

fprintf('\n');

% Test 2: Basic solution methods
fprintf('Test 2: Basic Solution Methods\n');
fprintf('-----------------------------\n');

% Matrix division
x_div = A \ b;
fprintf('Solution using A\\b:\n');
for i = 1:4
    fprintf('  x_%d = %.6f\n', i, x_div(i));
end

% Matrix inverse
x_inv = inv(A) * b;
fprintf('\nSolution using inv(A)*b:\n');
for i = 1:4
    fprintf('  x_%d = %.6f\n', i, x_inv(i));
end

% Compare methods
max_diff = max(abs(x_div - x_inv));
fprintf('\nMaximum difference between methods: %.2e\n', max_diff);

% Verify solution
residual = A * x_div - b;
fprintf('Maximum residual (Ax-b): %.2e\n', max(abs(residual)));

fprintf('\n');

% Test 3: Cramer's method
fprintf('Test 3: Cramer''s Method\n');
fprintf('-----------------------\n');

[x_cramer, det_cramer, info] = cramers_method(A, b);

fprintf('Cramer''s method solution:\n');
for i = 1:4
    fprintf('  x_%d = %.6f\n', i, x_cramer(i));
end

fprintf('Determinant from Cramer: %.6f\n', det_cramer);
fprintf('Determinants calculated: %d\n', info.determinants_calculated);
fprintf('Computation time: %.6f seconds\n', info.computation_time);

% Compare with matrix division
cramer_diff = max(abs(x_cramer - x_div));
fprintf('Difference with A\\b: %.2e\n', cramer_diff);

fprintf('\n');

% Test 4: Eigenanalysis
fprintf('Test 4: Eigenanalysis\n');
fprintf('-------------------\n');

[V, D] = eig(A);

fprintf('Eigenvalues:\n');
for i = 1:4
    fprintf('  λ_%d = %.6f\n', i, D(i,i));
end

% Check if all eigenvalues are positive
all_positive = all(diag(D) > 0);
fprintf('All eigenvalues positive: %s\n', char(all_positive));

% Check eigenvector verification
fprintf('\nEigenvector verification (Av ≈ λv):\n');
for i = 1:4
    v = V(:,i);
    lambda = D(i,i);
    Av = A * v;
    lambda_v = lambda * v;
    error = norm(Av - lambda_v);
    fprintf('  v_%d: ||Av - λv|| = %.2e\n', i, error);
end

fprintf('\n');

% Test 5: Matrix properties
fprintf('Test 5: Matrix Properties\n');
fprintf('------------------------\n');

cond_A = cond(A);
trace_A = trace(A);
norm_A = norm(A);

fprintf('Condition number: %.2e\n', cond_A);
fprintf('Trace: %.6f\n', trace_A);
fprintf('Frobenius norm: %.6f\n', norm_A);

if cond_A < 100
    fprintf('Matrix is well-conditioned\n');
elseif cond_A < 1000
    fprintf('Matrix is moderately conditioned\n');
else
    fprintf('Matrix is ill-conditioned\n');
end

% Check symmetry
is_symmetric = isequal(A, A');
fprintf('Is symmetric: %s\n', char(is_symmetric));

% Check diagonal dominance
diag_dominant = true;
for i = 1:4
    row_sum = sum(abs(A(i,:))) - abs(A(i,i));
    if abs(A(i,i)) <= row_sum
        diag_dominant = false;
        break;
    end
end
fprintf('Is diagonally dominant: %s\n', char(diag_dominant));

fprintf('\n');

% Test 6: Simple visualization
fprintf('Test 6: Simple Visualization\n');
fprintf('---------------------------\n');

try
    figure('Position', [100, 100, 800, 600]);
    
    % Create bar plot of solutions
    methods = {'A\\b', 'inv(A)*b', 'Cramer'};
    solutions = [x_div, x_inv, x_cramer];
    
    bar(solutions);
    set(gca, 'XTickLabel', methods);
    ylabel('Solution Values');
    title('Solution Comparison');
    legend('x₁', 'x₂', 'x₃', 'x₄', 'Location', 'best');
    grid on;
    
    fprintf('Solution comparison plot created\n');
    
catch ME
    fprintf('Plot creation failed: %s\n', ME.message);
end

fprintf('\n');

% Test 7: Performance comparison
fprintf('Test 7: Performance Comparison\n');
fprintf('-----------------------------\n');

% Time matrix division
tic;
for i = 1:100
    x_temp = A \ b;
end
time_div = toc / 100;

% Time matrix inverse
tic;
for i = 1:100
    x_temp = inv(A) * b;
end
time_inv = toc / 100;

fprintf('Average time per call:\n');
fprintf('  Matrix division (A\\b): %.6f seconds\n', time_div);
fprintf('  Matrix inverse: %.6f seconds\n', time_inv);
fprintf('  Cramer''s method: %.6f seconds\n', info.computation_time);

fprintf('\nSpeedup ratios:\n');
fprintf('  Division vs Cramer: %.1fx faster\n', info.computation_time / time_div);
fprintf('  Inverse vs Cramer: %.1fx faster\n', info.computation_time / time_inv);

fprintf('\n✓ Simple tests completed!\n');
fprintf('Run "linear_system" for comprehensive analysis.\n');

% Cramer's method function (copy from main script)
function [x, det_A, info] = cramers_method(A, b)
    tic;
    [n, m] = size(A);
    if n ~= m
        error('Matrix A must be square');
    end
    if length(b) ~= n
        error('Vector b must have same dimension as A');
    end
    
    det_A = det(A);
    x = zeros(n, 1);
    info.determinants_calculated = 1;
    info.computation_time = 0;
    
    if abs(det_A) < 1e-12
        warning('Determinant is near zero - solution may be unreliable');
    end
    
    for i = 1:n
        A_i = A;
        A_i(:, i) = b;
        det_A_i = det(A_i);
        info.determinants_calculated = info.determinants_calculated + 1;
        x(i) = det_A_i / det_A;
    end
    
    info.computation_time = toc;
end
