function [ child1, child2 ] = DoCrossover( parent1, parent2)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    
    length = 3;
    start = 4;
    %start = randi(size(parent1,2) - length);
    part1 = parent1(start:start+length-1);
    part2 = parent2(start:start+length-1);
    child1 = parent1;
    child2 = parent2;
    for i = start:start+length-1 %for loops in matlab doen t/m (vandaar de -1)
        child1(i) = parent2(i);
        child2(i) = parent1(i);
    end
    
    if start ~=1
        child1_front = child1(1:(start-1));
        child2_front = child2(1:(start-1));
    else
        child1_front = [];
        child2_front = [];
    end
    
    if (start+length == size(parent1,2)-1)
        child1_rear = [];
        child2_rear = [];
    else
        child1_rear = child1((start+length):end);
        child2_rear = child2((start+length):end);
    end

    for i = 1:size(part1,2)
        for k = 1:size(part1,2)
            inchild1_front = find(child1_front == part2(k), 1);
            if (~isempty(inchild1_front))
                child1_front(inchild1_front) = part1(k);
            end

            inchild2_front = find(child2_front == part1(k), 1);
            if (~isempty(inchild2_front))
                child2_front(inchild2_front) = part2(k);
            end

            inchild1_rear = find(child1_rear == part2(k), 1);
            if (~isempty(inchild1_rear))
                child1_rear(inchild1_rear) = part1(k);
            end

            inchild2_rear = find(child2_rear == part1(k), 1);
            if (~isempty(inchild2_rear))
                child2_rear(inchild2_rear) = part2(k);
            end
        end
    end
    
    child1 = [child1_front part2 child1_rear];
    child2 = [child2_front part1 child2_rear];
    
%     ahist = zeros(1,length);
%     for k = 1:length
%        
%       if(ismember(part1(k),part2) || ismember(part2(k),part1) && ismember(k,ahist)) %Dont want to destroy the childeren.
%           
%       elseif(ismember(part1(k),part2) || ismember(part2(k),part1)) %hetzelfde getal zit in beide crossover gebieden
%           
%           a = find(part2(k) == part1);
%           b = k;
%           index1 = find(part2(a) == parent1);
%           index2 = find(part1(b) == parent2);
%           temp = child1(index1);
%           child1(index1) = child2(index2);
%           child2(index2) = temp;
%           ahist(k) = a;
%           
%       else
%           index1 = find(part2(k) == parent1);  %vind waar het getal in parent1 staat dat in part2 staat
%           index2 = find(part1(k) == parent2); %vind waar het getal in parent2 staat dat in part1 staat
%           temp = child1(index1); %swap
%           child1(index1) = child2(index2);
%           child2(index2) = temp;
%       end
      
      
%         a = part1(k); %op plek b moet part2(k) komen
%         b = find(parent1 == a);
%         child1(b) = part2(k);
        
%    end
end

