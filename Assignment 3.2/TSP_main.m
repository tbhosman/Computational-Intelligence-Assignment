%% NB: MANUALLY READ DISTANCES BEFOREHAND

%% tweakables
chromosomes = 10; %number of chromosomes
locs = 18; %number of locations to visit
iterations = 1;
mut_chance = 0.01; %chance to mutate chromosome

%% initialize population
population = zeros(chromosomes,locs);
fitness = zeros(1,locs);
for a=1:chromosomes
    population(a,:) = randperm(locs);
end

%% main loop
for i=1:iterations
    fitness = calcFitness(dist,population);
    chances = calcFitChances(fitness);
    new_population = newPopulation(chances,population);
    new_population = mutatePopulation(new_population, mut_chance);
end