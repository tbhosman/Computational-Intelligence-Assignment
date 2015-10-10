function option = chooseRandom2(chance1, chance2)
%CHOOSERANDOM2 Summary of this function goes here
%   Detailed explanation goes here

random_number = rand(1);

if (random_number < chance1)
    option = 1;
else
    option = 2;            
end

end

