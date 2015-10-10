function option = chooseRandom2(chance1, chance2)
%Randomly chooses between two options based on their weights

random_number = rand(1);

if (random_number < chance1)
    option = 1;
else
    option = 2;            
end

end

