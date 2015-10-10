function option = chooseRandom4(chance1, chance2, chance3, chance4)
%Randomly chooses between four options based on their weights


random_number = rand(1);

if (random_number < chance1)
    option = 1;
elseif (chance1 < random_number) && ...
        (random_number < (chance1+chance2))
    option = 2;
elseif ((chance1+chance2) < random_number) && ...
        (random_number < (chance1+chance2+chance3))
    option = 3;
else
    option = 4;
end

end

