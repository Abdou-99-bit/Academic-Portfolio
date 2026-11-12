% Task 3: Array Processing Script
% 1. Read numerical sequence from file
% 2. Display array with indices in multiple columns
% 3. Count number of units (1s) in even positions using loop

% Clear workspace and command window
clear;
clc;

% Step 1: Read numerical sequence from file
fprintf('Task 3: Array Processing\n');
fprintf('========================\n\n');

% Read data from text file
filename = 'numerical_sequence.txt';
fileID = fopen(filename, 'r');

if fileID == -1
    error('Could not open file: %s', filename);
end

% Read the numerical sequence
data = fscanf(fileID, '%f');
fclose(fileID);

fprintf('Successfully read %d elements from file: %s\n\n', length(data), filename);

% Step 2: Display array with indices in multiple columns
fprintf('Array Elements with Indices:\n');
fprintf('============================\n');

% Determine optimal number of columns for display
num_elements = length(data);
if num_elements <= 10
    num_cols = 5;
elseif num_elements <= 20
    num_cols = 6;
else
    num_cols = 8;
end

% Display array with indices
fprintf('Index | Value\n');
fprintf('------|-------\n');

for i = 1:num_elements
    fprintf('%5d | %6.2f', i, data(i));
    
    % Move to next line after specified number of columns
    if mod(i, num_cols) == 0
        fprintf('\n');
    else
        fprintf('   ');
    end
end

fprintf('\n\n');

% Step 3: Count number of units (1s) in even positions using loop
fprintf('Analysis of Units in Even Positions:\n');
fprintf('=====================================\n');

unit_count = 0;  % Counter for units (value = 1)
even_positions = [];  % Store even positions that contain units

% Loop through array using parameter (for loop)
for i = 1:num_elements
    % Check if current position is even
    if mod(i, 2) == 0
        % Check if the value at this even position is 1
        if data(i) == 1
            unit_count = unit_count + 1;
            even_positions = [even_positions, i];
        end
    end
end

% Display results
fprintf('Total number of elements: %d\n', num_elements);
fprintf('Number of even positions: %d\n', floor(num_elements/2));
fprintf('Number of units (value = 1) in even positions: %d\n', unit_count);

if unit_count > 0
    fprintf('Even positions containing units: ');
    for i = 1:length(even_positions)
        fprintf('%d', even_positions(i));
        if i < length(even_positions)
            fprintf(', ');
        end
    end
    fprintf('\n');
else
    fprintf('No units found in even positions.\n');
end

% Additional analysis
fprintf('\nAdditional Information:\n');
fprintf('======================\n');
fprintf('Array statistics:\n');
fprintf('  - Minimum value: %.2f\n', min(data));
fprintf('  - Maximum value: %.2f\n', max(data));
fprintf('  - Mean value: %.2f\n', mean(data));
fprintf('  - Sum of all elements: %.2f\n', sum(data));

% Count total units in the entire array
total_units = sum(data == 1);
fprintf('  - Total units in entire array: %d\n', total_units);

fprintf('\nTask 3 completed successfully!\n');
