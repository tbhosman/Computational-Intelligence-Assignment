clear all;
close all;

%% Tweakables
ants = 20; %number of simulated ants
iterations = 100; %number of iterations
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

%% Calculate new locations for ants
for i = 1:iterations
    ants_pos = calcNextLoc(Directions_matrix, ants_pos);
end
    