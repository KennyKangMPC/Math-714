function [error] = maxErrorCal(A, B, diff)

% This function is used for the calculation of the max error between a
% coarse and a very fine vector
    % indexing
    index = 0:(length(B)-1)-1;
    subsetA = [diff * index + 1, length(A)];
    
    errorVector = abs(A(subsetA)-B);
    error = max(errorVector);
end

