% Course on Teoretical Neuroscience
% Teacher: Jochen Braun
% Assistent Teachers: Ehsan Kakaei
% Exercise03: Supervised Learning
% Name: Viviana Villafana & Tasnuba Tazeen & Lee Po Shing
% Date: 29/04/2018
% Purpose: 

clear all
clc
close all

%% Training of feed-forward connections
% With the sizes of both upstream and downstream populations, the kappa and
% sigma for the turning curves of both population and the number of
% training trials, the covariance matrices with or without noise were
% calculated
i = 200; %size of upstream population
j = 100; %size of downstream population
kappa = 0.2;
sigma = 30;
trial_training = 1000; %number of trial for training

R_max = 1; %max response firing rate, in Hz
nu_max = 1000; %max sound frequency, in Hz

nu_pref_i = rand(1, i)*nu_max; %random preference vector for upstream
nu_pref_j = rand(1, j)*nu_max; %random preference vector for downstream
nu_training = rand(1, trial_training)*nu_max; %training frequency vector

[R_i, R_noisy_i] = GaussResp_LinearSTD(nu_training, nu_pref_i, R_max, kappa); 
[R_j, R_noisy_j] = GaussResp_ConstantSTD(nu_training, nu_pref_j, R_max, sigma);

figure
subplot(2, 1, 1)
hold on
plot(nu_training, R_i(:,1:3), '.')
plot(nu_training, R_noisy_i(:,1:3), '.')
xlabel('Frequency (Hz)')
ylabel('Response (Hz)')
legend('1^{st}', '2^{nd}', '3^{rd}', '1^{st}_{noisy}', '2^{nd}_{noisy}', '3^{rd}_{noisy}', 'location', 'bestoutside');

subplot(2, 1, 2)
hold on
plot(nu_training, R_j(:,1:3), '.')
plot(nu_training, R_noisy_j(:,1:3), '.')
xlabel('Frequency (Hz)')
ylabel('Response (Hz)')
legend('1^{st}', '2^{nd}', '3^{rd}', '1^{st}_{noisy}', '2^{nd}_{noisy}', '3^{rd}_{noisy}', 'location', 'bestoutside');

W = covariance(R_i, R_j); %covariance matrix without noise
W_noisy = covariance(R_noisy_i, R_noisy_j); %covariance matrix with noise

%% Feed-forward network and inferring the testing frequency with downstream activity
trial_test = 1000;
nu_test = rand(1, trial_test)*nu_max; %testing frequency vector

[R_test_i, R_test_noisy_i] = GaussResp_LinearSTD(nu_test, nu_pref_i, R_max, kappa); %return noisy-response from upstream population to different frequencies
R_test_j = R_test_noisy_i*W_noisy'; %calculation of noisy-response from downstream population
R_test_j(R_test_j<0) = 0;

nu_inf = R_test_j*nu_pref_j'./sum(R_test_j, 2); %inferring the testing frequency from noisy-response

figure
hold on
axis('square')
xlim([0 nu_max])
ylim([0 nu_max])

plot(nu_test, nu_test)
plot(nu_test, nu_inf, '.')
xlabel('\nu_{test} (Hz)')
ylabel('\nu (Hz)')
xticks([0 500 1000])
yticks([0 500 1000])
legend('\nu_{test}', '\nu_{inferred}', 'Location', 'southeast')
set(gca,'FontSize',14)