function [deltaw,gradient,error] = give_deltaw(y_desired , y_actual, output, input_outputlayer, learning_rate)
% give_deltaw gives the delta w for last layer of the NN
%   y_desired is the desired output
%   y_actual is the calculated output
%   output is the calculated output (residue of older versions)
%   input_outputlayer is the input of the last layer
    error = calc_error(y_desired, y_actual);
    gradient = calc_gradient(output, error);
    deltaw = calc_delta_weight(input_outputlayer, learning_rate, gradient);
end

