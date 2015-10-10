function ants_pos = calcNextLoc(Directions_matrix, ants_pos, ants_hist)
%CALCNEXTLOC Summary of this function goes here
%   Detailed explanation goes here

for a = 1:length(ants_pos) 
    if (size(ants_hist,1)==1) %only one history location
        ant_hist = squeeze(ants_hist(:,a,:))';
    else
        ant_hist = squeeze(ants_hist(:,a,:));
    end
    random_number = rand(1);
    %number of directions:
    directions = sum(Directions_matrix(ants_pos(a,2)+1,ants_pos(a,1)+1,:) ~= 0);
    %vector with possible directions
    dir = find(Directions_matrix(ants_pos(a,2)+1,ants_pos(a,1)+1,:));
    %chances to pick a direction:
    chance = [Directions_matrix(ants_pos(a,2)+1,ants_pos(a,1)+1,1) ...
        Directions_matrix(ants_pos(a,2)+1,ants_pos(a,1)+1,2) ...
        Directions_matrix(ants_pos(a,2)+1,ants_pos(a,1)+1,3) ...
        Directions_matrix(ants_pos(a,2)+1,ants_pos(a,1)+1,4)];

% 1 possible direction
    if (directions == 1)
        ants_pos(a,:) = ants_pos(a,:) + walkVector(dir);

% 2 possible directions
    elseif (directions == 2)
        
        option(1,:) = ants_pos(a,:) + walkVector(dir(1));
        option(2,:) = ants_pos(a,:) + walkVector(dir(2));
        if (isempty(ant_hist))
            a_in_hist = 0;
            b_in_hist = 0;
        else
            %true if option(1) is part of the history:
            a_in_hist = ismember(option(1,:), ant_hist, 'rows');
            %true if option(2) is part of the history:
            b_in_hist = ismember(option(2,:), ant_hist, 'rows');
        end
            
        if (a_in_hist) %a is old
            
            if (b_in_hist) %b is old
                
                %if both old, choose random
                ants_pos(a,:) = option(chooseRandom2...
                    (chance(dir(1)),chance(dir(2))),:);
                
            else %if a old but b new, choose b
                ants_pos(a,:) = option(2,:);
            end
            
        elseif (b_in_hist) %if a new, but b old, choose a
            ants_pos(a,:) = option(1,:);
        
        else %if both new, choose random
            ants_pos(a,:) = option(chooseRandom2...
                (chance(dir(1)),chance(dir(2))),:);
        end
      
%3 possible directions
    elseif (directions == 3)
        
        option(1,:) = ants_pos(a,:) + walkVector(dir(1));
        option(2,:) = ants_pos(a,:) + walkVector(dir(2));
        option(3,:) = ants_pos(a,:) + walkVector(dir(3));
        a_in_hist = ismember(option(1,:), ant_hist, 'rows'); %true if option_a is part of the history
        b_in_hist = ismember(option(2,:), ant_hist, 'rows'); %true if option_b is part of the history
        c_in_hist = ismember(option(3,:), ant_hist, 'rows'); %true if option_c is part of the history
        
        if ((a_in_hist && b_in_hist && c_in_hist) || ...
                (~a_in_hist && ~b_in_hist && ~c_in_hist))
            
            % all directions new or all directions old, choose random
            ants_pos(a,:) = option(chooseRandom3...
                    (chance(dir(1)),chance(dir(2)),chance(dir(3))),:);
            
        %a and b are old, choose c
        elseif (a_in_hist && b_in_hist)
            ants_pos(a,:) = option(3,:);
        
        %a and c are old, choose b
        elseif (a_in_hist && c_in_hist) 
            ants_pos(a,:) = option(2,:);
        
        %b and c are old, choose a
        elseif (b_in_hist && c_in_hist)
            ants_pos(a,:) = option(1,:);
         
        %a is old, choose b or c
        elseif (a_in_hist)
                ants_pos(a,:) = option(chooseRandom2...
                    (chance(dir(2))/(chance(dir(2))+chance(dir(3))), ...
                    chance(dir(3))/(chance(dir(2))+chance(dir(3)))),:);
                %chances are normalized to ensure total chance of 1
                
        %b is old, choose a or c
        elseif (b_in_hist)
                ants_pos(a,:) = option(chooseRandom2...
                    (chance(dir(1))/(chance(dir(1))+chance(dir(3))), ...
                    chance(dir(3))/(chance(dir(1))+chance(dir(3)))),:);
                %chances are normalized to ensure total chance of 1
                
        %c is old, choose a or b
        elseif (c_in_hist)
                ants_pos(a,:) = option(chooseRandom2...
                    (chance(dir(1))/(chance(dir(1))+chance(dir(2))), ...
                    chance(dir(2))/(chance(dir(1))+chance(dir(2)))),:);
                %chances are normalized to ensure total chance of 1
        end
               
%4 possible directions
    elseif (directions == 4)
        
        option(1,:) = ants_pos(a,:) + walkVector(dir(1));
        option(2,:) = ants_pos(a,:) + walkVector(dir(2));
        option(3,:) = ants_pos(a,:) + walkVector(dir(3));
        option(4,:) = ants_pos(a,:) + walkVector(dir(4));
        a_in_hist = ismember(option(1,:), ant_hist, 'rows'); %true if option_a is part of the history
        b_in_hist = ismember(option(2,:), ant_hist, 'rows'); %true if option_b is part of the history
        c_in_hist = ismember(option(3,:), ant_hist, 'rows'); %true if option_c is part of the history
        d_in_hist = ismember(option(4,:), ant_hist, 'rows'); %true if option_d is part of the history
        
        % all directions new or all directions old, choose random
        if ((a_in_hist && b_in_hist && c_in_hist && d_in_hist) || ...
                (~a_in_hist && ~b_in_hist && ~c_in_hist && ~d_in_hist))
            
            ants_pos(a,:) = option(chooseRandom4(chance(dir(1)),...
                chance(dir(2)),chance(dir(3)),chance(dir(4))),:);
            
        % a, b and c old, choose d
        elseif (a_in_hist && b_in_hist && c_in_hist)
            ants_pos(a,:) = option(4,:);
            
        % b, c and d old, choose a
        elseif (b_in_hist && c_in_hist && d_in_hist)
            ants_pos(a,:) = option(1,:);
        
        % a, c and d old, choose b
        elseif (a_in_hist && c_in_hist && d_in_hist)
            ants_pos(a,:) = option(2,:);
           
        % a, b and d old, choose c
        elseif (a_in_hist && b_in_hist && d_in_hist)
            ants_pos(a,:) = option(3,:);
        
        % a and b old, choose c and d random
        elseif (a_in_hist && b_in_hist)
            ants_pos(a,:) = option(chooseRandom2...
                (chance(dir(3))/(chance(dir(3))+chance(dir(4))), ...
                chance(dir(4))/(chance(dir(3))+chance(dir(4)))),:);
                %chances are normalized to ensure total chance of 1
        
        % a and c old, choose b and d random
        elseif (a_in_hist && c_in_hist)
            ants_pos(a,:) = option(chooseRandom2...
                (chance(dir(2))/(chance(dir(2))+chance(dir(4))), ...
                chance(dir(4))/(chance(dir(2))+chance(dir(4)))),:);
                %chances are normalized to ensure total chance of 1
                
        % a and d old, choose b and c random
        elseif (a_in_hist && d_in_hist)
            ants_pos(a,:) = option(chooseRandom2...
                (chance(dir(2))/(chance(dir(2))+chance(dir(3))), ...
                chance(dir(3))/(chance(dir(2))+chance(dir(3)))),:);
                %chances are normalized to ensure total chance of 1
                
        % b and c old, choose a and d random
        elseif (b_in_hist && c_in_hist)
            ants_pos(a,:) = option(chooseRandom2...
                (chance(dir(1))/(chance(dir(1))+chance(dir(4))), ...
                chance(dir(4))/(chance(dir(1))+chance(dir(4)))),:);
                %chances are normalized to ensure total chance of 1
                
        % b and d old, choose a and c random
        elseif (b_in_hist && d_in_hist)
            ants_pos(a,:) = option(chooseRandom2...
                (chance(dir(1))/(chance(dir(1))+chance(dir(3))), ...
                chance(dir(3))/(chance(dir(1))+chance(dir(3)))),:);
                %chances are normalized to ensure total chance of 1
                
        % c and d old, choose a and b random
        elseif (c_in_hist && d_in_hist)
            ants_pos(a,:) = option(chooseRandom2...
                (chance(dir(1))/(chance(dir(1))+chance(dir(2))), ...
                chance(dir(2))/(chance(dir(1))+chance(dir(2)))),:);
                %chances are normalized to ensure total chance of 1
        
        % a old, choose b, c and d random
        elseif (a_in_hist)
            ants_pos(a,:) = option(chooseRandom3...
                (chance(dir(2))/(chance(dir(2))+chance(dir(3))+chance(dir(4))), ...
                chance(dir(3))/(chance(dir(2))+chance(dir(3))+chance(dir(4))),...
                chance(dir(4))/(chance(dir(2))+chance(dir(3))+chance(dir(4)))),:);
                %chances are normalized to ensure total chance of 1
            
        % b old, choose a, c and d random
        elseif (b_in_hist)
            ants_pos(a,:) = option(chooseRandom3...
                (chance(dir(1))/(chance(dir(1))+chance(dir(3))+chance(dir(4))), ...
                chance(dir(3))/(chance(dir(1))+chance(dir(3))+chance(dir(4))),...
                chance(dir(4))/(chance(dir(1))+chance(dir(3))+chance(dir(4)))),:);
                %chances are normalized to ensure total chance of 1
                    
        % c old, choose a, b and d random
        elseif (c_in_hist)
            ants_pos(a,:) = option(chooseRandom3...
                (chance(dir(1))/(chance(dir(1))+chance(dir(2))+chance(dir(4))), ...
                chance(dir(2))/(chance(dir(1))+chance(dir(2))+chance(dir(4))),...
                chance(dir(4))/(chance(dir(1))+chance(dir(2))+chance(dir(4)))),:);
                %chances are normalized to ensure total chance of 1
                    
        % d old, choose a, b and c random
        elseif (d_in_hist)
            ants_pos(a,:) = option(chooseRandom3...
                (chance(dir(1))/(chance(dir(1))+chance(dir(2))+chance(dir(3))), ...
                chance(dir(2))/(chance(dir(1))+chance(dir(2))+chance(dir(3))),...
                chance(dir(3))/(chance(dir(1))+chance(dir(2))+chance(dir(3)))),:);
                %chances are normalized to ensure total chance of 1
        end
end
end

