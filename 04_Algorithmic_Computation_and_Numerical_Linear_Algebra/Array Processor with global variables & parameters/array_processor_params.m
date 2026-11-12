% Task 6: Function Option 2 - Using Formal and Actual Parameters
% This function calculates sum of elements up to last zero and product of elements after last zero
% Input and output handled through formal parameters

function [sum_before, product_after, call_info] = array_processor_params(input_array)
    % Static variable to count calls to this specific function
    persistent call_count_params;
    
    % Initialize static variable on first call
    if isempty(call_count_params)
        call_count_params = 0;
    end
    
    % Increment call count for this function
    call_count_params = call_count_params + 1;
    
    % Increment total call count (global variable)
    global total_function_calls;
    total_function_calls = total_function_calls + 1;
    
    % Get function name for output
    function_name = 'array_processor_params';
    
    fprintf('=== Function Call %d: %s ===\n', call_count_params, function_name);
    fprintf('Input array: [');
    fprintf('%.0f ', input_array);
    fprintf(']\n');
    
    % Find the last zero in the array
    last_zero_index = -1;
    for i = length(input_array):-1:1
        if input_array(i) == 0
            last_zero_index = i;
            break;
        end
    end
    
    % Calculate results based on whether zero was found
    if last_zero_index == -1
        % No zero found - sum all elements, product is 1
        sum_before = sum(input_array);
        product_after = 1;
        fprintf('No zero found in array.\n');
        fprintf('Sum of all elements: %.2f\n', sum_before);
        fprintf('Product after last zero: %.2f (no zero found)\n', product_after);
    elseif last_zero_index == length(input_array)
        % Zero is the last element
        sum_before = sum(input_array(1:last_zero_index-1));
        product_after = 1;
        fprintf('Last zero is at position %d (last element).\n', last_zero_index);
        fprintf('Sum of elements before zero: %.2f\n', sum_before);
        fprintf('Product after last zero: %.2f (no elements after)\n', product_after);
    else
        % Normal case - zero found somewhere in the middle
        sum_before = sum(input_array(1:last_zero_index-1));
        product_after = prod(input_array(last_zero_index+1:end));
        fprintf('Last zero found at position %d.\n', last_zero_index);
        fprintf('Sum of elements before zero: %.2f\n', sum_before);
        fprintf('Product of elements after zero: %.2f\n', product_after);
    end
    
    % Display call statistics
    fprintf('This function call count: %d\n', call_count_params);
    fprintf('Total function calls: %d\n', total_function_calls);
    fprintf('=====================================\n\n');
    
    % Create call information structure
    call_info = struct('function_name', function_name, ...
                      'local_calls', call_count_params, ...
                      'total_calls', total_function_calls);
end
