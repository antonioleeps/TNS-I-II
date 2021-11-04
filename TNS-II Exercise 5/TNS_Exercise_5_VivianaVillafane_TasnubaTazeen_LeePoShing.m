% Course on Teoretical Neuroscience
% Teacher: Jochen Braun
% Assistent Teachers: Ehsan Kakaei
% Exercise05: Rescorla-Wagner Rule
% Name: Viviana Villafane & Tasnuba Tazeen & Lee Po Shing
% Date: 24/05/2018

% Purpose: 

clear all
clc
close all
%%Part I: Input statistics
% Correlation calculation
input_trial = 100;
P_A = 1/3;
P_B = 1/5;
P = [P_B (1-P_B)]'*[P_A (1-P_A)];

u_11 = repmat([1;1], 1, uint16(input_trial*P(1,1)));
u_10 = repmat([1;0], 1, uint16(input_trial*P(2,1)));
u_01 = repmat([0;1], 1, uint16(input_trial*P(1,2)));
u_00 = repmat([0;0], 1, uint16(input_trial*P(2,2)));

temp_u = [u_11 u_10 u_01 u_00];
idx = randperm(length(temp_u));
u = temp_u(:,idx(1:input_trial));

Q(1,1) = mean(u(1,:).^2);
Q(1,2) = mean(u(1,:).*u(2,:));
Q(2,1) = Q(1,2);
Q(2,2) = mean(u(2,:).^2);

Q
Q^-1

%% Part II: Full conditioning
% rewards calculation
ANB = 1; %logical input of whether inhibition occurs
P_r = 1;
RescorlaWagner(u, Q, ANB, P_r)

%% Part III: Partial conditioning
% rewards calculation
ANB = 1; %logical input of whether inhibition occurs
P_r = 1/2;
RescorlaWagner(u, Q, ANB, P_r)

%% Part IV: Inhibitory conditioning
% rewards calculation
ANB = 0; %logical input of whether inhibition occurs
P_r = 1;
RescorlaWagner(u, Q, ANB, P_r)