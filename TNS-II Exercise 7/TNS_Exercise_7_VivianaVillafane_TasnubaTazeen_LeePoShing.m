% Course on Teoretical Neuroscience
% Teacher: Jochen Braun
% Assistent Teachers: Ehsan Kakaei
% Exercise07: Expectation Maximization
% Name: Viviana Villafane & Tasnuba Tazeen & Lee Po Shing
% Date: 14/06/2018

clear all
clc
close all

%% Fitting observations by hand
% gamma, mu and var were tested by trial-and-error to achieve a plot of sum
% of the distribution curves of the three causes roughly equals to the
% distribution of observations
gamma = [0.2 0.6 0.2]'; % probability or relative area of X
mu = [-110 100 -20]'; % mean of X
var = [2500 900 2500]'; % variance of X

load observations.mat;
plottingobservation(sample, mu, var, gamma);

%% Fitting observations with expectation maximization
% With the equations given, alternative rounds of expectation step and
% maximatization step were performed until the marginal changes in
% variances
for i = 1:200
    P_X_u = Expect(sample, gamma, mu, var);
    [gamma_temp, mu_temp, var_temp] = Maximize(sample, P_X_u);

    if sum(abs((var_temp-var)./var)) <= 0.003
        break
    end
    gamma = gamma_temp;
    mu = mu_temp;
    var = var_temp;
end
plottingobservation(sample, mu, var, gamma);

function plottingobservation(sample, mu, var, gamma)
bin_width = 20;
x = [-400:400];
edges = [-400:bin_width:380];
u_X = 10000* bin_width* normpdf(x, mu, sqrt(var)).* gamma;
u_sum = sum(u_X);

figure
hold on
histogram(sample, edges);
plot(x, u_X(1,:), 'linewidth', 1.5);
plot(x, u_X(2,:), 'linewidth', 1.5);
plot(x, u_X(3,:), 'linewidth', 1.5);
plot(x, u_sum, 'linewidth', 1.5);
xlabel('Observation');
ylabel('Number of trial');
legend('u_{obs}', 'u_A', 'u_B', 'u_C', 'sum of u_X')
end