function fitness = calcFitness(dist, population)
%CALCFITNESS Summary of this function goes here
%   Detailed explanation goes here

[wid, len] = size(population);
fitness = zeros(wid,1);

for r = 1:(len-1)
    for a = 1:wid
        fitness(a) = fitness(a) + dist(population(a,r),population(a,r+1));
    end
end

fitness = 1 ./fitness;

end

