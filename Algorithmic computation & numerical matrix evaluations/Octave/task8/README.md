# Task 8: Differential Equation Solution - Documentation

## Task Description
Solve the Cauchy problem for the differential equation:
```
y'' - y = 2e^x - x^2
```
with initial conditions:
```
y(0) = 0, y'(0) = 0
```
on the segment `[0, 2]` using:
1. Numerical methods
2. Symbolic methods
3. Graphical comparison of solutions

## Files Created

### 1. `differential_solver.m`
**Main Implementation Script**
- Numerical solution using multiple ODE solvers
- Symbolic solution using dsolve
- Comprehensive error analysis
- Graphical comparison in one coordinate system

### 2. `README.md`
Comprehensive documentation (this file)

## Mathematical Analysis

### Differential Equation:
```
y'' - y = 2e^x - x^2
```

### Initial Conditions:
```
y(0) = 0
y'(0) = 0
```

### Solution Interval:
```
x ∈ [0, 2]
```

### Conversion to First-Order System:
For numerical solution, convert second-order ODE to system:
```
Let y₁ = y, y₂ = y'
Then: y₁' = y₂
      y₂' = y₁ + 2e^x - x^2
```

## Implementation Details

### 1. Numerical Solution Methods

#### ode45 (Runge-Kutta):
```matlab
ode_system = @(x, y) [y(2); y(1) + 2*exp(x) - x^2];
[x_num, y_num] = ode45(ode_system, [0, 2], [0, 0], options);
```
- **Method**: 4th/5th order Runge-Kutta
- **Accuracy**: Adaptive step size with specified tolerances
- **Advantages**: High accuracy, automatic step control

#### ode23 (Simpler Runge-Kutta):
```matlab
[x_num23, y_num23] = ode23(ode_system, [0, 2], [0, 0], options);
```
- **Method**: 2nd/3rd order Runge-Kutta
- **Usage**: Faster but less accurate than ode45

#### ode15s (Stiff Solver):
```matlab
[x_num15s, y_num15s] = ode15s(ode_system, [0, 2], [0, 0], options);
```
- **Method**: Variable-order backward differentiation
- **Usage**: Suitable for stiff equations

#### Euler Method:
```matlab
for i = 1:n_steps
    dy = ode_system(x_euler(i), y_euler(i, :)');
    y_euler(i + 1, :) = y_euler(i, :) + h * dy';
end
```
- **Method**: Fixed-step forward Euler
- **Accuracy**: First-order, simple implementation

### 2. Symbolic Solution

#### General Solution:
```matlab
syms y(x) x;
ode = diff(y, 2) - y == 2*exp(x) - x^2;
y_general = dsolve(ode);
```

#### Particular Solution:
Apply initial conditions to find constants:
```matlab
Dy = diff(y_general, x);
constants = solve([subs(y_general, x, 0) == 0, ...
                  subs(Dy, x, 0) == 0], [sym('C1'), sym('C2')]);
y_particular = subs(y_general, constants);
```

### 3. Error Analysis

#### Absolute Error Calculation:
```matlab
error = max(abs(numerical_solution - symbolic_solution));
```

#### Comparison Metrics:
- Maximum absolute error
- Point-wise error analysis
- Method performance comparison

### 4. Graphical Comparison

#### Main Comparison Plot:
- All solutions plotted in same coordinate system
- Clear legend and annotations
- Initial condition marker
- Differential equation annotation

#### Error Analysis Plots:
- Individual method errors
- Combined error comparison
- Logarithmic scale for error visualization

#### Derivative Comparison:
- y'(x) comparison between methods
- Verification of derivative consistency

## Expected Results

### Symbolic Solution Structure:
The general solution to `y'' - y = 2e^x - x^2` consists of:
1. **Homogeneous solution**: `C₁e^x + C₂e^(-x)`
2. **Particular solution**: Specific solution to non-homogeneous equation

### Particular Solution:
After applying initial conditions `y(0) = 0, y'(0) = 0`:
```
y(x) = (homogeneous terms) + (particular terms)
```

### Numerical Accuracy:
- **ode45**: Highest accuracy (10^(-8) relative tolerance)
- **ode23**: Good accuracy, faster computation
- **ode15s**: Comparable accuracy for this non-stiff equation
- **Euler**: Lower accuracy, first-order method

## Visualization Features

### Figure 1: Main Comparison
- **Title**: "Differential Equation Solutions Comparison"
- **Content**: All solution curves in one plot
- **Features**: Grid, legend, initial condition marker

### Figure 2: Error Analysis
- **Subplot 1**: ode45 error vs symbolic
- **Subplot 2**: ode23 error vs symbolic
- **Subplot 3**: ode15s error vs symbolic
- **Subplot 4**: All errors combined (log scale)

### Figure 3: Derivative Comparison
- **Content**: y'(x) for different methods
- **Purpose**: Verify derivative consistency

## Usage Instructions

### Running the Solution:
```matlab
differential_solver
```

### Expected Output:
1. **Numerical Results**: Solution values at computed points
2. **Symbolic Results**: Analytical expression for y(x)
3. **Error Analysis**: Maximum errors for each method
4. **Graphical Output**: Three comparison figures

### Customization Options:
```matlab
% Modify tolerances
options = odeset('RelTol', 1e-10, 'AbsTol', 1e-12);

% Modify interval
x_start = 0;
x_end = 3;

% Modify initial conditions
y0_1 = 1;  % y(0) = 1
y0_2 = 2;  % y'(0) = 2
```

## Algorithm Complexity

### Numerical Methods:
- **ode45/ode23**: O(n) adaptive complexity
- **ode15s**: O(n) with variable step size
- **Euler**: O(n) fixed step size

### Symbolic Solution:
- **Time Complexity**: Depends on equation complexity
- **Space Complexity**: O(1) for final expression

### Error Analysis:
- **Computation**: O(n) for error calculation
- **Storage**: O(n) for error arrays

## Learning Objectives

### Mathematical Concepts:
- **Differential Equations**: Second-order ODEs
- **Initial Value Problems**: Cauchy problems
- **Numerical Methods**: ODE solvers and their characteristics
- **Symbolic Computation**: Analytical solution methods

### Programming Skills:
- **ODE Solvers**: Using MATLAB/Octave ODE functions
- **Symbolic Math**: Working with symbolic expressions
- **Error Analysis**: Comparing numerical and analytical solutions
- **Visualization**: Multi-plot comparison techniques

### Problem-Solving:
- **Method Selection**: Choosing appropriate numerical methods
- **Accuracy Control**: Setting tolerances and verifying results
- **Validation**: Cross-checking numerical with symbolic solutions
- **Performance Analysis**: Comparing different algorithms

## Extensions and Modifications

### Possible Enhancements:
- **Additional Methods**: Implement more ODE solvers
- **Adaptive Mesh**: Variable step size optimization
- **Stability Analysis**: Investigate method stability regions
- **Parameter Studies**: Vary initial conditions and parameters

### Advanced Features:
- **Higher-Order Equations**: Extend to nth-order ODEs
- **System of ODEs**: Multiple coupled equations
- **Boundary Value Problems**: Different from initial value problems
- **Partial Differential Equations**: Extension to PDEs

### Performance Optimization:
- **Parallel Computing**: Accelerate numerical computations
- **GPU Acceleration**: GPU-based ODE solvers
- **Memory Optimization**: Efficient storage of solutions
- **Real-time Visualization**: Animated solution evolution
