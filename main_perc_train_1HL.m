%% Main script used for the training of the neural network, designed ...
%% for 1 hidden layer.

clear all;
close all;

%% Tweakables
epoch = 2;         % Number of epochs
thres = 1;          % Threshold
alpha = 0.05;       % Learning rate
beta = 0.9;         % Momentum constant
alpha_inc = 1.1;    % alpha increase rate
alpha_dec = 0.5;    % alpha decrease rate
alpha_max = 0.95;   % max alpha value
len_L2 = 6;         % Number of nodes in layer 2
len_L3 = 7;         % Number of nodes in layer 3
K = 8;              % Cross validation constant (DO NOT CHANGE)
err_change = 0.001; % Difference between error_rate of current and ... 
                    % previous epoch at which script is discontinued

%% Initializing some constants
mse = zeros(1,epoch);         %initialize vector with history of mse
error_rate = zeros(1,epoch);  %initialize vector with history of error_rate
mse_sum = 0;
dw_L3 = 0;
dw_L2 = 0;
alpha_hist = zeros(1,epoch);  %initialize vector with history of alpha
test_factor = (K-2)/K;        %factor of data that is used for training set


%% Fetch input matrix and desired output
x_in = dlmread('features.txt'); %load input data 
[len_in,width_in] = size(x_in);
len_in = round(len_in*test_factor); %find training set length
x_in = x_in(1:len_in,:); %take training set
y_out_desired_cat = dlmread('targets.txt'); %load desired output
y_out_desired_cat = y_out_desired_cat(1:len_in,:); %take training set
y_out_desired = full(ind2vec(y_out_desired_cat',7))';

%% Initialize weights (rows are different nodes of a layer, columns are ...
% different weights of inputs of that node)
% randi(a,b,c) makes a matrix of b x c and fills it with numbers between...
% 1 and 100000. We normalize to have the numbers range from 0.00001 to 1.
w_L2 = randi(100000, len_L2, width_in)./100000;
w_L3 = randi(100000, len_L3, len_L2)./100000;

%% Initialize outputs
%y_L1 = zeros(len_in,len_L1);
y_L2 = zeros(len_in,len_L2);
y_L3 = zeros(len_in,len_L3);
y_L3_bin = zeros(len_in,len_L3);

%% Loop over epochs
for (x=1:epoch)
%% Loop over data samples
for (m=1:len_in)

    %% Generate outputs first layer
    for (n=1:len_L2)
        %x_L2(n,m), where n selects the node of L2, and m selects which ...
        % data input is used
        y_L2(m,n) = perc(x_in(m,:), w_L2(n,:), thres);
        n = n+1;
    end

%% Generate outputs second layer
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
%remember previous deltas to multiply with beta
dw_L3_prev = dw_L3;
dw_L2_prev = dw_L2;
%calculate deltas and gradients
[dw_L3,gradient_L3,error_L3] = give_deltaw(y_out_desired(m,:),y_L3(m,:),y_L3(m,:),y_L2(m,:),alpha);
[dw_L2,gradient_L2] = give_deltaw_hidden(y_L2(m,:),gradient_L3,w_L3,x_in(m,:),alpha);
%include beta
dw_L3 = beta * dw_L3_prev + dw_L3;
dw_L2 = beta * dw_L2_prev + dw_L2;
%calculate new weights
w_L3 = w_L3 + dw_L3;
w_L2 = w_L2 + dw_L2;

%% Calculate MSE
mse_sum = (mse_sum + sum(error_L3.^2));
end
mse(x) = mse_sum/len_in;
mse_sum = 0;

%% Calculate error rate
y_L3_cat = vec2ind(y_L3_bin')';
error_rate(x) = sum(y_L3_cat ~= y_out_desired_cat)/len_in*100;

%% When error hardly changes
if (x>1)
    if (abs(error_rate(x-1)-error_rate(x))<err_change)
        break;
    end
end        

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
