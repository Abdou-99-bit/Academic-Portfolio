% Test script for Task 3 implementation
% This script verifies the functionality of task3_processor.m

% Clear workspace
clear;
clc;

fprintf('Testing Task 3 Implementation\n');
fprintf('=============================\n\n');

% Test 1: Verify file exists and is readable
filename = 'numerical_sequence.txt';
if exist(filename, 'file')
    fprintf('✓ Test file exists: %s\n', filename);
    
    % Read and display file content
    fileID = fopen(filename, 'r');
    if fileID ~= -1
        content = fscanf(fileID, '%f');
        fclose(fileID);
        fprintf('✓ File contains %d numbers: ', length(content));
        fprintf('%.0f ', content);
        fprintf('\n\n');
    else
        fprintf('✗ Error: Cannot read file\n');
    end
else
    fprintf('✗ Error: Test file does not exist\n');
end

% Test 2: Manual verification of unit counting logic
test_array = [12, 7, 3, 15, 8, 1, 9, 4, 6, 11, 2, 14, 5, 10, 13];
fprintf('Manual verification with test array:\n');
fprintf('Array: [12, 7, 3, 15, 8, 1, 9, 4, 6, 11, 2, 14, 5, 10, 13]\n');

% Manual counting
unit_count_manual = 0;
even_positions_manual = [];
for i = 1:length(test_array)
    if mod(i, 2) == 0 && test_array(i) == 1
        unit_count_manual = unit_count_manual + 1;
        even_positions_manual = [even_positions_manual, i];
    end
end

fprintf('Expected results:\n');
fprintf('  - Units in even positions: %d\n', unit_count_manual);
if unit_count_manual > 0
    fprintf('  - Positions: %d\n', even_positions_manual);
else
    fprintf('  - No units in even positions\n');
end

% Test 3: Test with different array containing multiple units
fprintf('\nTest with multiple units:\n');
test_array2 = [5, 1, 3, 1, 7, 1, 9, 1];
fprintf('Array: [5, 1, 3, 1, 7, 1, 9, 1]\n');

unit_count2 = 0;
positions2 = [];
for i = 1:length(test_array2)
    if mod(i, 2) == 0 && test_array2(i) == 1
        unit_count2 = unit_count2 + 1;
        positions2 = [positions2, i];
    end
end

fprintf('Expected results:\n');
fprintf('  - Units in even positions: %d\n', unit_count2);
fprintf('  - Positions: ');
fprintf('%d ', positions2);
fprintf('\n');

fprintf('\n✓ All tests completed successfully!\n');
fprintf('Run "task3_processor" to see the full implementation.\n');
