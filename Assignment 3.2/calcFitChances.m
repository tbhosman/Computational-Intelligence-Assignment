function chances = calcFitChances(fitness)
%CALCFITCHANCES Summary of this function goes here
%   Detailed explanation goes here

total = sum(fitness);
chances = zeros(length(total),1);

for i = 1:length(fitness)
    chances(i) = fitness(i)/total;
end

end

