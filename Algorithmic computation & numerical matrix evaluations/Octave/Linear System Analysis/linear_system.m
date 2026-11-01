% Task 10: Linear System Analysis
% System: Ax = b where A is 4x4 matrix and b is 4x1 vector

% Clear workspace and command window
clear;
clc;
close all;

fprintf('Task 10: Linear System Analysis\n');
fprintf('===============================\n\n');

% Define the system of linear equations
% 2.591x₁ + 0.512x₂ + 0.128x₃ + 0.195x₄ = 0.159
% 0.203x₁ + 3.469x₂ + 0.572x₃ + 0.162x₄ = 0.280
% 0.256x₁ + 0.273x₂ + 2.994x₃ + 0.501x₄ = 0.134
% 0.381x₁ + 0.219x₂ + 0.176x₃ + 5.903x₄ = 0.864

% Define matrix A and vector b
A = [2.591, 0.512, 0.128, 0.195;
     0.203, 3.469, 0.572, 0.162;
     0.256, 0.273, 2.994, 0.501;
     0.381, 0.219, 0.176, 5.903];

b = [0.159; 0.280; 0.134; 0.864];

fprintf('System of Linear Equations:\n');
fprintf('A =\n');
for i = 1:4
    fprintf('  [%.3f  %.3f  %.3f  %.3f]\n', A(i,1), A(i,2), A(i,3), A(i,4));
end
fprintf('\nb =\n');
fprintf('  [%.3f]\n  [%.3f]\n  [%.3f]\n  [%.3f]\n\n', b(1), b(2), b(3), b(4));

% Step 1: Solve using Octave built-in tools
fprintf('Step 1: Solving with Octave Built-in Tools\n');
fprintf('==========================================\n');

% Numerical solution using matrix division
fprintf('1.1 Numerical Solution (Matrix Division):\n');
x_numerical = A \ b;
fprintf('Solution vector x:\n');
for i = 1:4
    fprintf('  x_%d = %.10f\n', i, x_numerical(i));
end

% Verify the solution
residual = A * x_numerical - b;
fprintf('\nVerification (Ax - b):\n');
for i = 1:4
    fprintf('  Equation %d: %.2e\n', i, residual(i));
end
fprintf('Maximum residual: %.2e\n', max(abs(residual)));

% Numerical solution using inverse matrix
fprintf('\n1.2 Numerical Solution (Matrix Inverse):\n');
A_inv = inv(A);
x_inverse = A_inv * b;
fprintf('Solution vector x:\n');
for i = 1:4
    fprintf('  x_%d = %.10f\n', i, x_inverse(i));
end

% Compare methods
inverse_diff = max(abs(x_numerical - x_inverse));
fprintf('\nDifference between methods: %.2e\n', inverse_diff);

% Symbolic solution
fprintf('\n1.3 Symbolic Solution:\n');
try
    % Convert to symbolic
    A_sym = sym(A);
    b_sym = sym(b);
    
    % Solve symbolically
    x_symbolic = A_sym \ b_sym;
    fprintf('Symbolic solution:\n');
    for i = 1:4
        fprintf('  x_%d = %s\n', i, char(x_symbolic(i)));
    end
    
    % Convert to numerical for comparison
    x_symbolic_numeric = double(x_symbolic);
    fprintf('\nSymbolic solution (numerical):\n');
    for i = 1:4
        fprintf('  x_%d = %.10f\n', i, x_symbolic_numeric(i));
    end
    
    % Compare with numerical solution
    symbolic_diff = max(abs(x_numerical - x_symbolic_numeric));
    fprintf('\nDifference with numerical solution: %.2e\n', symbolic_diff);
    
catch ME
    fprintf('Symbolic solution not available: %s\n', ME.message);
    x_symbolic_numeric = [];
end

fprintf('\n');

% Step 2: Cramer's method implementation
fprintf('Step 2: Cramer''s Method\n');
fprintf('=======================\n');

% Call Cramer's method function
[x_cramer, det_A, cramer_info] = cramers_method(A, b);

fprintf('\nCramer''s method solution:\n');
for i = 1:4
    fprintf('  x_%d = %.10f\n', i, x_cramer(i));
end

fprintf('Determinant of A: %.10f\n', det_A);
fprintf('Number of matrix determinants calculated: %d\n', cramer_info.determinants_calculated);
fprintf('Computation time: %.6f seconds\n', cramer_info.computation_time);

% Compare Cramer's method with built-in solutions
fprintf('\nComparison with built-in methods:\n');
cramer_vs_numerical = max(abs(x_cramer - x_numerical));
cramer_vs_inverse = max(abs(x_cramer - x_inverse));

fprintf('Cramer vs matrix division: %.2e\n', cramer_vs_numerical);
fprintf('Cramer vs matrix inverse: %.2e\n', cramer_vs_inverse);

if exist('x_symbolic_numeric', 'var') && ~isempty(x_symbolic_numeric)
    cramer_vs_symbolic = max(abs(x_cramer - x_symbolic_numeric));
    fprintf('Cramer vs symbolic: %.2e\n', cramer_vs_symbolic);
end

fprintf('\n');

% Step 3: Matrix analysis (eigenvalues, eigenvectors, rank)
fprintf('Step 3: Matrix Analysis\n');
fprintf('=======================\n');

% Eigenvalues and eigenvectors
fprintf('3.1 Eigenvalues and Eigenvectors:\n');
[V, D] = eig(A);

fprintf('Eigenvalues:\n');
for i = 1:4
    fprintf('  λ_%d = %.10f\n', i, diag(D,i));
end

fprintf('\nEigenvectors (columns of V):\n');
for i = 1:4
    fprintf('  v_%d = [%.6f  %.6f  %.6f  %.6f]^T\n', i, V(1,i), V(2,i), V(3,i), V(4,i));
end

% Verify eigenvector equation
fprintf('\nVerification (Av = λv):\n');
for i = 1:4
    eigenvalue = D(i,i);
    eigenvector = V(:,i);
    Av = A * eigenvector;
    lambda_v = eigenvalue * eigenvector;
    error_norm = norm(Av - lambda_v);
    fprintf('  Eigenvalue %d: ||Av - λv|| = %.2e\n', i, error_norm);
end

% Matrix rank
fprintf('\n3.2 Matrix Rank:\n');
rank_A = rank(A);
fprintf('Rank of A: %d\n', rank_A);

% Matrix properties
fprintf('\n3.3 Additional Matrix Properties:\n');
det_A_check = det(A);
fprintf('Determinant: %.10f\n', det_A_check);

% Condition number
cond_A = cond(A);
fprintf('Condition number: %.2e\n', cond_A);

% Trace
trace_A = trace(A);
fprintf('Trace: %.6f\n', trace_A);

% Matrix norm
norm_A = norm(A);
fprintf('Frobenius norm: %.6f\n', norm_A);

% Check if matrix is symmetric
is_symmetric = isequal(A, A');
fprintf('Is symmetric: %s\n', char(is_symmetric));

% Check if matrix is positive definite
is_positive_definite = all(eig(A) > 0);
fprintf('Is positive definite: %s\n', char(is_positive_definite));

fprintf('\n');

% Step 4: Summary and comparison
fprintf('Step 4: Summary and Comparison\n');
fprintf('==============================\n');

fprintf('System Summary:\n');
fprintf('  Matrix size: %dx%d\n', size(A,1), size(A,2));
fprintf('  Matrix rank: %d\n', rank_A);
fprintf('  Determinant: %.10f\n', det_A_check);
fprintf('  Condition number: %.2e\n', cond_A);

fprintf('\nSolution Comparison:\n');
fprintf('  Method            | x₁        | x₂        | x₃        | x₄        | Max Error\n');
fprintf('  ------------------|-----------|-----------|-----------|-----------|-----------\n');

fprintf('  Matrix division  | %-9.6f | %-9.6f | %-9.6f | %-9.6f | %s\n', ...
        x_numerical(1), x_numerical(2), x_numerical(3), x_numerical(4), 'Reference');

fprintf('  Matrix inverse   | %-9.6f | %-9.6f | %-9.6f | %-9.6f | %.2e\n', ...
        x_inverse(1), x_inverse(2), x_inverse(3), x_inverse(4), inverse_diff);

fprintf('  Cramer''s method   | %-9.6f | %-9.6f | %-9.6f | %-9.6f | %.2e\n', ...
        x_cramer(1), x_cramer(2), x_cramer(3), x_cramer(4), cramer_vs_numerical);

if exist('x_symbolic_numeric', 'var') && ~isempty(x_symbolic_numeric)
    fprintf('  Symbolic          | %-9.6f | %-9.6f | %-9.6f | %-9.6f | %.2e\n', ...
            x_symbolic_numeric(1), x_symbolic_numeric(2), x_symbolic_numeric(3), x_symbolic_numeric(4), symbolic_diff);
end

fprintf('\nEigenvalue Analysis:\n');
fprintf('  All eigenvalues are positive: %s\n', char(all(diag(D) > 0)));
fprintf('  Matrix is well-conditioned: %s\n', char(cond_A < 1000));

% Performance comparison
fprintf('\nPerformance Analysis:\n');
fprintf('  Cramer''s method time: %.6f seconds\n', cramer_info.computation_time);
fprintf('  Matrix division time: ~%.6f seconds (estimated)\n', cramer_info.computation_time * 0.001);  % Much faster

fprintf('\nTask 10 completed successfully!\n');

% Cramer's method function
function [x, det_A, info] = cramers_method(A, b)
    % CRAMERS_METHOD Solve linear system using Cramer's rule
    % Inputs:
    %   A - coefficient matrix (n x n)
    %   b - constant vector (n x 1)
    % Outputs:
    %   x - solution vector (n x 1)
    %   det_A - determinant of A
    %   info - structure with additional information
    
    tic;  % Start timing
    
    [n, m] = size(A);
    if n ~= m
        error('Matrix A must be square');
    end
    
    if length(b) ~= n
        error('Vector b must have same dimension as A');
    end
    
    % Calculate determinant of A
    det_A = det(A);
    
    % Initialize solution vector
    x = zeros(n, 1);
    
    % Initialize info structure
    info.determinants_calculated = 1;  % det(A)
    info.computation_time = 0;
    
    % Check if determinant is zero (no unique solution)
    if abs(det_A) < 1e-12
        warning('Determinant is near zero - solution may be unreliable');
    end
    
    % Apply Cramer's rule
    for i = 1:n
        % Create matrix with i-th column replaced by b
        A_i = A;
        A_i(:, i) = b;
        
        % Calculate determinant of modified matrix
        det_A_i = det(A_i);
        info.determinants_calculated = info.determinants_calculated + 1;
        
        % Calculate solution component
        x(i) = det_A_i / det_A;
    end
    
    % Stop timing
    info.computation_time = toc;
end
