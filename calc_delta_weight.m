function dweight = calc_delta_weight(  input_outputlayer, learning_rate, gradient  )
% CalcDeltaw Berekend de delta w
% input_outputlayer is de input op de laatste (en dus output) layer

    dweight = learning_rate .* input_outputlayer * gradient;

end

