function [deltaw,gradient] = give_deltaw_hidden(output_Lcurr,gradient_Lnext,w_Lnext,output_Lprev,learning_rate)
% give_deltaw_hidden gives the delta w for hidden layers of the NN
%   output is the calculated output
%   gradient_Lnext is the gradient of the next layer
%   w_Lnext is the weight matrix between current and previous layer
%   output_Lprev is the output vector of the previous layer
    gradient = calc_gradient_hidden(w_Lnext,gradient_Lnext,output_Lcurr);
    deltaw = calc_delta_weight(output_Lprev, learning_rate, gradient);
end
