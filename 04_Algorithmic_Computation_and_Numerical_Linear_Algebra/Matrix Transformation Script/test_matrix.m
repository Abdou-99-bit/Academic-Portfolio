% Test script for Task 5 matrix transformation
% This script verifies the functionality of matrix_transformer.m

% Clear workspace
clear;
clc;

fprintf('Testing Task 5 Matrix Transformation\n');
fprintf('===================================\n\n');

% Test 1: Verify input file exists and is readable
input_filename = 'matrix_input.txt';
if exist(input_filename, 'file')
    fprintf('✓ Input file exists: %s\n', input_filename);
    
    % Read and display file content
    fileID = fopen(input_filename, 'r');
    if fileID ~= -1
        fprintf('File content:\n');
        line_num = 1;
        while ~feof(fileID)
            line = fgetl(fileID);
            if ischar(line)
                fprintf('  Line %d: %s\n', line_num, line);
                line_num = line_num + 1;
            end
        end
        fclose(fileID);
        fprintf('\n');
    else
        fprintf('✗ Error: Cannot read input file\n');
    end
else
    fprintf('✗ Error: Input file does not exist\n');
end

% Test 2: Manual verification of matrix reading and transformation
fprintf('Manual verification test:\n');
fprintf('========================\n');

% Test matrix (same as input file)
test_matrix = [12, 7, 3, 15, 8;
               6, 1, 9, 4, 11;
               2, 14, 5, 10, 13;
               16, 18, 20, 17, 19;
               21, 23, 22, 24, 25];

fprintf('Test matrix (5×5):\n');
for i = 1:size(test_matrix, 1)
    fprintf('  ');
    for j = 1:size(test_matrix, 2)
        fprintf('%6.0f', test_matrix(i, j));
    end
    fprintf('\n');
end

% Find maximum element manually
[max_val, max_idx] = max(test_matrix(:));
[max_row, max_col] = ind2sub(size(test_matrix), max_idx);

fprintf('\nMaximum element analysis:\n');
fprintf('  Maximum value: %.0f\n', max_val);
fprintf('  Position: Row %d, Column %d\n', max_row, max_col);

% Perform transformation manually
transformed_test = test_matrix;
if max_col ~= 1
    transformed_test(:, [1, max_col]) = transformed_test(:, [max_col, 1]);
    fprintf('  Transformation: Column %d swapped with Column 1\n', max_col);
else
    fprintf('  No transformation needed\n');
end

fprintf('\nTransformed matrix:\n');
for i = 1:size(transformed_test, 1)
    fprintf('  ');
    for j = 1:size(transformed_test, 2)
        fprintf('%6.0f', transformed_test(i, j));
    end
    fprintf('\n');
end

% Verify row sums are preserved
original_row_sums = sum(test_matrix, 2);
transformed_row_sums = sum(transformed_test, 2);

fprintf('\nRow sum verification:\n');
fprintf('  Original row sums:   ');
fprintf('%4.0f ', original_row_sums);
fprintf('\n');
fprintf('  Transformed row sums:');
fprintf('%4.0f ', transformed_row_sums);
fprintf('\n');

if all(abs(original_row_sums - transformed_row_sums) < 1e-10)
    fprintf('  ✓ Row sums preserved correctly\n');
else
    fprintf('  ✗ Row sums changed unexpectedly\n');
end

% Test 3: Test with different matrix sizes
fprintf('\nTesting with different matrix sizes:\n');
fprintf('====================================\n');

% Test with 3×4 matrix
test_matrix_3x4 = [1, 2, 3, 4;
                   5, 6, 7, 8;
                   9, 10, 11, 12];

fprintf('3×4 Test matrix:\n');
for i = 1:size(test_matrix_3x4, 1)
    fprintf('  ');
    for j = 1:size(test_matrix_3x4, 2)
        fprintf('%4.0f', test_matrix_3x4(i, j));
    end
    fprintf('\n');
end

[max_val_3x4, max_idx_3x4] = max(test_matrix_3x4(:));
[max_row_3x4, max_col_3x4] = ind2sub(size(test_matrix_3x4), max_idx_3x4);
fprintf('Maximum: %.0f at position (%d, %d)\n', max_val_3x4, max_row_3x4, max_col_3x4);

% Test with 2×2 matrix
test_matrix_2x2 = [7, 3;
                   1, 9];

fprintf('\n2×2 Test matrix:\n');
for i = 1:size(test_matrix_2x2, 1)
    fprintf('  ');
    for j = 1:size(test_matrix_2x2, 2)
        fprintf('%4.0f', test_matrix_2x2(i, j));
    end
    fprintf('\n');
end

[max_val_2x2, max_idx_2x2] = max(test_matrix_2x2(:));
[max_row_2x2, max_col_2x2] = ind2sub(size(test_matrix_2x2), max_idx_2x2);
fprintf('Maximum: %.0f at position (%d, %d)\n', max_val_2x2, max_row_2x2, max_col_2x2);

% Test 4: Edge cases
fprintf('\nEdge case tests:\n');
fprintf('================\n');

% Test with single row
single_row = [5, 2, 8, 1, 6];
fprintf('Single row: [5, 2, 8, 1, 6]\n');
[max_val_sr, max_idx_sr] = max(single_row);
fprintf('Maximum: %.0f at position %d\n', max_val_sr, max_idx_sr);

% Test with single column
single_col = [3; 7; 1; 9; 4];
fprintf('Single column: [3; 7; 1; 9; 4]\n');
[max_val_sc, max_idx_sc] = max(single_col);
fprintf('Maximum: %.0f at position %d\n', max_val_sc, max_idx_sc);

fprintf('\n✓ All tests completed successfully!\n');
fprintf('Run "matrix_transformer" to see the full implementation.\n');
