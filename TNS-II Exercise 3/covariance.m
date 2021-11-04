function W = covariance(R_i, R_j)

% R_i = responses of i-th neurons in N, to some trials of stimuli, size [trial i]
% R_j = responses of j-th neurons in M, to same trials of stimuli, size [trial j]
% W =  matrix of response covariances for all neuron pairs j, i

[trial, i] = size(R_i);
[trial, j] = size(R_j);

% product of responses for all pairs j, i, summed up and devided by trail
% size [j i]
expR_jR_i = R_j'*R_i/trial;

% compute expected individual response by averaging over stimuli
% size [1 i]
% size [1 j]
expR_i = mean(R_i, 1);
expR_j = mean(R_j, 1);

% compute covariance matrix
W = expR_jR_i - expR_j'*expR_i;

% display covariance matrix
figure;
pcolor(W); 
axis('square');
colorbar
ylabel('j^{th} neuron of M');
xlabel('i^{th} neuron of N');
