function option = chooseRandom3(chance1, chance2, chance3)
%CHOOSERANDOM3 Summary of this function goes here
%   Detailed explanation goes here

random_number = rand(1);

if (random_number < chance1)
    option = 1;
elseif (chance1 < random_number) && ...
        (random_number < (chance1+chance2))
    option = 2;
else
    option = 3;
end

end

