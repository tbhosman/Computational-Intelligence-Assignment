function Directions = generateWallFile(maze)
%Generates a matrix which contains possible directions of a location
%in the maze.
%   The output matrix 'Directions' has 3 dimensions. The first dimension 
%   is the y position in the maze, the second is the x position in the
%   maze, the third dimension has a size 4, where each element contains
%   the chance of going in that direction. The first position in this
%   dimension is north, the second is east, the third is south, the fourth
%   is west.

maze_size = size(maze);

Directions = zeros(maze_size(1), maze_size(2), 4);

for x = 1:maze_size(2)
    for y = 1:maze_size(1)
        if ((1<x) && (x<maze_size(2)) && (1<y) && (y<maze_size(1)))
%for all non-edge maze parts
            %check if space north of antspos is '1'
            if (maze(y-1,x) == 1)
                Directions(y,x,1) = 1;
            end
            %check if space east of antspos is '1'
            if (maze(y,x+1) == 1)
                Directions(y,x,2) = 1;
            end
            %check if space south of antspos is '1'
            if (maze(y+1,x) == 1)
                Directions(y,x,3) = 1;
            end
            %check if space west of antspos is '1'
            if (maze(y,x-1) == 1)
                Directions(y,x,4) = 1;
            end
%for top and bottom edges
        elseif ((1<x) && (x<maze_size(2)))
%for top edge
            if (y == 1)
                %check if space east of antspos is '1'
                if (maze(y,x+1) == 1)
                    Directions(y,x,2) = 1;
                end
                %check if space south of antspos is '1'
                if (maze(y+1,x) == 1)
                    Directions(y,x,3) = 1;
                end
                %check if space west of antspos is '1'
                if (maze(y,x-1) == 1)
                    Directions(y,x,4) = 1;
                end
%for bottom edge
            else
                %check if space north of antspos is '1'
                if (maze(y-1,x) == 1)
                    Directions(y,x,1) = 1;
                end
                %check if space east of antspos is '1'
                if (maze(y,x+1) == 1)
                    Directions(y,x,2) = 1;
                end
                %check if space west of antspos is '1'
                if (maze(y,x-1) == 1)
                    Directions(y,x,4) = 1;
                end
            end
%for left and right edges
        elseif ((1<y) && (y<maze_size(1)))
%for left edge
            if(x == 1)
                %check if space north of antspos is '1'
                if (maze(y-1,x) == 1)
                    Directions(y,x,1) = 1;
                end
                %check if space east of antspos is '1'
                if (maze(y,x+1) == 1)
                    Directions(y,x,2) = 1;
                end
                %check if space south of antspos is '1'
                if (maze(y+1,x) == 1)
                    Directions(y,x,3) = 1;
                end
%for right edge
            else
                %check if space north of antspos is '1'
                if (maze(y-1,x) == 1)
                    Directions(y,x,1) = 1;
                end
                %check if space south of antspos is '1'
                if (maze(y+1,x) == 1)
                    Directions(y,x,3) = 1;
                end
                %check if space west of antspos is '1'
                if (maze(y,x-1) == 1)
                    Directions(y,x,4) = 1;
                end
            end
%for corner maze(1,1)
        elseif (y==1 && x==1)
             %check if space east of antspos is '1'
             if (maze(y,x+1) == 1)
                 Directions(y,x,2) = 1;
             end
             %check if space south of antspos is '1'
             if (maze(y+1,x) == 1)
                 Directions(y,x,3) = 1;
             end  
%for corner maze(1,size_x)
        elseif (y==1 && x==maze_size(2))
             %check if space south of antspos is '1'
             if (maze(y+1,x) == 1)
                Directions(y,x,3) = 1;
             end
             %check if space west of antspos is '1'
             if (maze(y,x-1) == 1)
                 Directions(y,x,4) = 1;
             end
%for corner maze(size_y,1)
        elseif (y==maze_size(1) && x==1)
            %check if space north of antspos is '1'
            if (maze(y-1,x) == 1)
                Directions(y,x,1) = 1;
            end
            %check if space east of antspos is '1'
            if (maze(y,x+1) == 1)
                Directions(y,x,2) = 1;
            end
%for corner maze(size_y,size_x)
        elseif(y==maze_size(1) && x==maze_size(2))
             %check if space north of antspos is '1'
             if (maze(y-1,x) == 1)
                 Directions(y,x,1) = 1;
             end
             %check if space west of antspos is '1'
             if (maze(y,x-1) == 1)
                 Directions(y,x,4) = 1;
             end
        end
        
        %calculate chance to use this direction
        if (sum(Directions(y,x,:) ~= 0))
            Directions(y,x,:) = Directions(y,x,:)./sum(Directions(y,x,:));
        end
        
     end
end
end