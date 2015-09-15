function [deltaw,gradient,error] = give_deltaw(y_desired , y_actual, output, input_outputlayer, learning_rate)
% RunCalcs gives the delta w for last layer of the NN
%   y_desired is de gewenste output binair
%   y_actual is de gekregen output binair
%   output is de gekregen output (NIET BINAIR)
%   input_outputlayer is de input op de laatste (en dus output) layer
    error = calc_error(y_desired, y_actual);
    gradient = calc_gradient(output, error);
    deltaw = calc_delta_weight(input_outputlayer, learning_rate, gradient);
end

