function out = perc(x,w,thres)

% Perceptron
% Input: vector of inputs x each with a corresponding weight found in 
% vector w, and a threshold 'thres' used in the sigmoid function.
% Output: Perceptron output

Lx = length(x);
Lw = length(w);

if (Lx ~= Lw)
    error('lengte van x en w ongelijk');
end

sum = 0;

for n = 1:Lx
    sum = sum + x(n)*w(n);
    n=n+1;
end

out = sigmf(sum,[1,0]);

return;
end