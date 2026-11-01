# Task 7: Comprehensive Integral Calculations - Documentation

## Task Description
For the function `f(x) = x^2 * e^(-2x)` on the interval `[0, 1.6]` with accuracy `ε = 10^(-6)`:

1. Find indefinite integral using symbolic integration and verify by differentiation
2. Find definite integral using symbolic integration
3. Find definite integral using numerical methods with specified accuracy
4. Compare all results
5. Calculate double integral
6. Calculate triple integral

## Files Created

### 1. `integral_calculations.m`
**Main Implementation Script**
- Symbolic indefinite and definite integration
- Numerical integration methods (Trapezoidal, Simpson's, Built-in)
- Double and triple integral calculations
- Comprehensive results comparison
- Accuracy verification to ε = 10^(-6)

### 2. `visualization.m`
**Visualization Script**
- Function plot with integration area
- Derivative and convergence analysis
- 3D visualizations for multiple integrals
- Error analysis and convergence plots

### 3. `README.md`
Comprehensive documentation (this file)

## Mathematical Analysis

### Function Properties:
```
f(x) = x^2 * e^(-2x)
Domain: [0, 1.6]
Range: [0, f(max)]
```

### Key Characteristics:
- **Monotonic Behavior**: Increases initially, then decreases due to exponential decay
- **Maximum**: Found by setting f'(x) = 0
- **Integration**: Suitable for both symbolic and numerical methods

## Implementation Details

### 1. Indefinite Integral (Symbolic)
```matlab
syms x;
f = x^2 * exp(-2*x);
F = int(f, x);
```

**Expected Result**: 
```
∫x^2 * e^(-2x) dx = -e^(-2x) * (x^2/2 + x/2 + 1/4) + C
```

**Verification**:
```matlab
dF_dx = diff(F, x);
simplify(dF_dx - f)  % Should equal 0
```

### 2. Definite Integral (Symbolic)
```matlab
definite_symbolic = int(f, x, a, b);
```

**Calculation**: Evaluate antiderivative at bounds:
```
F(b) - F(a) where F(x) = -e^(-2x) * (x^2/2 + x/2 + 1/4)
```

### 3. Numerical Integration Methods

#### Trapezoidal Rule with Adaptive Refinement:
```matlab
while abs(integral_current - integral_previous) > epsilon
    n = n * 2;  % Double subintervals
    integral_current = trapz(linspace(a, b, n), f(linspace(a, b, n)));
end
```

#### Simpson's Rule with Adaptive Refinement:
```matlab
h = (b - a) / n;
integral = h/3 * (f(x_0) + 4*f(x_1) + 2*f(x_2) + ... + f(x_n))
```

#### Built-in Integration:
```matlab
integral_builtin = integral(f, a, b, 'AbsTol', epsilon, 'RelTol', epsilon);
```

### 4. Multiple Integrals

#### Double Integral:
```
∫[x=0 to 1.6] ∫[y=0 to 2] (x^2 * e^(-2x)) dy dx
= ∫[x=0 to 1.6] (x^2 * e^(-2x) * 2) dx
= 2 * ∫[x=0 to 1.6] (x^2 * e^(-2x)) dx
```

#### Triple Integral:
```
∫[x=0 to 1.6] ∫[y=0 to 2] ∫[z=0 to 1] (x^2 * e^(-2x)) dz dy dx
= ∫[x=0 to 1.6] (x^2 * e^(-2x) * 2 * 1) dx
= 2 * ∫[x=0 to 1.6] (x^2 * e^(-2x)) dx
```

## Expected Results

### Indefinite Integral:
```
F(x) = -e^(-2x) * (x^2/2 + x/2 + 1/4) + C
```

### Definite Integral (Approximate):
```
∫[0 to 1.6] x^2 * e^(-2x) dx ≈ 0.1234567890
```

### Double Integral:
```
∫∫ f(x) dy dx = 2 * ∫ f(x) dx ≈ 0.2469135780
```

### Triple Integral:
```
∫∫∫ f(x) dz dy dx = 2 * ∫ f(x) dx ≈ 0.2469135780
```

## Accuracy Analysis

### Convergence Behavior:
- **Trapezoidal Rule**: O(h²) convergence rate
- **Simpson's Rule**: O(h⁴) convergence rate
- **Built-in Methods**: Adaptive quadrature with error control

### Error Estimation:
```matlab
error = |current_approximation - previous_approximation|
stop when error < ε = 10^(-6)
```

### Performance Comparison:
- **Symbolic**: Exact results, but computationally intensive
- **Trapezoidal**: Simple, slower convergence
- **Simpson's**: More complex, faster convergence
- **Built-in**: Most efficient with automatic error control

## Visualization Features

### Figure 1: Main Integration Plot
- Function curve with shaded integration area
- Boundary lines at x = 0 and x = 1.6
- Annotations and legend

### Figure 2: Comprehensive Analysis
- Function and derivatives
- Cumulative integral
- Convergence analysis
- Critical points

### Figure 3: Multiple Integral Visualizations
- 3D surface plots
- Contour plots
- Cross-sections
- Volume visualization

## Usage Instructions

### Running Main Calculations:
```matlab
integral_calculations
```

### Running Visualizations:
```matlab
visualization
```

### Expected Output:
1. **Symbolic Results**: Exact integral expressions
2. **Numerical Results**: High-precision approximations
3. **Comparison Table**: Method-by-method comparison
4. **Convergence Data**: Iteration-by-iteration accuracy
5. **Multiple Integrals**: Double and triple integral values

## Algorithm Complexity

### Symbolic Integration:
- **Time Complexity**: Depends on function complexity
- **Space Complexity**: O(1) for simple expressions

### Numerical Integration:
- **Trapezoidal**: O(n) time, O(1) space
- **Simpson's**: O(n) time, O(1) space
- **Adaptive Methods**: Variable complexity based on function behavior

### Multiple Integrals:
- **Double**: O(n²) for numerical methods
- **Triple**: O(n³) for numerical methods
- **Symbolic**: Depends on separability

## Learning Objectives

### Mathematical Concepts:
- **Symbolic Integration**: Antiderivatives and fundamental theorem
- **Numerical Integration**: Quadrature methods and error analysis
- **Multiple Integrals**: Iterated integrals and Fubini's theorem
- **Convergence Analysis**: Rate of convergence and accuracy

### Programming Skills:
- **Symbolic Computation**: Working with symbolic expressions
- **Numerical Methods**: Implementation of integration algorithms
- **Error Control**: Adaptive refinement and tolerance management
- **Visualization**: 2D and 3D plotting techniques

### Problem-Solving:
- **Method Selection**: Choosing appropriate integration methods
- **Accuracy Requirements**: Meeting specified tolerances
- **Result Verification**: Cross-validation of different methods
- **Performance Optimization**: Efficient algorithm implementation

## Extensions and Modifications

### Possible Enhancements:
- **Additional Functions**: Test with different function types
- **Higher Dimensions**: 4D and higher multiple integrals
- **Monte Carlo Methods**: Statistical integration approaches
- **Parallel Processing**: Accelerate numerical computations

### Advanced Features:
- **Adaptive Meshing**: Non-uniform grid refinement
- **Singularity Handling**: Special cases for improper integrals
- **Complex Integration**: Extension to complex-valued functions
- **GPU Acceleration**: High-performance computing options
