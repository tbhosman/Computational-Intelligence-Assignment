clear all;
close all;

%% Tweakables
ants = 20; %number of simulated ants

%% Load files
maze = dlmread('easy maze.txt');
%coordinates are in [x,y] position
start_coord = dlmread('easy coordinates.txt',',', [0 0 0 1]); 
end_coord = dlmread('easy coordinates.txt',',', [1 0 1 1]);

sizeX = maze(1,1); %get number of columns
sizeY = maze(1,2); %get number of rows
size = [sizeY sizeX]; %reverse sizeX and sizeY order for easy calculating of starting position
maze = maze(2:end, 1:end); %remove top line which only contains size data

%convert coordinates to matrix positions
start_pos_col = start_coord(1);
start_pos_row = sizeY - start_coord(2);
end_pos_col = end_coord(1);
end_pos_row = sizeY - end_coord(2);

%combine start and end positions in startpos and endpos variables
start_pos = [start_pos_row start_pos_col];
end_pos = [end_pos_row end_pos_col];

%% Initialize coordinates of ants
ants_pos = repmat(start_pos,ants,1);

%% Calculate new location for ants
% for a = 1:ants %loop over all ants
%     possible_locs = [0 0 0 0];
%     %check if position is at border or not
%     if ((0>ants_pos(a,1)>size(1)) && (0>ants_pos(a,2)>size(2))) %not border
%         
%         %check if space north of antspos is '1'
%         if (maze(ants_pos(a,1),ants_pos(a,2)+1) == 1)
%             possible_locs(1) = 1;
%         end;
%         %check if space east of antspos is '1'
%         if (maze(ants_pos(a,1)+1,ants_pos(a,2)) == 1)
%             possible_locs(2) = 1;
%         end;
%         %check if space south of antspos is '1'
%         if (maze(ants_pos(a,1),ants_pos(a,2)-1) == 1)
%             possible_locs(3) = 1;
%         end;
%         %check if space west of antspos is '1'
%         if (maze(ants_pos(a,1)-1,ants_pos(a,2)) == 1)
%             possible_locs(4) = 1;
%         end;
%         
%     else
%         
%     end;
% end;
    