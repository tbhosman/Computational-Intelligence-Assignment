clear all;
close all;

%% Tweakables
thres = 2;      % Threshold
alpha = 0.1;    % Learning rate
len_L1 = 8;     % Number of nodes in layer 1
len_L2 = 6;     % Number of nodes in layer 2
len_L3 = 3;     % Number of nodes in layer 3

%% Fetch input matrix and desired output
x_in = dlmread('features.txt');
y_out_desired = de2bi(dlmread('targets.txt'));

% Calculate amount of data (len_in) and amount of inputs (width_in)
[len_in,width_in] = size(x_in);

%% Initialize weights (rows are different nodes of a layer, columns are ...
% different weights of inputs of that node)
% randi(a,b,c) makes a matrix of b x c and fills it with numbers between...
% 1 and 1000. We normalize to have the numbers range from 0.001 to 1.
w_L1 = randi(1000, len_L1, width_in)./1000;
w_L2 = randi(1000, len_L2, len_L1)./1000;
w_L3 = randi(1000, len_L3, len_L2)./1000;

for (m=1:len_in)
%% Generate outputs first layer
    for (n=1:len_L1)
        %x_L1(n,m), where n selects the node of L1, and m selects which ...
        % data input is used (1-7854)
        y_L1(m,n) = perc(x_in(m,:), w_L1(n,:), thres);
        n = n+1;
    end

%% Generate outputs second layer
    for (n=1:len_L2)
        %x_L2(n,m), where n selects the node of L2, and m selects which ...
        % data input is used
        y_L2(m,n) = perc(y_L1(m,:), w_L2(n,:), thres);
        n = n+1;
    end

%% Generate outputs third layer
    for (n=1:len_L3)
        %x_L2(n,m), where n selects the node of L2, and m selects which ...
        % data input is used.
        % stap(x,y) returns 1 if x>y and 0 when x<y (to ensure binary
        % output.
        y_L3(m,n) = perc(y_L2(m,:), w_L3(n,:), thres);
        y_L3_bin(m,n) = stap(y_L3(m,n),0.5);
        n = n+1;
    end
    
%% Calculate new weights
%w_L3 = give_deltaw(y_out_desired(m,:),y_L3_bin(m,:),y_L3(m,:),y_L3(m,:),alpha);
        
end

