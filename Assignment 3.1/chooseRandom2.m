function option = chooseRandom2(chance1, options)
%Randomly chooses between two options based on their weights

random_number = rand(1);

if (random_number < chance1)
    option = options(1);
else
    option = options(2);            
end

end

