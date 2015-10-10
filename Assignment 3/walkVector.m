function walkvect = walkVector(dir)
%WALKVECTOR Summary of this function goes here
%   Detailed explanation goes here

if (dir == 1) %north
    walkvect = [0 -1];
elseif (dir == 2) %east
    walkvect = [1 0];
elseif (dir == 3) %south
    walkvect = [0 1];
elseif (dir == 4) %west
    walkvect = [-1 0];
else
    error('incorrect direction');
end

end

