clear all;
close all;

tsp_products = [0 19; 11 13; 75 72; 79 0; 11 30; 34 78; 8 39; 15 59; 62 21; 42 36; 63 65; 37 50; 4 66; 31 25; 47 47; 60 0; 78 60; 0 50];
maze_dim = 80;
%M = zeros(length(tsp_products),length(tsp_products));

for a=1:(length(tsp_products)-1)
    for b=(a+1):(length(tsp_products))
        a
        b
        
        if (distance(tsp_products(a,:),tsp_products(b,:))<maze_dim)
            global_best = ACO_function(tsp_products(a,:),tsp_products(b,:));
            dist(a,b) = length(global_best);
            dist(b,a) = length(global_best);
            routes(a,b) = {global_best};
            routes(b,a) = {global_best};
        else
            routes(a,b) = {[]};
            dist(a,b) = 99999;
        end
        
    end
end
