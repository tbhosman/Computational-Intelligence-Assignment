clear all;
close all;

%% Tweakables
epoch = 100;         % Number of epochs
thres = 2;          % Threshold
alpha = 0.05;       % Learning rate
beta = 0.9;         % Momentum constant
alpha_inc = 1.1;    % alpha increase rate
alpha_dec = 0.5;    % alpha decrease rate
alpha_max = 0.95;   % max alpha value
len_L1 = 8;         % Number of nodes in layer 1
len_L2 = 6;         % Number of nodes in layer 2
len_L3 = 7;         % Number of nodes in layer 3
K = 8;              % cross validation constant (DO NOT CHANGE)

%% Initializing some constants
mse = zeros(1,epoch);
error_rate = zeros(1,epoch);
mse_sum = 0;
dw_L3 = 0;
dw_L2 = 0;
dw_L1 = 0;
alpha_hist = zeros(1,epoch);
test_factor = (K-2)/K;

%% Fetch input matrix and desired output
x_in = dlmread('features.txt');
[len_in,width_in] = size(x_in);
len_in = round(len_in*test_factor);
x_in = x_in(1:len_in,:); %take training set of data
y_out_desired_cat = dlmread('targets.txt');
y_out_desired_cat = y_out_desired_cat(1:len_in,:); %take training set of data
y_out_desired = full(ind2vec(y_out_desired_cat',7))';

%% Initialize weights (rows are different nodes of a layer, columns are ...
% different weights of inputs of that node)
% randi(a,b,c) makes a matrix of b x c and fills it with numbers between...
% 1 and 1000. We normalize to have the numbers range from 0.001 to 1.
w_L1 = randi(100000, len_L1, width_in)./100000;
w_L2 = randi(100000, len_L2, len_L1)./100000;
w_L3 = randi(100000, len_L3, len_L2)./100000;

%% Initialize outputs
y_L1 = zeros(len_in,len_L1);
y_L2 = zeros(len_in,len_L2);
y_L3 = zeros(len_in,len_L3);
y_L3_bin = zeros(len_in,len_L3);

for (x=1:epoch)
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
dw_L3_prev = dw_L3;
dw_L2_prev = dw_L2;
dw_L1_prev = dw_L1;
[dw_L3,gradient_L3,error_L3] = give_deltaw(y_out_desired(m,:),y_L3(m,:),y_L3(m,:),y_L2(m,:),alpha);
[dw_L2,gradient_L2] = give_deltaw_hidden(y_L2(m,:),gradient_L3,w_L3,y_L1(m,:),alpha);
[dw_L1,gradient_L1] = give_deltaw_hidden(y_L1(m,:),gradient_L2,w_L2,x_in(m,:),alpha);
dw_L3 = beta * dw_L3_prev + dw_L3;
dw_L2 = beta * dw_L2_prev + dw_L2;
dw_L1 = beta * dw_L1_prev + dw_L1;
w_L3 = w_L3 + dw_L3;
w_L2 = w_L2 + dw_L2;
w_L1 = w_L1 + dw_L1;

%% Calculate MSE
mse_sum = (mse_sum + sum(error_L3.^2));
end
mse(x) = mse_sum/len_in;
mse_sum = 0;

%% Calculate error rate
y_L3_cat = vec2ind(y_L3_bin')';
error_rate(x) = sum(y_L3_cat ~= y_out_desired_cat)/len_in*100;

%% Calculate adaptive learning rate
alpha_hist(x) = alpha;
if (x>1)                            %if not first epoch
    if (alpha>alpha_max)
        alpha = alpha_max;
    elseif ((mse(x-1)-mse(x))>0)    %error decreasing
        alpha = alpha_inc * alpha;
    else                            %error increasing
        alpha = alpha_dec * alpha;
    end
end
end
