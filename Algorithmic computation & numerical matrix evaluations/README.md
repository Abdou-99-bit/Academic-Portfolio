# Sine Series Calculator - Documentation

## Task 2 Implementation

### 1. Recurrence Relation

For the Taylor series expansion of sin(x):
sin(x) = x - x³/3! + x⁵/5! - x⁷/7! + ...

The general term is: term_n = (-1)^(n-1) * x^(2n-1) / (2n-1)!

**Recurrence Relation:**
term_{n+1} = -term_n * x² / ((2n) * (2n+1))

**Derivation:**
- term_n = (-1)^(n-1) * x^(2n-1) / (2n-1)!
- term_{n+1} = (-1)^n * x^(2n+1) / (2n+1)!
- term_{n+1}/term_n = -x² / ((2n) * (2n+1))

This allows us to calculate each subsequent term from the previous one without recalculating factorials or powers.

### 2. Implementation Details

**Variables:**
- `x`: Input angle in radians
- `n`: Current term number (starts from 1)
- `term`: Current term value
- `sum_series`: Current sum of the series
- `prev_sum`: Previous sum for accuracy checking
- `accuracy`: Target accuracy (10^(-5))

**Algorithm:**
1. Initialize first term as x (x¹/1!)
2. Initialize sum as the first term
3. Loop until difference between consecutive sums < accuracy
4. Use recurrence relation to calculate next term
5. Update sum and increment term counter
6. Write results to file after each iteration

### 3. Output Format

The program generates a text file `sine_series_results.txt` containing:
- Input parameters
- Table with columns: Term No., Term Value, Current Sum
- Final results including comparison with built-in sin() function

### 4. Usage

Run the script in Octave/MATLAB:
```matlab
sine_series_calculator
```

Enter the angle value when prompted. Results will be displayed in the command window and saved to the text file.

### 5. Features

- **Accuracy Control**: Stops when convergence to 10^(-5) is achieved
- **Safety Check**: Maximum 1000 iterations to prevent infinite loops
- **Detailed Logging**: Each iteration logged to file
- **Error Analysis**: Compares calculated result with built-in sin() function
- **User Input**: Interactive input for angle value
