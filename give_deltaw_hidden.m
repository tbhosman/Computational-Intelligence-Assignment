function [deltaw,gradient] = give_deltaw_hidden(output_Lcurr,gradient_Lnext,w_Lnext,output_Lprev,learning_rate)
% RunCalcs gives the delta w for last layer of the NN
%   output is de gekregen output (NIET BINAIR)
%   gradient_Lnext is gradient van volgende laag
%   w_Lnext is weight matrix tussen huidige en volgende layer
%   output_Lprev is de output vector van de vorige laag
    gradient = calc_gradient_hidden(w_Lnext,gradient_Lnext,output_Lcurr);
    deltaw = calc_delta_weight(output_Lprev, learning_rate, gradient);
end
