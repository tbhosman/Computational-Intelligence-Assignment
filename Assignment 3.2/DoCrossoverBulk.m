function new_population = DoCrossoverBulk(population, crossover_chance)
%DOCROSSOVERBULK Summary of this function goes here
%   Detailed explanation goes here

[wid, ~] = size(population);
random_pop = randperm(wid);
new_population = zeros(size(population));

for i = 1:(wid/2)
    random_number = rand(1);
    if (random_number < crossover_chance)
        [child1, child2] = DoCrossover(population(random_pop(2*i-1),2:(end-1)),population(random_pop(2*i),2:(end-1)));
        new_population(2*i-1,:) = [population(i,1); child1'; population(i,end)]';
        new_population(2*i,:) = [population(i,1); child2'; population(i,end)]';
    else
        new_population(2*i-1,:) = population(2*i-1,:);
        new_population(2*i,:) = population(2*i,:);
    end
end


end