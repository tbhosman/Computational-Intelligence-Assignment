%%%% Main loop for Ant Colony Optimalization (ACO)
clear all;
close all;

%% Tweakables
ants = 20; %number of simulated ants
iterations = 200; %number of iterations
max_steps = 50000; %maximum number of steps an ant can make before aborting
%max_steps for medium maze: ~3000, max_steps for hard: ~20000
pheromones = 800; %amount of pheromones dropped
evaporation = 0.1; %evaporation constant
conv = 20; %number of iterations to check convergence on
conv_crit = 0; %number of steps one history element in length_hist can differ from another
%conv_crit for easy: 0, conv_crit for medium: 0

%% Load files
maze = dlmread('hard maze.txt');
%coordinates are in [x,y] position
start_ant = dlmread('hard coordinates.txt',',', [0 0 0 1]); 
end_ant = dlmread('hard coordinates.txt',',', [1 0 1 1]);

sizeX = maze(1,1); %get number of columns
sizeY = maze(1,2); %get number of rows
maze_size = [sizeY sizeX]; %reverse sizeX and sizeY order for easy calculating of starting position
maze = maze(2:end, 1:end); %remove top line which only contains size data

%% Initialize matrix with possible directions
Pheromones_matrix = generateWallFile(maze);
Chances_matrix = calcChances(Pheromones_matrix);

%% Calculate new locations for ants
for i = 1:iterations
    i
    %Initialize positions and histories
    ants_pos = repmat(start_ant,ants,1);
    ants_hist = zeros(max_steps, ants, 2);
    ants_hist(1,:,:) = ants_pos;
    
    for s = 1:max_steps
        ants_pos = calcNextLoc(Chances_matrix, ants_pos, ants_hist(1:(s-1),:,:));
        ants_hist(s+1,:,:) = ants_pos;
        
        %if (s == max_steps)
        %    continue;
        %end
        
        %check if end location is reached
        if (ismember(end_ant, ants_pos, 'rows'))
            
            %retrieve data of ant that found a route
            [~,ant_reached] = ismember(end_ant, ants_pos, 'rows');
            ant_reached_hist = squeeze(ants_hist(1:(s+1),ant_reached,:));
            ant_reached_hist = trimHist(ant_reached_hist);
            ant_reached_hist = trimBumps(ant_reached_hist);
            
            %calculate new amounts of pheromones and corresponding chances
            Pheromones_matrix = calcPheromones(Pheromones_matrix, ...
                ant_reached_hist, pheromones, evaporation);
            Chances_matrix = calcChances(Pheromones_matrix);
    
            length_reached = length(ant_reached_hist) %output length to user
            
            %keep record of local best
            if i==1 %first iteration
                global_best = ant_reached_hist;
            elseif (length(global_best)>length_reached)
                global_best = ant_reached_hist;
            end
            
            %keep record of length history for convergence criterion
            length_hist(mod(i,conv)+1) = length_reached;
            if (max(length_hist)-min(length_hist) <= conv_crit)
               return; 
            end
            
            break; %go to next iteration
        end   
    end
end
    