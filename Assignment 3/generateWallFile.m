function Directions = generateWallFile(maze)
%GENERATEWALLFILE Summary of this function goes here
%   Detailed explanation goes here

maze_size = size(maze);

Directions = zeros(maze_size(1), maze_size(2), 4);

for x = 1:maze_size(2)
    for y = 1:maze_size(1)
        possible_locs = [0 0 0 0];
        if ((1<x) && (x<maze_size(2)) && (1<y) && (y<maze_size(1))) %for all non-edge maze parts
            %check if space north of antspos is '1'
            if (maze(y-1,x) == 1)
                possible_locs(1) = 1;
            end
            %check if space east of antspos is '1'
            if (maze(y,x+1) == 1)
                possible_locs(2) = 1;
            end
            %check if space south of antspos is '1'
            if (maze(y+1,x) == 1)
                possible_locs(3) = 1;
            end
            %check if space west of antspos is '1'
            if (maze(y,x-1) == 1)
                possible_locs(4) = 1;
            end
        else
            
        end
        Directions(y,x,:) = possible_locs;
    end
end

end

