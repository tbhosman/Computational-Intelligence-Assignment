function Chances_matrix = calcChances(Pheromones_matrix)
%Convert pheromones matrix to chances

[size_y,size_x,size_z] = size(Pheromones_matrix);
Chances_matrix = zeros(size_y,size_x,size_z);

for x = 1:size_x
    for y = 1:size_y
        total = sum(Pheromones_matrix(y,x,:));
        if (total == 0)
            Chances_matrix(y,x,:) = [0 0 0 0];
        else
            Chances_matrix(y,x,:) = squeeze(Pheromones_matrix(y,x,:))./total;
        end
    end
end

end

