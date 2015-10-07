maze = dlmread('easy maze.txt');
%coordinates are in [x,y] position
startcoord = dlmread('easy coordinates.txt',',', [0 0 0 1]); 
endcoord = dlmread('easy coordinates.txt',',', [1 0 1 1]);

sizeX = maze(1,1); %get number of columns
sizeY = maze(1,2); %get number of rows
size = [sizeY sizeX]; %reverse sizeX and sizeY order for easy calculating of starting position
maze = maze(2:end, 1:end); %remove top line which only contains size data

%convert coordinates to matrix positions
startposcol = startcoord(1);
startposrow = sizeY - startcoord(2);
endposcol = endcoord(1);
endposrow = sizeY - endcoord(2);

%combine start and end positions in startpos and endpos variables
startpos = [startposrow startposcol];
endpos = [endposrow endposcol];

