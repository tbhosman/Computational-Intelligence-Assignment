function gradient = calc_gradient(  output, error )
% CalcGradient berekend de gradient
%   output is de output van de output layer (NIET BINAIR)
    gradient = output .* (1-output) .* error;

end

