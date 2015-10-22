clear all;
close all;

start_ant = dlmread('hard coordinates.txt',',', [0 0 0 1]); 
end_ant = dlmread('hard coordinates.txt',',', [1 0 1 1]);
tsp_products = [start_ant; 0 19; 11 13; 75 72; 79 0; 11 30; 34 78; 8 39; 15 59; 62 21; 42 36; 63 65; 37 50; 4 66; 31 25; 47 47; 60 0; 78 60; 0 50; end_ant];
maze_dim = 80;
%M = zeros(length(tsp_products),length(tsp_products));

for a=1:(length(tsp_products)-1)
    for b=(a+1):(length(tsp_products))
        a
        b
        
        global_best = ACO_function(tsp_products(a,:),tsp_products(b,:));
        routes(a,b) = {global_best};
        routes(b,a) = {global_best};
        if isempty(global_best)
            dist(a,b) = 99999;
            dist(b,a) = 99999;
        else
            dist(a,b) = length(global_best);
            dist(b,a) = length(global_best);
        end
        
    end
end
