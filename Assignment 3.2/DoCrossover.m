function [ child1, child2 ] = DoCrossover( parent1, parent2)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    
    %length = randi(6);
    length = 3;
    %start = randi(8 - length);
    start = 5;
    part1 = parent1(start:start+length);
    part2 = parent2(start:start+length);
    child1 = parent1;
    child2 = parent2;
    for i = start:start+length
        child1(i) = parent2(i);
        child2(i) = parent1(i);
    end
    for k = 1:length
        k
      index1 = find(part2(k) == parent1)  %vind waar het getal in parent1 staat dat in part2 staat
      index2 = find(part1(k) == parent2) %vind waar het getal in parent2 staat dat in part1 staat
      %if((index1 >= start) && index1 <= start+length) %hetzelfde getal zit in beide crossover gebieden
        
          %do nothing
      %else
          temp = child1(index1); %swap
          child1(index1) = child2(index2);
          child2(index2) = temp;
      %end
      
      
%         a = part1(k); %op plek b moet part2(k) komen
%         b = find(parent1 == a);
%         child1(b) = part2(k);
        
    end
end

