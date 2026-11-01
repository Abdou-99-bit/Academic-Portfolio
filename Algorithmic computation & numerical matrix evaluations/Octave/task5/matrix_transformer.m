% Task 5: Matrix Transformation Script
% 1. Read matrix from text file
% 2. Find column with maximum element and swap with first column
% 3. Output original and transformed matrices to file using nested loops

% Clear workspace and command window
clear;
clc;

fprintf('Task 5: Matrix Transformation\n');
fprintf('=============================\n\n');

% Step 1: Read matrix from input file
input_filename = 'matrix_input.txt';
output_filename = 'matrix_output.txt';

fprintf('Reading matrix from file: %s\n', input_filename);

% Check if input file exists
if ~exist(input_filename, 'file')
    error('Input file %s not found!', input_filename);
end

% Read matrix from file
fileID = fopen(input_filename, 'r');
if fileID == -1
    error('Could not open input file: %s', input_filename);
end

% Read the matrix
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

% Get matrix dimensions
[rows, cols] = size(matrix);

fprintf('Matrix loaded successfully!\n');
fprintf('Dimensions: %d rows × %d columns\n\n', rows, cols);

% Step 2: Find the column containing the maximum element
fprintf('Finding column with maximum element...\n');

[max_value, max_linear_index] = max(matrix(:));
[max_row, max_col] = ind2sub([rows, cols], max_linear_index);

fprintf('Maximum element: %.2f\n', max_value);
fprintf('Position: Row %d, Column %d\n\n', max_row, max_col);

% Step 3: Create transformed matrix by swapping columns
fprintf('Creating transformed matrix...\n');

% Create a copy of the original matrix
transformed_matrix = matrix;

% Swap the column with maximum element (max_col) with the first column (column 1)
if max_col ~= 1
    transformed_matrix(:, [1, max_col]) = transformed_matrix(:, [max_col, 1]);
    fprintf('Swapped column %d with column 1\n', max_col);
else
    fprintf('Maximum element is already in column 1, no swap needed\n');
end

% Step 4: Output both matrices to file using nested loops
fprintf('Writing results to output file: %s\n', output_filename);

% Open output file for writing
fileID = fopen(output_filename, 'w');
if fileID == -1
    error('Could not create output file: %s', output_filename);
end

% Write the original matrix using nested loops
fprintf(fileID, 'THE ORIGINAL MATRIX:\n');
fprintf(fileID, '====================\n');

for i = 1:rows
    for j = 1:cols
        fprintf(fileID, '%8.2f', matrix(i, j));
    end
    fprintf(fileID, '\n');
end

% Add separator between matrices
fprintf(fileID, '\n');

% Write the transformed matrix using nested loops
fprintf(fileID, 'THE TRANSFORMED MATRIX:\n');
fprintf(fileID, '=======================\n');

for i = 1:rows
    for j = 1:cols
        fprintf(fileID, '%8.2f', transformed_matrix(i, j));
    end
    fprintf(fileID, '\n');
end

% Close the output file
fclose(fileID);

fprintf('Results written successfully!\n\n');

% Step 5: Display results in command window
fprintf('Results Summary:\n');
fprintf('================\n');
fprintf('Input file: %s\n', input_filename);
fprintf('Output file: %s\n', output_filename);
fprintf('Matrix size: %d × %d\n', rows, cols);
fprintf('Maximum element: %.2f at position (%d, %d)\n', max_value, max_row, max_col);

if max_col ~= 1
    fprintf('Transformation: Column %d swapped with Column 1\n', max_col);
else
    fprintf('Transformation: No swap needed (max already in Column 1)\n');
end

% Display original matrix
fprintf('\nOriginal Matrix:\n');
for i = 1:rows
    for j = 1:cols
        fprintf('%8.2f', matrix(i, j));
    end
    fprintf('\n');
end

% Display transformed matrix
fprintf('\nTransformed Matrix:\n');
for i = 1:rows
    for j = 1:cols
        fprintf('%8.2f', transformed_matrix(i, j));
    end
    fprintf('\n');
end

% Additional analysis
fprintf('\nMatrix Analysis:\n');
fprintf('================\n');
fprintf('Original Matrix Statistics:\n');
fprintf('  - Row sums: ');
row_sums = sum(matrix, 2);
fprintf('%.2f ', row_sums);
fprintf('\n');

fprintf('  - Column sums: ');
col_sums = sum(matrix, 1);
fprintf('%.2f ', col_sums);
fprintf('\n');

fprintf('  - Total sum: %.2f\n', sum(matrix(:)));

fprintf('\nTransformed Matrix Statistics:\n');
fprintf('  - Row sums: ');
row_sums_transformed = sum(transformed_matrix, 2);
fprintf('%.2f ', row_sums_transformed);
fprintf('\n');

fprintf('  - Column sums: ');
col_sums_transformed = sum(transformed_matrix, 1);
fprintf('%.2f ', col_sums_transformed);
fprintf('\n');

fprintf('  - Total sum: %.2f\n', sum(transformed_matrix(:)));

% Verify that row sums remain the same (column swap doesn't change row sums)
if all(abs(row_sums - row_sums_transformed) < 1e-10)
    fprintf('✓ Row sums preserved (as expected for column swap)\n');
else
    fprintf('✗ Row sums changed unexpectedly\n');
end

fprintf('\nTask 5 completed successfully!\n');
fprintf('Both original and transformed matrices have been written to %s\n', output_filename);
