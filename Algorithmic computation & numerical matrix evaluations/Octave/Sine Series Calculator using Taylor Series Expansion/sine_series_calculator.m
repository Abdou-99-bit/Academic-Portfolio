% Sine Series Calculator using Taylor Series Expansion
% sin(x) = x - x^3/3! + x^5/5! - x^7/7! + ...

% Clear workspace and close any open files
clear;
clc;

% Read input value x from keyboard
x = input('Enter the value of x (in radians): ');

% Initialize variables
n = 1;                      % Current term number (starting from 1)
term = x;                   % First term of the series (x^1/1!)
sum_series = term;          % Current sum of the series
accuracy = 1e-5;            % Required accuracy
prev_sum = 0;               % Previous sum for accuracy check

% Open text file for writing results
fileID = fopen('sine_series_results.txt', 'w');

% Write header to file
fprintf(fileID, 'Sine Series Calculation Results\n');
fprintf(fileID, '================================\n');
fprintf(fileID, 'x = %.6f radians\n\n', x);
fprintf(fileID, 'Term No. | Term Value     | Current Sum\n');
fprintf(fileID, '---------|----------------|-------------\n');

% Display header in command window
fprintf('Sine Series Calculation\n');
fprintf('======================\n');
fprintf('x = %.6f radians\n\n', x);

% Main calculation loop
while abs(sum_series - prev_sum) > accuracy
    
    % Write current term information to file
    fprintf(fileID, '%8d | %14.8f | %12.8f\n', n, term, sum_series);
    
    % Calculate next term using recurrence relation
    % Recurrence relation: term_{n+1} = -term_n * x^2 / ((2n) * (2n+1))
    % where n starts from 1 for the first term x^1/1!
    term = -term * x^2 / ((2*n) * (2*n+1));
    
    % Update previous sum and calculate new sum
    prev_sum = sum_series;
    sum_series = sum_series + term;
    
    % Increment term counter
    n = n + 1;
    
    % Safety check to prevent infinite loop
    if n > 1000
        fprintf('Warning: Maximum iterations reached without achieving desired accuracy.\n');
        break;
    end
end

% Write final results to file
fprintf(fileID, '\nFinal Results:\n');
fprintf(fileID, 'Number of terms calculated: %d\n', n-1);
fprintf(fileID, 'Final sum: %.8f\n', sum_series);
fprintf(fileID, 'Actual sin(x): %.8f\n', sin(x));
fprintf(fileID, 'Absolute error: %.8f\n', abs(sum_series - sin(x)));

% Close the file
fclose(fileID);

% Display final results in command window
fprintf('\nFinal Results:\n');
fprintf('Number of terms calculated: %d\n', n-1);
fprintf('Calculated sin(%.6f) = %.8f\n', x, sum_series);
fprintf('Actual sin(%.6f) = %.8f\n', x, sin(x));
fprintf('Absolute error: %.8f\n', abs(sum_series - sin(x)));
fprintf('\nDetailed results have been saved to ''sine_series_results.txt''\n');
