%Convert an ant history to correct file format
%FILE FORMAT INCORRECT, please edit manually

%Initialization
sc = ';';

dlmwrite('route.txt',global_best_dist,'delimiter',';');
dlmwrite('route.txt',sc, '-append');
dlmwrite('route.txt',start_ant,'-append');
dlmwrite('route.txt',sc,'-append');

for r = 1:(length(global_best)-1)
    clear dir hist;
    hist = cell2mat(routes(global_best(r),global_best(r+1)));
    dir = zeros(1,length(hist)-1);
    
    if (isempty(hist))
        error('Found route was not calculated by graphGenerator.');
    end
    
    for s = 1:(length(hist)-1)
        loc_cur = hist(s,:);
        loc_next = hist(s+1,:);
        dir(s) = coord2dir4file(loc_cur,loc_next);
    end
    
    if (r~=length(global_best)-1)
        dlmwrite('route.txt',dir,'delimiter',';','-append');
        dlmwrite('route.txt',sc,'-append');
        dlmwrite('route.txt', 'take product #','-append');
        dlmwrite('route.txt', global_best(r+1),'-append');
        dlmwrite('route.txt',sc,'-append');
    else %for final route to finish
        dlmwrite('route.txt',dir,'delimiter',';','-append');
    end
end