%Convert an ant history to correct file format

%Initialization
hist = ant_reached_hist;
start = start_ant;
sc = ';';

len = length(hist);
dir = zeros(1,len);

for s = 1:(len-1)
    loc_cur = hist(s,:);
    loc_next = hist(s+1,:);
    dir(s) = coord2dir4file(loc_cur,loc_next);
end

dlmwrite('route.txt',len,'delimiter',';');
dlmwrite('route.txt',sc, '-append');
dlmwrite('route.txt',start, '-append');
dlmwrite('route.txt',sc, '-append');
dlmwrite('route.txt',dir,'delimiter',';','-append');