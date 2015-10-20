function dir = coord2dir4file(loc1, loc2)
%Converts the difference between two coordinates to a direction
%(loc1->loc2)

difference = loc2-loc1;

if (difference(1) == 0 && difference(2) == -1) %north
    dir = 1;
elseif (difference(1) == 1 && difference(2) == 0) %east
    dir = 0;
elseif (difference(1) == 0 && difference(2) == 1) %south
    dir = 3;
elseif (difference(1) == -1 && difference(2) == 0) %west
    dir = 2;
else
    error('locations not adjacent');
end

end

