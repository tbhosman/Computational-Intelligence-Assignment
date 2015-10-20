function ant_hist_trimmed = trimBumps(ant_hist)
%Simplifies an ant route history

ant_hist_trimmed = [];
neighbours = zeros(4,2);

for s = 1:length(ant_hist)
    if (isempty(ant_hist))
        break;
    end
    
    neighbours(1,:) = ant_hist(1,:) + [1 0];
    neighbours(2,:) = ant_hist(1,:) + [-1 0];
    neighbours(3,:) = ant_hist(1,:) + [0 1];
    neighbours(4,:) = ant_hist(1,:) + [0 -1];
    
    [mem, loc] = ismember(neighbours,ant_hist(3:end,:),'rows');
    if (mem == 0) %no duplicate found
        ant_hist_trimmed = vertcat(ant_hist_trimmed,ant_hist(1,:));
        ant_hist = ant_hist(2:end,:);
    else
        ant_hist_trimmed = vertcat(ant_hist_trimmed,ant_hist(1,:));
        ant_hist = ant_hist((loc(vec2ind(loc))+2):end,:); %emulate a jump to loc
        continue;
    end
end

end