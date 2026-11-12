% Task 6: Main Script - Demonstration of Both Function Options
% This script demonstrates both global variable and parameter-based approaches
% with static variables for call counting and global variable for total calls

% Clear workspace and command window
clear;
clc;

fprintf('Task 6: Array Processing with Two Function Options\n');
fprintf('==================================================\n\n');

% Initialize global variables
global total_function_calls;
global input_array;
global sum_before_zero;
global product_after_zero;

% Initialize total call counter
total_function_calls = 0;

fprintf('Global variables initialized.\n');
fprintf('Total function calls: %d\n\n', total_function_calls);

% Test Case 1: Array with zero in the middle
fprintf('=== Test Case 1: Array with zero in the middle ===\n');
input_array = [3, 5, 2, 0, 7, 4, 1, 6];

fprintf('Input array: [3, 5, 2, 0, 7, 4, 1, 6]\n');
fprintf('Expected: Sum before zero = 10, Product after zero = 168\n\n');

% Call function option 1 (global variables)
fprintf('--- Calling Function Option 1 (Global Variables) ---\n');
result1 = array_processor_global();

% Display results from global variables
fprintf('Results from global variables:\n');
fprintf('Sum before zero: %.2f\n', sum_before_zero);
fprintf('Product after zero: %.2f\n', product_after_zero);

% Call function option 2 (parameters)
fprintf('--- Calling Function Option 2 (Parameters) ---\n');
[sum_param, product_param, call_info1] = array_processor_params(input_array);

% Display results from parameters
fprintf('Results from parameters:\n');
fprintf('Sum before zero: %.2f\n', sum_param);
fprintf('Product after zero: %.2f\n', product_param);

% Verify results are identical
if abs(sum_before_zero - sum_param) < 1e-10 && abs(product_after_zero - product_param) < 1e-10
    fprintf('✓ Both functions produce identical results\n');
else
    fprintf('✗ Results differ between functions\n');
end

fprintf('\n');

% Test Case 2: Array with no zeros
fprintf('=== Test Case 2: Array with no zeros ===\n');
input_array = [2, 4, 6, 8, 10];

fprintf('Input array: [2, 4, 6, 8, 10]\n');
fprintf('Expected: Sum of all elements = 30, Product = 1\n\n');

% Call function option 1
result2 = array_processor_global();

% Call function option 2
[sum_param2, product_param2, call_info2] = array_processor_params(input_array);

fprintf('\n');

% Test Case 3: Array with zero at the end
fprintf('=== Test Case 3: Array with zero at the end ===\n');
input_array = [1, 3, 5, 7, 0];

fprintf('Input array: [1, 3, 5, 7, 0]\n');
fprintf('Expected: Sum before zero = 16, Product = 1\n\n');

% Call function option 1
result3 = array_processor_global();

% Call function option 2
[sum_param3, product_param3, call_info3] = array_processor_params(input_array);

fprintf('\n');

% Test Case 4: Array with multiple zeros (should use last one)
fprintf('=== Test Case 4: Array with multiple zeros ===\n');
input_array = [1, 0, 3, 5, 0, 7, 9];

fprintf('Input array: [1, 0, 3, 5, 0, 7, 9]\n');
fprintf('Expected: Last zero at position 5, Sum before = 9, Product after = 63\n\n');

% Call function option 1
result4 = array_processor_global();

% Call function option 2
[sum_param4, product_param4, call_info4] = array_processor_params(input_array);

fprintf('\n');

% Summary of all function calls
fprintf('=== Summary of Function Calls ===\n');
fprintf('Total function calls made: %d\n', total_function_calls);
fprintf('\n');

% Display call information from each function call
fprintf('Call Information Extracted from Functions:\n');
fprintf('==========================================\n');

if exist('result1', 'var')
    fprintf('Call 1 - %s: Local calls = %d, Total calls = %d\n', ...
            result1.function_name, result1.local_calls, result1.total_calls);
end

if exist('call_info1', 'var')
    fprintf('Call 2 - %s: Local calls = %d, Total calls = %d\n', ...
            call_info1.function_name, call_info1.local_calls, call_info1.total_calls);
end

if exist('result2', 'var')
    fprintf('Call 3 - %s: Local calls = %d, Total calls = %d\n', ...
            result2.function_name, result2.local_calls, result2.total_calls);
end

if exist('call_info2', 'var')
    fprintf('Call 4 - %s: Local calls = %d, Total calls = %d\n', ...
            call_info2.function_name, call_info2.local_calls, call_info2.total_calls);
end

if exist('result3', 'var')
    fprintf('Call 5 - %s: Local calls = %d, Total calls = %d\n', ...
            result3.function_name, result3.local_calls, result3.total_calls);
end

if exist('call_info3', 'var')
    fprintf('Call 6 - %s: Local calls = %d, Total calls = %d\n', ...
            call_info3.function_name, call_info3.local_calls, call_info3.total_calls);
end

if exist('result4', 'var')
    fprintf('Call 7 - %s: Local calls = %d, Total calls = %d\n', ...
            result4.function_name, result4.local_calls, result4.total_calls);
end

if exist('call_info4', 'var')
    fprintf('Call 8 - %s: Local calls = %d, Total calls = %d\n', ...
            call_info4.function_name, call_info4.local_calls, call_info4.total_calls);
end

fprintf('\n');

% Demonstrate accessing global variables directly
fprintf('Direct Access to Global Variables:\n');
fprintf('===================================\n');
fprintf('Current input array: [');
fprintf('%.0f ', input_array);
fprintf(']\n');
fprintf('Sum before zero (global): %.2f\n', sum_before_zero);
fprintf('Product after zero (global): %.2f\n', product_after_zero);
fprintf('Total function calls (global): %d\n', total_function_calls);

fprintf('\nTask 6 completed successfully!\n');
fprintf('Both function options have been demonstrated with call counting.\n');
