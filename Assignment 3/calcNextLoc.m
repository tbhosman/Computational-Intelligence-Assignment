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
        
        option_a = ants_pos(a,:) + walkVector(dir(1));
        option_b = ants_pos(a,:) + walkVector(dir(2));
        if (isempty(ant_hist))
            a_in_hist = 0;
            b_in_hist = 0;
        else
            a_in_hist = ismember(option_a, ant_hist, 'rows'); %true if option_a is part of the history
            b_in_hist = ismember(option_b, ant_hist, 'rows'); %true if option_b is part of the history
        end
            
        if (a_in_hist) %a is old
            
            if (b_in_hist) %b is old
                
                %if both old, choose random
                if (random_number < chance(dir(1)))
                    ants_pos(a,:) = option_a;
                else
                    ants_pos(a,:) = option_b;            
                end
                
            else %if a old but b new, choose b
                ants_pos(a,:) = option_b;
            end
            
        elseif (b_in_hist) %if a new, but b old, choose a
            ants_pos(a,:) = option_a;
        
        else %if both new, choose random
            if (random_number < chance(dir(1)))
                ants_pos(a,:) = option_a;
            else
                ants_pos(a,:) = option_b;            
            end
        end
      
%3 possible directions
    elseif (directions == 3)
        
        option_a = ants_pos(a,:) + walkVector(dir(1));
        option_b = ants_pos(a,:) + walkVector(dir(2));
        option_c = ants_pos(a,:) + walkVector(dir(3));
        a_in_hist = ismember(option_a, ant_hist, 'rows'); %true if option_a is part of the history
        b_in_hist = ismember(option_b, ant_hist, 'rows'); %true if option_b is part of the history
        c_in_hist = ismember(option_c, ant_hist, 'rows'); %true if option_c is part of the history
        
        if ((a_in_hist && b_in_hist && c_in_hist) || ...
                (~a_in_hist && ~b_in_hist && ~c_in_hist))
            
            % all directions new or all directions old, choose random
            if (random_number < chance(dir(1)))
                ants_pos(a,:) = ants_pos(a,:) + walkVector(dir(1));
            elseif (chance(dir(1)) < random_number) && ...
                    (random_number < (chance(dir(1))+chance(dir(2))))
                ants_pos(a,:) = ants_pos(a,:) + walkVector(dir(2));
            else
                ants_pos(a,:) = ants_pos(a,:) + walkVector(dir(3));
            end
            
        %a and b are old, choose c
        elseif (a_in_hist && b_in_hist)
            ants_pos(a,:) = option_c;
        
        %a and c are old, choose b
        elseif (a_in_hist && c_in_hist) 
            ants_pos(a,:) = option_b;
        
        %b and c are old, choose a
        elseif (b_in_hist && c_in_hist)
            ants_pos(a,:) = option_a;
         
        %a is old, choose b or c
        elseif (a_in_hist)
                if (random_number < chance(dir(2)) ...
                        /(chance(dir(2))+chance(dir(3)))) %normalize
                    ants_pos(a,:) = option_b;
                else
                    ants_pos(a,:) = option_c;            
                end
                
        %b is old, choose a or c
        elseif (b_in_hist)
                if (random_number < chance(dir(1)) ...
                        /(chance(dir(1))+chance(dir(3)))) %normalize
                    ants_pos(a,:) = option_a;
                else
                    ants_pos(a,:) = option_c;            
                end
                
        %c is old, choose a or b
        elseif (c_in_hist)
                if (random_number < chance(dir(1)) ...
                        /(chance(dir(1))+chance(dir(2)))) %normalize
                    ants_pos(a,:) = option_a;
                else
                    ants_pos(a,:) = option_b;            
                end
        end
               
%4 possible directions
    elseif (directions == 4)
        
        option_a = ants_pos(a,:) + walkVector(dir(1));
        option_b = ants_pos(a,:) + walkVector(dir(2));
        option_c = ants_pos(a,:) + walkVector(dir(3));
        option_d = ants_pos(a,:) + walkVector(dir(4));
        a_in_hist = ismember(option_a, ant_hist, 'rows'); %true if option_a is part of the history
        b_in_hist = ismember(option_b, ant_hist, 'rows'); %true if option_b is part of the history
        c_in_hist = ismember(option_c, ant_hist, 'rows');
        d_in_hist = ismember(option_d, ant_hist, 'rows');
        
        % all directions new or all directions old, choose random
        if ((a_in_hist && b_in_hist && c_in_hist && d_in_hist) || ...
                (~a_in_hist && ~b_in_hist && ~c_in_hist && ~d_in_hist))
            
            if (random_number < chance(1))
                ants_pos(a,:) = option_a;
            elseif (chance(dir(1)) < random_number) && ...
                    (random_number < (chance(dir(2))+chance(dir(1))))
                ants_pos(a,:) = option_b;
            elseif (chance(dir(2))+chance(dir(1)) < random_number) && ...
                    (random_number < (chance(dir(3))+chance(dir(2))+chance(dir(1))))
                ants_pos(a,:) = option_c;
            else
                ants_pos(a,:) = option_d;
            end
            
        % a, b and c old, choose d
        elseif (a_in_hist && b_in_hist && c_in_hist)
            ants_pos(a,:) = option_d;
            
        % b, c and d old, choose a
        elseif (b_in_hist && c_in_hist && d_in_hist)
            ants_pos(a,:) = option_a;
        
        % a, c and d old, choose b
        elseif (a_in_hist && c_in_hist && d_in_hist)
            ants_pos(a,:) = option_b;
           
        % a, b and d old, choose c
        elseif (a_in_hist && b_in_hist && d_in_hist)
            ants_pos(a,:) = option_c;
        end
        
        % a and b old, choose c and d random
        
        % a and c old, choose b and d random
        
        % a and d old, choose b and c random
        
        % b and c old, choose a and d random
        
        % b and d old, choose a and c random
        
        % c and d old, choose a and b random
        
        % a old, choose b, c and d random
        
        % b old, choose a, c and d random
        
        % c old, choose a, b and d random
        
        % d old, choose a, b and c random
        
    end
end
end

