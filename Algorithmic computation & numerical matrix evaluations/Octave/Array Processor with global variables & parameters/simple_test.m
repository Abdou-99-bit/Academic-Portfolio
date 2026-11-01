% Simple test script for Task 6 functions
% This script provides basic testing of both function options

% Clear workspace
clear;
clc;

fprintf('Simple Test for Task 6 Functions\n');
fprintf('=================================\n\n');

% Initialize global variables
global total_function_calls;
global input_array;
global sum_before_zero;
global product_after_zero;

% Initialize counters
total_function_calls = 0;

% Test 1: Basic functionality
fprintf('Test 1: Basic functionality\n');
input_array = [1, 2, 0, 3, 4];
fprintf('Input: [1, 2, 0, 3, 4]\n');

% Test global function
result_g = array_processor_global();
fprintf('Global function result: Sum=%.2f, Product=%.2f\n', sum_before_zero, product_after_zero);

% Test parameter function
[sum_p, product_p, info_p] = array_processor_params(input_array);
fprintf('Parameter function result: Sum=%.2f, Product=%.2f\n', sum_p, product_p);

% Verify results
if abs(sum_before_zero - sum_p) < 1e-10 && abs(product_after_zero - product_p) < 1e-10
    fprintf('✓ Results match\n');
else
    fprintf('✗ Results differ\n');
end

fprintf('\n');

% Test 2: Edge case - no zeros
fprintf('Test 2: No zeros in array\n');
input_array = [1, 2, 3, 4, 5];
fprintf('Input: [1, 2, 3, 4, 5]\n');

result_g2 = array_processor_global();
[sum_p2, product_p2, info_p2] = array_processor_params(input_array);

fprintf('Expected: Sum=15, Product=1\n');
fprintf('Global: Sum=%.2f, Product=%.2f\n', sum_before_zero, product_after_zero);
fprintf('Parameter: Sum=%.2f, Product=%.2f\n', sum_p2, product_p2);

fprintf('\n');

% Test 3: Edge case - zero at end
fprintf('Test 3: Zero at end of array\n');
input_array = [1, 2, 3, 4, 0];
fprintf('Input: [1, 2, 3, 4, 0]\n');

result_g3 = array_processor_global();
[sum_p3, product_p3, info_p3] = array_processor_params(input_array);

fprintf('Expected: Sum=10, Product=1\n');
fprintf('Global: Sum=%.2f, Product=%.2f\n', sum_before_zero, product_after_zero);
fprintf('Parameter: Sum=%.2f, Product=%.2f\n', sum_p3, product_p3);

fprintf('\n');

% Display call statistics
fprintf('Call Statistics:\n');
fprintf('================\n');
fprintf('Total function calls: %d\n', total_function_calls);
fprintf('Global function calls: %d\n', result_g.local_calls);
fprintf('Parameter function calls: %d\n', info_p.local_calls);

fprintf('\n✓ Simple tests completed!\n');
fprintf('Run "task6_demo" for comprehensive testing.\n');
