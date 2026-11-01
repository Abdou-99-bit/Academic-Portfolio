# Task 10: Linear System Analysis - Documentation

## Task Description
Comprehensive analysis of the linear system Ax = b where:
```
2.591x₁ + 0.512x₂ + 0.128x₃ + 0.195x₄ = 0.159
0.203x₁ + 3.469x₂ + 0.572x₃ + 0.162x₄ = 0.280
0.256x₁ + 0.273x₂ + 2.994x₃ + 0.501x₄ = 0.134
0.381x₁ + 0.219x₂ + 0.176x₃ + 5.903x₄ = 0.864
```

Tasks to perform:
1. Solve the system using Octave built-in tools (numerically and symbolically)
2. Implement Cramer's method and compare results
3. Find eigenvalues, eigenvectors, and rank of matrix A

## Files Created

### 1. `linear_system.m`
**Main Implementation Script**
- Multiple solution methods (matrix division, inverse, symbolic)
- Cramer's method implementation with performance analysis
- Complete matrix analysis (eigenvalues, eigenvectors, rank)
- Comprehensive comparison and verification

### 2. `README.md`
Comprehensive documentation (this file)

## Mathematical Analysis

### System Definition:
```
A = [2.591  0.512  0.128  0.195]
    [0.203  3.469  0.572  0.162]
    [0.256  0.273  2.994  0.501]
    [0.381  0.219  0.176  5.903]

b = [0.159]
    [0.280]
    [0.134]
    [0.864]
```

### Matrix Properties:
- **Size**: 4×4 (square)
- **Type**: Real-valued
- **Structure**: Non-symmetric, diagonally dominant
- **Expected**: Well-conditioned with unique solution

## Implementation Details

### 1. Built-in Solution Methods

#### Matrix Division (A\b):
```matlab
x_numerical = A \ b;
```
- **Method**: LU decomposition with partial pivoting
- **Complexity**: O(n³) for factorization, O(n²) for solution
- **Advantages**: Most efficient, numerically stable

#### Matrix Inverse (inv(A)*b):
```matlab
A_inv = inv(A);
x_inverse = A_inv * b;
```
- **Method**: Direct matrix inversion
- **Complexity**: O(n³)
- **Disadvantages**: Less efficient, less numerically stable

#### Symbolic Solution:
```matlab
A_sym = sym(A);
b_sym = sym(b);
x_symbolic = A_sym \ b_sym;
```
- **Method**: Symbolic linear algebra
- **Advantages**: Exact solution, error analysis
- **Disadvantages**: Computationally intensive

### 2. Cramer's Method Implementation

#### Algorithm:
```matlab
function [x, det_A, info] = cramers_method(A, b)
    det_A = det(A);
    for i = 1:n
        A_i = A;
        A_i(:, i) = b;
        det_A_i = det(A_i);
        x(i) = det_A_i / det_A;
    end
end
```

#### Mathematical Principle:
For system Ax = b, the i-th solution component is:
```
x_i = det(A_i) / det(A)
```
where A_i is matrix A with i-th column replaced by b.

#### Complexity Analysis:
- **Determinant calculations**: n+1 determinants
- **Each determinant**: O(n³) using LU decomposition
- **Total complexity**: O(n⁴)
- **Performance**: Much slower than built-in methods

### 3. Matrix Analysis

#### Eigenvalue Decomposition:
```matlab
[V, D] = eig(A);
```
- **V**: Matrix of eigenvectors (columns)
- **D**: Diagonal matrix of eigenvalues
- **Verification**: Av = λv for each eigenpair

#### Rank Calculation:
```matlab
rank_A = rank(A);
```
- **Method**: SVD-based rank determination
- **Significance**: Indicates system solvability

#### Additional Properties:
- **Determinant**: Product of eigenvalues
- **Condition Number**: Sensitivity to perturbations
- **Trace**: Sum of eigenvalues
- **Norm**: Matrix magnitude measure

## Expected Results

### Solution Characteristics:
- **Unique solution** expected (det(A) ≠ 0)
- **Well-conditioned system** (diagonal dominance)
- **All methods should agree** within numerical precision

### Matrix Properties:
- **Positive definite** (all eigenvalues > 0)
- **Well-conditioned** (condition number moderate)
- **Full rank** (rank = 4)

### Performance Comparison:
- **Fastest**: Matrix division (A\b)
- **Medium**: Matrix inverse
- **Slowest**: Cramer's method
- **Most accurate**: Symbolic solution

## Usage Instructions

### Running the Analysis:
```matlab
linear_system
```

### Expected Output:
1. **System definition**: Matrix A and vector b
2. **Numerical solutions**: Multiple methods with verification
3. **Symbolic solution**: Exact expressions and numerical values
4. **Cramer's method**: Implementation details and results
5. **Matrix analysis**: Eigenvalues, eigenvectors, rank, properties
6. **Comparison table**: All methods side by side

### Customization Options:
```matlab
% Modify the system
A = [new coefficients];
b = [new constants];

% Change tolerance for singularity detection
tolerance = 1e-12;
```

## Algorithm Complexity

### Solution Methods:
- **Matrix division**: O(n³) factorization + O(n²) solution
- **Matrix inverse**: O(n³)
- **Cramer's method**: O(n⁴)
- **Symbolic**: Variable, typically O(n³) with overhead

### Matrix Analysis:
- **Eigenvalues**: O(n³) (QR algorithm)
- **Rank**: O(n³) (SVD)
- **Determinant**: O(n³) (LU decomposition)

## Learning Objectives

### Mathematical Concepts:
- **Linear Systems**: Solution methods and properties
- **Matrix Algebra**: Inverses, determinants, eigenvalues
- **Numerical Methods**: Stability and conditioning
- **Cramer's Rule**: Classical solution method

### Programming Skills:
- **Matrix Operations**: Efficient linear algebra
- **Algorithm Implementation**: Cramer's method from scratch
- **Symbolic Computation**: Exact vs numerical solutions
- **Performance Analysis**: Method comparison

### Problem-Solving:
- **Multiple Approaches**: Different solution strategies
- **Verification**: Cross-checking results
- **Error Analysis**: Understanding numerical accuracy
- **Optimization**: Choosing appropriate methods

## Extensions and Modifications

### Possible Enhancements:
- **Iterative Methods**: Gauss-Seidel, Jacobi methods
- **Sparse Matrices**: Efficient storage and computation
- **Large Systems**: Scalability considerations
- **Parallel Computing**: Accelerated computations

### Advanced Features:
- **Sensitivity Analysis**: Perturbation effects
- **Condition Estimation**: Better conditioning measures
- **Block Methods**: Partitioned matrix solutions
- **Preconditioning**: Iterative method improvement

### Applications:
- **Engineering Systems**: Structural analysis, circuits
- **Economic Models**: Input-output analysis
- **Scientific Computing**: Differential equations
- **Data Analysis**: Linear regression, optimization

## Error Analysis

### Numerical Errors:
- **Round-off errors**: Floating-point arithmetic
- **Conditioning errors**: Ill-conditioned systems
- **Algorithmic errors**: Method-specific inaccuracies

### Verification Methods:
- **Residual analysis**: ||Ax - b||
- **Back substitution**: Solution verification
- **Multiple methods**: Cross-validation
- **Symbolic comparison**: Exact vs numerical

### Accuracy Improvement:
- **Higher precision**: Extended arithmetic
- **Iterative refinement**: Solution improvement
- **Preconditioning**: Condition number reduction
- **Symbolic-numeric hybrid**: Best of both approaches
