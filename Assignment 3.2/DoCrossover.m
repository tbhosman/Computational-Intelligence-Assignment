function [ child1, child2 ] = DoCrossover( parent1, parent2)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    
    length = randi(6);
    start = randi(18 - length);
    part1 = parent1(start:start+length);
    part2 = parent2(start:start+length);
    child1 = parent1;
    child2 = parent2;
    for i = start:start+length
        child1(i) = parent2(i);
        child2(i) = parent1(i);
    end
    for k = 1:length
        a = part1(k);
        b = find(parent1 == a);
    end
end

