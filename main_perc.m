% Tweakables
thres = 1;
len_L1 = 8;
len_L2 = 6;

% Fetch input matrix and desired output
x_in = [0.57855,0.82114,1.2148,0.72998,0.34868,0.99462,-0.018461,0.92471,0.24418,0.063001;-0.022322,0.47681,0.55624,0.91543,0.26883,0.14517,0.44995,1.0584,0.68453,0.99877;0.057631,0.0017896,0.95442,1.05,0.11558,0.17376,-0.1538,0.20707,0.40055,0.2335];
%x_in = 
%y_out_desired = 

% Calculate amount of data (len_in) and amount of inputs (width_in)
[len_in,width_in] = size(x_in);

% Initialize weights (rows are different nodes of a layer, columns are ...
% different weights of inputs of that node)
w_L1 = randi(1000, len_L1, width_in)./1000;
w_L2 = randi(1000, len_L2, len_L1)./1000;

% Generate outputs first layer
for (m=1:len_in)
    for (n=1:len_L1)
        %x_L1(n,m), where n selects the node of L1, and m selects which ...
        % data input is used (1-7854)
        x_L1(m,n) = perc(x_in(m,:)', w_L1(n,:), thres);
        n = n+1;
    end
end

% Generate outputs second layer
for (m=1:len_in)
    for (n=1:len_L2)
        %x_L2(n,m), where n selects the node of L2, and m selects which ...
        % data input is used
        x_L2(m,n) = perc(x_L1(m,:)', w_L2(n,:), thres);
        n = n+1;
    end
end