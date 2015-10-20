function option = chooseRandom3(chance1, chance2, options)
%Randomly chooses between three options based on their weights

random_number = rand(1);

if (random_number < chance1)
    option = options(1);
elseif (chance1 < random_number) && ...
        (random_number < (chance1+chance2))
    option = options(2);
else
    option = options(3);
end

end

