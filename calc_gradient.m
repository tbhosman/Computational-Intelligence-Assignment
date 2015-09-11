function gradient = calc_gradient( error , output )
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here
    gradient = output .* (1-output) .* error;

end

