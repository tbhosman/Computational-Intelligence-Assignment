function dweight = calc_delta_weight( gradient, input_outputlayer, learning_rate  )
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here
    dweight = learning_rate .* input_outputlayer * gradient;

end

