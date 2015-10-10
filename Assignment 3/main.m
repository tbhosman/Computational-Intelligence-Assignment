%%%% Main loop for Ant Colony Optimalization (ACO)
clear all;
close all;

%% Tweakables
ants = 20; %number of simulated ants
iterations = 1; %number of iterations
max_steps = 1000; %maximum number of steps an ant can make before aborting
pheromones = 1; %amount of pheromones dropped
eveporation = 0.1; %evaporation constant

%% Load files
maze = dlmread('easy maze.txt');
%coordinates are in [x,y] position
start_ant = dlmread('easy coordinates.txt',',', [0 0 0 1]); 
end_ant = dlmread('easy coordinates.txt',',', [1 0 1 1]);

sizeX = maze(1,1); %get number of columns
sizeY = maze(1,2); %get number of rows
size = [sizeY sizeX]; %reverse sizeX and sizeY order for easy calculating of starting position
maze = maze(2:end, 1:end); %remove top line which only contains size data

%% Initialize coordinates of ants
ants_pos = repmat(start_ant,ants,1);

%% Initialize matrix with possible directions
Directions_matrix = generateWallFile(maze);

%% Initialize ant history
ants_hist = zeros(iterations, ants, 2);
ants_hist(1,:,:) = ants_pos;

%% Calculate new locations for ants
for i = 1:iterations
    for s = 1:max_steps
        ants_pos = calcNextLoc(Directions_matrix, ants_pos, ants_hist(1:(i-1),:,:));
        ants_hist(s+1,:,:) = ants_pos;
        if (ismember(end_ant, ants_pos, 'rows'))
           %add pheromone and change chances of directions
           break; %go to next iteration
        end
    end
end
    