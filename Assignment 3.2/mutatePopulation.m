function new_population = mutatePopulation(population, mut_chance)
%MUTATEPOPULATION Summary of this function goes here
%   Detailed explanation goes here
[len, wid] = size(population);
start = population(1,1);
ending = population(1,wid);
population = population(:,2:(end-1));

for p = 1:(len-2)
   random_number = rand(1); 
   if random_number < mut_chance
      switches = randperm(wid-2,2);
      res = population(p,switches(1));
      population(p,switches(1)) = population(p,switches(2));
      population(p,switches(2)) = res;
   end
end

new_population = [repmat(start,len,1) population repmat(ending,len,1)];

end

