% Task 6: Function Option 1 - Using Global Variables
% This function calculates sum of elements up to last zero and product of elements after last zero
% Input and output handled through global variables

function result = array_processor_global()
    % Static variable to count calls to this specific function
    persistent call_count_global;
    
    % Initialize static variable on first call
    if isempty(call_count_global)
        call_count_global = 0;
    end
    
    % Increment call count for this function
    call_count_global = call_count_global + 1;
    
    % Increment total call count (global variable)
    global total_function_calls;
    total_function_calls = total_function_calls + 1;
    
    % Declare global variables for input and output
    global input_array;
    global sum_before_zero;
    global product_after_zero;
    
    % Get function name for output
    function_name = 'array_processor_global';
    
    fprintf('=== Function Call %d: %s ===\n', call_count_global, function_name);
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
        sum_before_zero = sum(input_array);
        product_after_zero = 1;
        fprintf('No zero found in array.\n');
        fprintf('Sum of all elements: %.2f\n', sum_before_zero);
        fprintf('Product after last zero: %.2f (no zero found)\n', product_after_zero);
    elseif last_zero_index == length(input_array)
        % Zero is the last element
        sum_before_zero = sum(input_array(1:last_zero_index-1));
        product_after_zero = 1;
        fprintf('Last zero is at position %d (last element).\n', last_zero_index);
        fprintf('Sum of elements before zero: %.2f\n', sum_before_zero);
        fprintf('Product after last zero: %.2f (no elements after)\n', product_after_zero);
    else
        % Normal case - zero found somewhere in the middle
        sum_before_zero = sum(input_array(1:last_zero_index-1));
        product_after_zero = prod(input_array(last_zero_index+1:end));
        fprintf('Last zero found at position %d.\n', last_zero_index);
        fprintf('Sum of elements before zero: %.2f\n', sum_before_zero);
        fprintf('Product of elements after zero: %.2f\n', product_after_zero);
    end
    
    % Display call statistics
    fprintf('This function call count: %d\n', call_count_global);
    fprintf('Total function calls: %d\n', total_function_calls);
    fprintf('=====================================\n\n');
    
    % Return function name and call counts
    result = struct('function_name', function_name, ...
                    'local_calls', call_count_global, ...
                    'total_calls', total_function_calls);
end
