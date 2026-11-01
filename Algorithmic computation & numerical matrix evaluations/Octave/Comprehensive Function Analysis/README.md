# Task 9: Comprehensive Function Analysis - Documentation

## Task Description
Comprehensive analysis of the function:
```
f(x) = cos(x) - exp(-x) + 0.5
```

Tasks to perform:
1. Plot the function graph
2. Find the zeros of the function
3. Find the extremes (maxima and minima) of the function
4. Decompose the function into a Taylor series around x = 0
5. Find the limits lim(x→+∞) f(x) and lim(x→-∞) f(x)

## Files Created

### 1. `function_analysis.m`
**Main Implementation Script**
- Function plotting with comprehensive visualization
- Zero finding using multiple methods
- Extreme point detection and classification
- Taylor series decomposition (symbolic and numerical)
- Limit analysis with numerical verification

### 2. `README.md`
Comprehensive documentation (this file)

## Mathematical Analysis

### Function Properties:
```
f(x) = cos(x) - exp(-x) + 0.5
```

#### Domain and Range:
- **Domain**: All real numbers (-∞, +∞)
- **Range**: (-∞, 1.5] for x → -∞, bounded oscillation for x → +∞

#### Component Analysis:
- **cos(x)**: Oscillates between [-1, 1], period 2π
- **exp(-x)**: Decreases from +∞ to 0 as x increases
- **Constant term**: +0.5 shifts the function upward

#### Behavior at Extremes:
- **x → +∞**: cos(x) dominates, exp(-x) → 0, so f(x) → cos(x) + 0.5
- **x → -∞**: -exp(-x) dominates, so f(x) → -∞

## Implementation Details

### 1. Function Plotting
```matlab
f = @(x) cos(x) - exp(-x) + 0.5;
x_plot = linspace(-10, 10, 1000);
y_plot = f(x_plot);
```

**Features:**
- Wide range plotting [-10, 10] to show behavior
- Reference lines at y = 0 and x = 0
- Grid and annotations for clarity
- Multiple Taylor series approximations overlayed

### 2. Zero Finding Methods

#### Method 1: Sign Change Detection
```matlab
for i = 1:length(x_plot)-1
    if y_plot(i) * y_plot(i+1) < 0  % Sign change
        zero_val = fzero(f, zero_guess);
    end
end
```

#### Method 2: Initial Guess Approach
```matlab
initial_guesses = -5:1:5;
for guess = initial_guesses
    zero_val = fzero(f, guess);
end
```

#### Bisection Method (Fallback)
```matlab
function root = bisection_method(f, a, b, tol)
    while (b - a) > tol
        c = (a + b) / 2;
        % Bisection logic
    end
end
```

### 3. Extreme Point Detection

#### Derivative Calculation:
```matlab
f_derivative = @(x) (f(x + h) - f(x - h)) / (2*h);
```

#### Critical Point Classification:
```matlab
second_derivative = (f(x + h2) - 2*f(x) + f(x - h2)) / h2^2;
if second_derivative < 0
    % Maximum
elseif second_derivative > 0
    % Minimum
```

### 4. Taylor Series Decomposition

#### Symbolic Approach:
```matlab
syms x_sym;
f_sym = cos(x_sym) - exp(-x_sym) + 0.5;
taylor_series = taylor(f_sym, x_sym, 0, 'Order', n);
```

#### Expected Series:
```
f(x) = 0.5 + x - x²/2 + x³/6 - x⁴/24 + O(x⁵)
```

#### Numerical Derivative Approach:
```matlab
f1 = (f(x0 + h) - f(x0 - h)) / (2*h);      % First derivative
f2 = (f(x0 + h) - 2*f(x0) + f(x0 - h)) / h^2;  % Second derivative
```

### 5. Limit Analysis

#### Limit as x → +∞:
- **Analytical**: cos(x) oscillates, exp(-x) → 0
- **Result**: No limit (oscillatory between [-0.5, 1.5])
- **Numerical verification**: Evaluate at large positive x values

#### Limit as x → -∞:
- **Analytical**: -exp(-x) dominates → -∞
- **Result**: Limit is -∞
- **Numerical verification**: Evaluate at large negative x values

## Expected Results

### Function Behavior:
- **Oscillatory component**: cos(x) creates periodic behavior
- **Exponential decay**: exp(-x) provides damping for positive x
- **Exponential growth**: exp(-x) causes divergence for negative x

### Zeros:
- Multiple zeros due to oscillatory nature
- Approximately one zero per period for large positive x
- Fewer zeros for negative x due to exponential growth

### Extrema:
- Alternating maxima and minima
- Decreasing amplitude for positive x
- Increasing amplitude for negative x

### Taylor Series:
- Centered at x = 0
- Converges for |x| < radius of convergence
- Good approximation near the expansion point

## Visualization Features

### Main Plot Elements:
- **Function curve**: Blue solid line
- **Z-axis**: y = 0 reference line
- **Taylor series**: Multiple dashed lines for different orders
- **Critical points**: Marked with different symbols
- **Zeros**: Red circles
- **Maxima**: Green triangles
- **Minima**: Magenta inverted triangles

### Plot Annotations:
- Function equation
- Taylor series center marker
- Legend for all plot elements
- Grid for better readability

## Usage Instructions

### Running the Analysis:
```matlab
function_analysis
```

### Expected Output:
1. **Function Plot**: Comprehensive visualization with all features
2. **Zero List**: All found zeros with coordinates
3. **Extrema List**: All maxima and minima with classification
4. **Taylor Series**: Multiple orders with symbolic expressions
5. **Limit Analysis**: Both analytical and numerical results

### Customization Options:
```matlab
% Modify plotting range
x_min = -15;
x_max = 15;

% Modify Taylor series orders
orders = [2, 4, 6, 8, 10];

% Modify zero finding tolerance
tolerance = 1e-10;
```

## Algorithm Complexity

### Zero Finding:
- **Time Complexity**: O(n) for sign change detection
- **Space Complexity**: O(k) where k is number of zeros found

### Extreme Detection:
- **Time Complexity**: O(n) for derivative evaluation
- **Space Complexity**: O(m) where m is number of critical points

### Taylor Series:
- **Symbolic**: Depends on series order
- **Numerical**: O(1) for fixed number of terms

## Learning Objectives

### Mathematical Concepts:
- **Function Analysis**: Comprehensive study of function properties
- **Numerical Methods**: Root finding and optimization
- **Series Expansion**: Taylor series and convergence
- **Limit Analysis**: Behavior at infinity

### Programming Skills:
- **Numerical Computation**: Derivatives and root finding
- **Symbolic Mathematics**: Working with symbolic expressions
- **Data Visualization**: Multi-element plot creation
- **Algorithm Implementation**: Bisection and Newton methods

### Problem-Solving:
- **Multiple Approaches**: Combining analytical and numerical methods
- **Error Analysis**: Understanding numerical accuracy
- **Function Behavior**: Predicting and verifying mathematical properties
- **Visualization**: Creating informative graphical representations

## Extensions and Modifications

### Possible Enhancements:
- **Higher-Order Derivatives**: More accurate Taylor series
- **Convergence Analysis**: Radius of convergence determination
- **Optimization**: More efficient root finding algorithms
- **Interactive Plots**: User-controlled visualization

### Advanced Features:
- **Complex Analysis**: Extension to complex domain
- **Fourier Analysis**: Frequency domain representation
- **Numerical Integration**: Area under curve calculations
- **Differential Equations**: Function as solution to ODEs

### Performance Optimization:
- **Vectorization**: Efficient array operations
- **Parallel Computing**: Accelerated computations
- **Memory Management**: Efficient data storage
- **GPU Acceleration**: High-performance computing
