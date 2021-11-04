% Course on Teoretical Neuroscience
% Teacher: Jochen Braun
% Assistent Teachers: Ehsan Kakaei
% Exercise02: State Space Analysis
% Name: Viviana Villafañe Barraza & Tasnuba Tazeen & Lee Po Shing
% Date: 25/04/2018
% Purpose: 

clear all
clc
close all

%% Task B
%inputs for LinearOrder2 function
A = [-2 3;-3 2]; %connectivity matrix of the population
b = [-10;10]; %constant input to the population

v_0 = [2;12]; %initial activity vector
LinearOrder2(v_0, A, b);

v_0 = [4;6]; %initial activity vector
LinearOrder2(v_0, A, b);

%% Task C
%Define variables
dt = 0.01;
t = 0:dt:10; %time vector, from t = 0 to 10 with interval of 0.1
v_0 = [11;9]; %initial activity vector

F_max = 40; %activation maximum
kappa = 2:6; %set of kappa

v = zeros(2,length(t));

figure;

for j = 1:length(kappa)
    v(:,1) = v_0;
    for i = 1:length(t)-1
        x = A*v(:,i)+b;
        vss = Factivation(x, F_max, kappa(j));
        v(:,i+1) = vss+(v(:,i)-vss)*exp(-dt); 
    end
    
    %Plot
    subplot(3,2,j)
    plot(t,v)
    ylim([0 15])
    xlabel('Time')
    ylabel('Activity')
    title(['Kappa = ' num2str(kappa(j))])
    if j == 5
        legend('v_1','v_2')
    end
end

plotstatespaceisoclines(v_0,v,A,b)