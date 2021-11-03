% Course on Teoretical Neuroscience
% Teacher: Jochen Braun
% Assistent Teachers: Ehsan Kakaei
% Exercise01: Linear Recurrent Network
% Name: Viviana Villafana & Tasnuba Tazeen & Lee Po Shing
% Date: 18/04/2018
% Purpose: 

clear all
clc
close all

%% Task A (Basic Properties of Connection Matrix)
% With size of 20 neurons, the basic properties of the connection matrix,
% including the matrix itself, the two principal eigenvectors and the
% corresponding eigenvalues, were extracted. After that the eigenvectors
% were plotted against the population index and plotted on the vector space
% with the eigenvectors being the axis.
N = 20; %number of neuron
k = 1:20; %population index
tau = 1;

[M, E_vect_1, E_vect_2, lambda_1, lambda_2] = ConnectionMatrix(N); %obtain the properties of the connection matrix

figure
hold on
xlim([1 20])
ylim([-1 3])
stairs(k, E_vect_1, 'LineWidth', 4)
stairs(k, E_vect_2, 'LineWidth', 4)
xlabel('Population Index')
ylabel('Eigenvector / Input Vector')

figure
hold on
axis('square')
xlim([-10 10])
ylim([-10 10])
xlabel('1st Principle Eigenvector')
ylabel('2nd Principle Eigenvector')
grid on
set(gcf, 'Position', [100,100,800,750])

plot([0 E_vect_1'*E_vect_1],[0 E_vect_2'*E_vect_1], 'LineWidth', 4)
plot([0 E_vect_1'*E_vect_2],[0 E_vect_2'*E_vect_2], 'LineWidth', 4)

figure
pcolor(M)
colormap(hot)
axis('square')
colorbar
%% Task A, B & C (For input vector)
% In every for-loop, a new input vector was first generated, then plotted
% on Fig. 1 and Fig. 2. After that, the steady-state was calculated and
% plotted on Fig. 2, followed by another for-loop to show the progression
% along time.
dt = 0.25; %time intervals
t = [0:dt:20]; %vector for time, from 0 to 20, stepsize 0.05

for i = 1:5
    h = inputvect;
    
    figure(1)
    stairs(k, h, 'Color', 'r', 'LineStyle', ':', 'LineWidth', 2)
    
    figure(2)
    plot([0 h*E_vect_1],[0 h*E_vect_2], 'Color', 'r', 'LineWidth' , 3)
    
    v_s_s = [h*E_vect_1/(1-lambda_1) h*E_vect_2/(1-lambda_2)];    
    plot([0 v_s_s(1)],[0 v_s_s(2)],'Color', 'k', 'LineWidth', 1.5)
    
    h = h';
    v_t = zeros(N,length(t));
    v_t(:,1) = h;
    for j = 1:length(t)-1
        v_s_s = M*v_t(:,j) + h;
        v_t(:,j+1) = v_s_s + (v_t(:,j)-v_s_s)*exp(-dt);
    end
    plot(E_vect_1'*v_t, E_vect_2'*v_t,'Color','k', 'Marker', '.','MarkerSize',5,'MarkerEdgeColor','c')
end

figure(1)
legend("1st \lambda = "+num2str(lambda_1), "2st \lambda = "+num2str(lambda_2), 'Input h_i','Location','southeast')

figure(2)
legend('1st Principle Eigenvector', '2st Principle Eigenvector', 'h / v_0', 'v_s_s','v_i', 'Location','best')
%% Part D
% Using the last v_t calculated, the development of each neuron output was
% plotted against time.

figure
surface(t,k,v_t,'LineStyle','none')
xlabel('Time')
ylabel('Population Index')
zlabel('Output vector')
view(-80,20)

figure
surface(t,k,v_t,'LineStyle','none')
xlabel('Time')
ylabel('Population Index')
zlabel('Output vector')
view(-90,0)