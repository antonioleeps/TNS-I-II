% Course on Teoretical Neuroscience
% Teacher: Jochen Braun
% Assistent Teachers: Ehsan Kakaei
% Exercise08: Principal Component Analysis
% Name: Viviana Villafane & Tasnuba Tazeen & Lee Po Shing
% Date: 24/06/2018

clear all
clc
close all

%% Average burst
load MUA_b_t_g.mat; %load data
MUA_g_t = squeeze(mean(MUA_b_t_g))'; %mean of activity

figure
plot(ti, MUA_g_t) %plot of activity against time
xlabel('Time [ms]')
ylabel('Activity of Neuron Group [Hz]')

sub_mean = squeeze(mean(MUA_g_t, 2)); %zero-mean adjustment
X = MUA_g_t - sub_mean;

C_X = X*X'/(Nt-1); %Covariance matrix of X
figure
pcolor(C_X)
axis('square')
colorbar
xlabel('i^{th} Neuron Group')
ylabel('i^{th} Neuron Group')

[U, S, V] = svd(X'); %Singular value decomposition
figure
bar(sum(S)) %plot of S.D.
xlabel('i^{th} Principal Component')
ylabel('Standard Deviation')

%% Transformed activity
Y = V'*X; %Project X on the PC space
figure
plot(ti, Y) %Plot of activity of neuron on PC-space
xlabel('Time')
ylabel('Activity of Neuron Group on PC-Space')

C_Y = Y*Y'/(Nt-1); %Covariance matrix of Y
figure
pcolor(C_Y)
axis('square')
colorbar
xlabel('i^{th} PC')
ylabel('i^{th} PC')

i = 1:3;
figure
plot3(Y(1,:), Y(2,:), Y(3,:)) %3-D plot of activity of neuron on first three PCs
xlabel('1^{st} PC')
ylabel('2^{nd} PC')
zlabel('3^{rd} PC')

Y_denoise = zeros(size(Y)); %Denoise for neuron activity
Y_denoise(i,:) = Y(i,:);
X_denoise = V'\Y_denoise;
figure
plot(ti, X_denoise);
xlabel('Time [ms]')
ylabel('Activity of Neuron Group [Hz]')

%% Individual bursts
figure
for j = 1:10
    Y_j = V'*squeeze(MUA_b_t_g(j,:,:))';
    plot3(Y_j(1,:), Y_j(2,:), Y_j(3,:)) %3-D plot of individual activity of neuron on first three PCs
    hold on
end
xlabel('1^{st} PC')
ylabel('2^{nd} PC')
zlabel('3^{rd} PC')