# Task 6: Array Processing with Two Function Options - Documentation

## Task Description
1. Create two function options to solve the array processing problem:
   - Option 1: Transfer input/output through global variables
   - Option 2: Transfer input/output through formal and actual parameters
2. Set source data in command window and call functions with input/output values
3. Use static variables to count calls to each function and a global variable for total calls
4. Extract function names and call count values from the functions

## Problem Statement
**In a one-dimensional array, calculate the sum of the elements up to the last zero and the product of the elements located to the right of it.**

## Files Created

### 1. `array_processor_global.m`
**Function Option 1 - Global Variables**
- Uses global variables for input and output
- Static variable for individual function call counting
- Accesses global counter for total calls

**Global Variables Used:**
- `input_array` - Input data
- `sum_before_zero` - Output: sum of elements before last zero
- `product_after_zero` - Output: product of elements after last zero
- `total_function_calls` - Global counter for all function calls

### 2. `array_processor_params.m`
**Function Option 2 - Formal Parameters**
- Uses formal parameters for input and output
- Static variable for individual function call counting
- Accesses global counter for total calls

**Function Signature:**
```matlab
function [sum_before, product_after, call_info] = array_processor_params(input_array)
```

### 3. `task6_demo.m`
**Main Demonstration Script**
- Initializes global variables
- Tests both functions with various test cases
- Demonstrates call counting functionality
- Shows how to extract function information

### 4. `README.md`
Comprehensive documentation (this file)

## Implementation Details

### Core Algorithm:
```matlab
% Find the last zero in the array
last_zero_index = -1;
for i = length(input_array):-1:1
    if input_array(i) == 0
        last_zero_index = i;
        break;
    end
end

% Calculate results based on zero position
if last_zero_index == -1
    % No zero found
    sum_before = sum(input_array);
    product_after = 1;
elseif last_zero_index == length(input_array)
    % Zero is last element
    sum_before = sum(input_array(1:last_zero_index-1));
    product_after = 1;
else
    % Normal case
    sum_before = sum(input_array(1:last_zero_index-1));
    product_after = prod(input_array(last_zero_index+1:end));
end
```

### Static Variable Implementation:
```matlab
persistent call_count_global;  % or call_count_params

if isempty(call_count_global)
    call_count_global = 0;
end

call_count_global = call_count_global + 1;
```

### Global Variable Management:
```matlab
global total_function_calls;
total_function_calls = total_function_calls + 1;
```

## Test Cases Demonstrated

### Test Case 1: Zero in Middle
- **Input**: `[3, 5, 2, 0, 7, 4, 1, 6]`
- **Expected**: Sum = 10, Product = 168
- **Logic**: Last zero at position 4, sum of [3,5,2], product of [7,4,1,6]

### Test Case 2: No Zeros
- **Input**: `[2, 4, 6, 8, 10]`
- **Expected**: Sum = 30, Product = 1
- **Logic**: No zero found, sum all elements, product = 1

### Test Case 3: Zero at End
- **Input**: `[1, 3, 5, 7, 0]`
- **Expected**: Sum = 16, Product = 1
- **Logic**: Zero is last element, sum all before, no elements after

### Test Case 4: Multiple Zeros
- **Input**: `[1, 0, 3, 5, 0, 7, 9]`
- **Expected**: Sum = 9, Product = 63
- **Logic**: Last zero at position 5, sum of [1,0,3,5], product of [7,9]

## Function Comparison

### Option 1: Global Variables
**Advantages:**
- Simple function signature
- Easy access to shared data
- Suitable for global state management

**Disadvantages:**
- Potential for naming conflicts
- Less modular design
- Harder to debug side effects

**Usage:**
```matlab
global input_array sum_before_zero product_after_zero;
input_array = [3, 5, 2, 0, 7, 4, 1, 6];
result = array_processor_global();
% Results available in global variables
```

### Option 2: Formal Parameters
**Advantages:**
- Clear input/output interface
- Better encapsulation
- Easier to test and debug
- More modular design

**Disadvantages:**
- More complex function signature
- Requires explicit parameter passing

**Usage:**
```matlab
input_array = [3, 5, 2, 0, 7, 4, 1, 6];
[sum_before, product_after, call_info] = array_processor_params(input_array);
```

## Call Counting System

### Static Variables (Function-Specific):
- `call_count_global` - Counts calls to `array_processor_global`
- `call_count_params` - Counts calls to `array_processor_params`
- Persistent across function calls
- Initialized to 0 on first call

### Global Variable (Total):
- `total_function_calls` - Counts all function calls
- Shared between both functions
- Incremented by each function call

### Call Information Structure:
```matlab
call_info = struct('function_name', function_name, ...
                  'local_calls', call_count_params, ...
                  'total_calls', total_function_calls);
```

## Usage Instructions

### Running the Demonstration:
```matlab
task6_demo
```

### Expected Output:
1. **Test Case Results**: Sum and product calculations for each test case
2. **Call Statistics**: Individual and total function call counts
3. **Function Information**: Names and call counts extracted from functions
4. **Global Variable Access**: Direct access to current global values

### Manual Testing:
```matlab
% Initialize global variables
global total_function_calls input_array sum_before_zero product_after_zero;
total_function_calls = 0;

% Test with custom array
input_array = [1, 2, 0, 3, 4];
result = array_processor_global();
[sum_val, prod_val, info] = array_processor_params(input_array);
```

## Learning Objectives

### Programming Concepts:
- **Global Variables**: Shared state management
- **Static Variables**: Persistent local state
- **Function Parameters**: Input/output interfaces
- **Call Counting**: Tracking function usage
- **Data Structures**: Structured return values

### Algorithm Development:
- **Array Processing**: One-dimensional array manipulation
- **Search Algorithms**: Finding specific elements
- **Conditional Logic**: Handling different scenarios
- **Mathematical Operations**: Sum and product calculations

### Software Design:
- **Function Design**: Multiple approaches to same problem
- **Interface Design**: Different parameter passing methods
- **State Management**: Global vs local state
- **Testing Strategies**: Multiple test cases

## Extensions and Modifications

### Possible Enhancements:
- **Error Handling**: Invalid input validation
- **Performance Optimization**: Vectorized operations
- **Additional Statistics**: Min, max, average calculations
- **GUI Interface**: Interactive array input
- **File I/O**: Read/write arrays from/to files

### Advanced Features:
- **Recursive Implementation**: Alternative algorithm approach
- **Memory Management**: Efficient large array handling
- **Parallel Processing**: Multi-threaded calculations
- **Logging System**: Detailed function call logging
