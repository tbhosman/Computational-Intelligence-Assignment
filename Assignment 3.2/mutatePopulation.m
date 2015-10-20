function population = mutatePopulation(population, mut_chance)
%MUTATEPOPULATION Summary of this function goes here
%   Detailed explanation goes here
[len, wid] = size(population);

for p = 1:len
   random_number = rand(1); 
   if random_number < mut_chance
      switches = randperm(wid,2);
      res = population(p,switches(1));
      population(p,switches(1)) = population(p,switches(2));
      population(p,switches(2)) = res;
   end
end
end

