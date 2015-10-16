function ant_hist_trimmed = trimHist(ant_hist)
%Simplifies an ant route history

ant_hist_trimmed = [];

for s = 1:length(ant_hist)
    if (isempty(ant_hist))
        break;
    end
    [mem, loc] = ismember(ant_hist(1,:),ant_hist(2:end,:),'rows');
    if (mem == 0) %no duplicate found
        ant_hist_trimmed = vertcat(ant_hist_trimmed,ant_hist(1,:));
        ant_hist = ant_hist(2:end,:);
    else
        ant_hist = ant_hist((loc+1):end,:); %emulate a jump to loc
        continue;
    end
end

end

