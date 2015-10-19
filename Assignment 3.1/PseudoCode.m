Read(initializations);
Load(files);
initialize(pheromones_matrix);
initialize(chances_matrix);

for i = 1:iterations
    
    initialize(ant_locations); %set all locations to start location
    initialize(ant_histories); %zeros matrix that can include all locations of the ants
    
    for s = 1:max_steps %calculate new locations for a max number of steps
        
       %calculate new locations (choose new location if possible)
       ant_locations = calcNextLoc(chances_matrix, ant_locations, ant_histories); 
       
       if ant_location == end_position %if end position is found by an ant
           
           ant_history = trimHist(ant_history); %remove loops in route
           
           %update pheromones and chances matrix
           pheromones_matrix = calcPheromones(pheromones_matrix, ant_history, constants);
           chances_matrix = calcChances(pheromones_matrix);
           
           %keep track of global best
           if i==1 %first iteration
               global_best = ant_reached_hist;
           elseif (length(global_best)>length_reached)
               global_best = ant_reached_hist;
           end
           
           %check convergence criterion
           if (average_route_length_change < convergence_criterion)
               return
           end
           
       end
    end
end