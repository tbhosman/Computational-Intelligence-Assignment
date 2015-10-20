function new_population = newPopulation(chances,population)
%NEWPOPULATION Summary of this function goes here
%   Detailed explanation goes here

[wid, ~] = size(population);
new_population = zeros(size(population));

    for p = 1:wid
        random_number = rand(1);
        
        for a = 1:wid
            
            if (a==1)
                chance_bottom = 0;
            else
                chance_bottom = sum(chances(1:(a-1)));
            end
            
            if ((random_number > chance_bottom) && (random_number < (chance_bottom + chances(a))))
                new_population(p,:) = population(a,:);
            end
            
        end
    end
end

