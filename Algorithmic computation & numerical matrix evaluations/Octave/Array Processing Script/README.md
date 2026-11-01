# Task 3: Array Processing - Documentation

## Task Description
1. Create a text file with a numerical sequence
2. Read the array from the file and display it with indices
3. Count the number of units (1s) in even positions using a loop

## Implementation Details

### Files Created:
- `numerical_sequence.txt` - Contains the numerical sequence
- `task3_processor.m` - Main processing script

### Script Functionality:

#### 1. File Reading
- Opens and reads `numerical_sequence.txt`
- Uses `fscanf` to read floating-point numbers
- Handles file opening errors

#### 2. Array Display with Indices
- Displays elements in a formatted table
- Automatically adjusts number of columns based on array size
- Shows both index and value for each element
- Format: `Index | Value`

#### 3. Loop-Based Analysis
- Uses `for` loop with parameter to iterate through array
- Checks even positions using `mod(i, 2) == 0`
- Counts elements with value exactly equal to 1
- Records positions of units in even positions

#### 4. Output Features
- **Array Display**: Multi-column format with indices
- **Unit Counting**: Specific analysis of even positions
- **Statistics**: Additional array analysis (min, max, mean, sum)
- **Error Handling**: File access validation

### Key Concepts Demonstrated:
- File I/O operations
- Array indexing and manipulation
- Loop structures with parameters
- Conditional statements
- Modular arithmetic for position checking
- Formatted output display

### Usage:
Run the script in Octave/MATLAB:
```matlab
task3_processor
```

The script will automatically read from `numerical_sequence.txt` and display all results in the command window.

### Sample Output Structure:
```
Task 3: Array Processing
========================

Successfully read 15 elements from file: numerical_sequence.txt

Array Elements with Indices:
============================
Index | Value
------|-------
    1 |  12.00     2 |   7.00     3 |   3.00     4 |  15.00     5 |   8.00
    6 |   1.00     7 |   9.00     8 |   4.00     9 |   6.00    10 |  11.00
   11 |   2.00    12 |  14.00    13 |   5.00    14 |  10.00    15 |  13.00

Analysis of Units in Even Positions:
=====================================
Total number of elements: 15
Number of even positions: 7
Number of units (value = 1) in even positions: 1
Even positions containing units: 6
```

### Algorithm Efficiency:
- Time Complexity: O(n) - single pass through array
- Space Complexity: O(1) - minimal additional storage
- Uses efficient loop structure for counting
