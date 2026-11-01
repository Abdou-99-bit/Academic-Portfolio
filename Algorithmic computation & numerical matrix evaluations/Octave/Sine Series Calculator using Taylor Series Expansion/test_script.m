% Test script for sine_series_calculator
% This script demonstrates the usage with a predefined value

% Clear workspace
clear;
clc;

% Test with a known value
x_test = pi/6;  % 30 degrees, sin(pi/6) = 0.5

fprintf('Testing sine series calculator with x = pi/6 (%.6f radians)\n', x_test);
fprintf('Expected result: sin(pi/6) = 0.5\n\n');

% Simulate the calculation manually to verify the recurrence relation
n = 1;
term = x_test;
sum_series = term;
accuracy = 1e-5;
prev_sum = 0;

fprintf('Term %d: term = %.8f, sum = %.8f\n', n, term, sum_series);

% Calculate a few terms manually
for i = 1:5
    prev_sum = sum_series;
    term = -term * x_test^2 / ((2*n) * (2*n+1));
    sum_series = sum_series + term;
    n = n + 1;
    fprintf('Term %d: term = %.8f, sum = %.8f\n', n, term, sum_series);
end

fprintf('\nActual sin(pi/6) = %.8f\n', sin(x_test));
fprintf('Calculated value = %.8f\n', sum_series);
fprintf('Error = %.8f\n', abs(sum_series - sin(x_test)));
