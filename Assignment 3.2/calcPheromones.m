function Pheromones_matrix = calcPheromones(Directions_matrix, ...
        ant_reached_hist, pheromones, evaporation)
%Calculates the amount of pheromones for the next iteration

[size_y,size_x,size_z] = size(Directions_matrix);
Pheromones_matrix = zeros(size_y, size_x, size_z);
delta_pheromones = pheromones/size(ant_reached_hist,1);

for x = 1:size_x
    for y = 1:size_y
        Pheromones_matrix(y,x,:) = squeeze(Directions_matrix(y,x,:)) ...
            *(1-evaporation); %add evaporation to output matrix
    end
end

for h = 1:(size(ant_reached_hist,1)-1)
            
    loc_cur = ant_reached_hist(h,:);
    loc_next = ant_reached_hist(h+1,:);
    dir = coord2dir(loc_cur, loc_next);
            
    Pheromones_matrix(loc_cur(2)+1,loc_cur(1)+1,dir) = ...
        Pheromones_matrix(loc_cur(2)+1,loc_cur(1)+1,dir) + delta_pheromones;    
end
end

