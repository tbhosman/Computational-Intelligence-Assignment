%Script to test if all history elements are a valid maze location
[r c] = find(maze==0);
locs = [c r];
count = 0;
for i = 1:1000
    for a = 1:20
        if ismember(squeeze(ants_hist(i,a,:))' + [1 1],locs,'rows')
            count = count + 1;
        end
    end
end