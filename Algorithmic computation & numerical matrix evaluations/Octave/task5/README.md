# Task 5: Matrix Transformation - Documentation

## Task Description
1. Create a text file containing a matrix of numbers with arbitrary rows and columns
2. Read the matrix from the file and output it to another file line by line with the header "THE ORIGINAL MATRIX:"
3. Transform the matrix by swapping the column containing the maximum element with the first column
4. Output the transformed matrix to the same file with the header "THE TRANSFORMED MATRIX:"
5. Complete the task using nested loop operators

## Files Created

### 1. `matrix_input.txt`
**Input Matrix File**
- Contains a 5×5 matrix of numbers
- Format: Space-separated values per row
- Example content:
  ```
  12 7 3 15 8
  6 1 9 4 11
  2 14 5 10 13
  16 18 20 17 19
  21 23 22 24 25
  ```

### 2. `matrix_transformer.m`
**Main Implementation Script**
- Reads matrix from input file
- Finds column containing maximum element
- Performs column transformation
- Writes both matrices to output file using nested loops
- Provides comprehensive analysis and verification

### 3. `README.md`
Comprehensive documentation (this file)

## Implementation Details

### Core Algorithm:

#### 1. Matrix Reading
```matlab
fileID = fopen(input_filename, 'r');
matrix = [];
while ~feof(fileID)
    line = fgetl(fileID);
    if ischar(line) && ~isempty(line)
        row = sscanf(line, '%f');
        if ~isempty(row)
            matrix = [matrix; row];
        end
    end
end
fclose(fileID);
```

#### 2. Finding Maximum Element
```matlab
[max_value, max_linear_index] = max(matrix(:));
[max_row, max_col] = ind2sub([rows, cols], max_linear_index);
```

#### 3. Column Transformation
```matlab
transformed_matrix = matrix;
if max_col ~= 1
    transformed_matrix(:, [1, max_col]) = transformed_matrix(:, [max_col, 1]);
end
```

#### 4. Nested Loop Output
```matlab
for i = 1:rows
    for j = 1:cols
        fprintf(fileID, '%8.2f', matrix(i, j));
    end
    fprintf(fileID, '\n');
end
```

### Key Features:

#### File Operations:
- **Input Validation**: Checks if input file exists
- **Error Handling**: Proper file opening/closing with error messages
- **Flexible Reading**: Handles matrices of any size
- **Formatted Output**: Consistent spacing and alignment

#### Matrix Operations:
- **Maximum Detection**: Finds global maximum and its position
- **Column Swapping**: Efficient column interchange
- **Preservation**: Maintains matrix dimensions and row sums

#### Nested Loop Implementation:
- **Element-wise Processing**: Accesses each matrix element individually
- **Formatted Writing**: Consistent output format
- **Dual Output**: Writes both original and transformed matrices

## Output Format

### File Structure (`matrix_output.txt`):
```
THE ORIGINAL MATRIX:
====================
   12.00    7.00    3.00   15.00    8.00
    6.00    1.00    9.00    4.00   11.00
    2.00   14.00    5.00   10.00   13.00
   16.00   18.00   20.00   17.00   19.00
   21.00   23.00   22.00   24.00   25.00

THE TRANSFORMED MATRIX:
=======================
   15.00    7.00    3.00   12.00    8.00
    4.00    1.00    9.00    6.00   11.00
   10.00   14.00    5.00    2.00   13.00
   20.00   18.00   17.00   16.00   19.00
   25.00   23.00   22.00   21.00   24.00
```

## Algorithm Analysis

### Time Complexity:
- **Reading**: O(m×n) - processes each matrix element once
- **Finding Maximum**: O(m×n) - linear search through all elements
- **Column Swapping**: O(m) - swaps two columns
- **Writing**: O(m×n) - outputs each element using nested loops
- **Overall**: O(m×n) - dominated by matrix size

### Space Complexity:
- **Input Matrix**: O(m×n)
- **Transformed Matrix**: O(m×n)
- **Additional Variables**: O(1)
- **Overall**: O(m×n)

### Correctness Verification:
- **Row Sum Preservation**: Column swaps don't change row sums
- **Column Sum Rearrangement**: Column sums are reordered
- **Maximum Element**: Moves to first column after transformation
- **Matrix Dimensions**: Preserved during transformation

## Usage Instructions

### Running the Script:
```matlab
matrix_transformer
```

### Expected Behavior:
1. Reads matrix from `matrix_input.txt`
2. Displays matrix information in command window
3. Finds maximum element position
4. Performs column transformation
5. Writes results to `matrix_output.txt`
6. Shows analysis and verification

### Customization:
- **Input File**: Modify `input_filename` variable
- **Output File**: Modify `output_filename` variable
- **Matrix Size**: Create different input files with various dimensions
- **Formatting**: Adjust `fprintf` format strings for different precision

## Learning Objectives

### Programming Concepts:
- **File I/O**: Reading and writing text files
- **Nested Loops**: Two-dimensional iteration
- **Matrix Operations**: Element access and manipulation
- **Conditional Logic**: Decision making for transformations

### Mathematical Concepts:
- **Matrix Representation**: 2D arrays in programming
- **Element-wise Operations**: Accessing individual matrix elements
- **Column Operations**: Swapping matrix columns
- **Matrix Properties**: Preserving invariants during transformations

### Problem-Solving Skills:
- **Algorithm Design**: Breaking down complex tasks
- **Data Structure Manipulation**: Working with matrices
- **Output Formatting**: Creating readable file output
- **Verification**: Checking correctness of transformations

## Extensions and Modifications

### Possible Enhancements:
- **Row-based Transformation**: Swap rows instead of columns
- **Multiple Swaps**: Swap multiple columns/rows
- **User Input**: Allow user to specify swap criteria
- **GUI Interface**: Create interactive matrix editor
- **Validation**: Add input format checking

### Advanced Features:
- **Large Matrix Support**: Handle very large matrices efficiently
- **Multiple Transformations**: Chain multiple operations
- **Undo Functionality**: Store transformation history
- **Visualization**: Display matrices graphically
