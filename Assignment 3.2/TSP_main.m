%% NB: MANUALLY READ DISTANCES BEFOREHAND

%% tweakables
chromosomes = 10; %number of chromosomes
locs = 18; %number of locations to visit
iterations = 100000;
mut_chance = 0.01; %chance to mutate chromosome
crossover_chance = 0.3; %chance to crossover

%% initialize population
start_ant = dlmread('hard coordinates.txt',',', [0 0 0 1]); 
end_ant = dlmread('hard coordinates.txt',',', [1 0 1 1]);
population = zeros(chromosomes,locs+2);
for a=1:chromosomes
    population(a,1) = locs+1; %location locs+1 is the start position
    population(a,2:locs+1) = randperm(locs);
    population(a,end) = locs+2; %location locs+2 is the end position
end
    fitness = calcFitness(dist,population);
    chances = calcFitChances(fitness);
    [~, max_index] = max(fitness);
    global_best = population(max_index,:);

%% main loop
for i=1:iterations
    new_population = newPopulation(chances,population);
    new_population = DoCrossoverBulk(new_population,crossover_chance);
    new_population = mutatePopulation(new_population, mut_chance);
    population = new_population;
    fitness = calcFitness(dist,population);
    chances = calcFitChances(fitness);
    
    [~, max_index] = max(fitness);
    global_best = population(max_index,:);
    global_best_dist = 1/fitness(max_index);
end

%% convert to file
route2fileTSP;