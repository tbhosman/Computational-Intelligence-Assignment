clearvars -except w_L1 w_L2 w_L3 thres len_L0 len_L1 len_L2 len_L3;
close all;

%% Fetch input matrix and desired output
x_in = dlmread('features.txt');
% validation set: 5891-6872
% test set: 6873-7854
x_in = x_in(5891:6872,:);
[len_in,width_in] = size(x_in);
y_out_desired_cat = dlmread('targets.txt');
y_out_desired_cat = y_out_desired_cat(5891:6872,:);
y_out_desired = full(ind2vec(y_out_desired_cat',7))';

%% Initialize outputs
y_L1 = zeros(len_in,len_L1);
y_L2 = zeros(len_in,len_L2);
y_L3 = zeros(len_in,len_L3);
y_L3_bin = zeros(len_in,len_L3);

for (m = 1:len_in)
    %% Generate outputs zero-th layer
    for (n=1:len_L0)
        %x_L1(n,m), where n selects the node of L1, and m selects which ...
        % data input is used (1-7854)
        y_L0(m,n) = perc(x_in(m,:), w_L0(n,:), thres);
        n = n+1;
    end
    
    %% Generate outputs first layer
    for (n=1:len_L1)
        %x_L1(n,m), where n selects the node of L1, and m selects which ...
        % data input is used (1-7854)
        y_L1(m,n) = perc(y_L0(m,:), w_L1(n,:), thres);
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
end

%% Calculate error rate
y_L3_cat = vec2ind(y_L3_bin')';
error_rate = sum(y_L3_cat ~= y_out_desired_cat)/len_in*100;     