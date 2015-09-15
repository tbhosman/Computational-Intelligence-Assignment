function gradient = calc_gradient_hidden(w_Lnext,gradient_Lnext,output_Lcurr);
%Calculates gradient of hidden layer
%   w_Lnext is weight matrix of between current and next layer
%   gradient_Lnext is gradient vector of next layer
%   output_Lcurr is output vector of current layer

    [w_y,w_x] = size(w_Lnext);
    grad_len = length(gradient_Lnext);
    out_len = length(output_Lcurr);
    
    if ((w_x == out_len) && (w_y == grad_len))
        w_mult = w_Lnext' * gradient_Lnext';
        gradient = output_Lcurr .* (1-output_Lcurr) .* w_mult';
    else
        error('matrix dimensions of hidden layer are wrong');
    end
end

