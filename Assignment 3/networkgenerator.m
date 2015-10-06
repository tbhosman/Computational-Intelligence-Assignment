maze = dlmread('easy maze.txt');
test = dlmread('easy coordinates.txt','; ');
coordinates = textscan('easy coordinates.txt','%s');
sizeX = maze(1,1); %get number of columns
sizeY = maze(1,2); %get number of rows
maze = maze(2:end, 1:end); %remove top line which only contains size data
