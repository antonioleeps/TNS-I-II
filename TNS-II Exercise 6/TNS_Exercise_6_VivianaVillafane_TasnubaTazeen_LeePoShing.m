% Course on Teoretical Neuroscience
% Teacher: Jochen Braun
% Assistent Teachers: Ehsan Kakaei
% Exercise06: Policy learning
% Name: Viviana Villafane & Tasnuba Tazeen & Lee Po Shing
% Date: 31/05/2018

clear all
clc
close all

% Basic parameter
epsilon = 0.1; % Learning rate (epsilon)
beta = 1; % Beta
trial = 100; % Number of trials

sigma = 1; % variance of reward
%% INDIRECT ACTOR
rb_1 = 1;
ry_1 = 3;
rb_2 = 3;
ry_2 = 1;

R_1 = normrnd (rb_1, sigma, 1, 100);
R_2 = normrnd (ry_1, sigma, 1, 100);
R_3 = normrnd (rb_2, sigma, 1, 100);
R_4 = normrnd (ry_2, sigma, 1, 100);

r_y = [R_2,R_4]; % Reward for yellow flower in different trials
r_b = [R_1,R_3]; % Reward for blue flower in different trials

P_b = zeros(size(r_y)); % Probability of blue flowers
P_y = P_b; % Probability of yellow flowers
m_b = P_b; % action value for yellow flower
m_y = P_b; % action value for blue flower

for i = 1: 2*trial
    P_b(i) = 1 /(1+exp(beta*(m_y(i)-m_b(i))));
    P_y(i) = 1 /(1+exp(beta*(m_b(i)-m_y(i))));
     if P_b(i) > rand;
         r_y(i) = 0;
         delta = r_b(i) - m_b(i);
         m_b(i+1) = m_b(i) + epsilon*delta;
         m_y(i+1) = m_y(i);
     else
         r_b(i) = 0;
         delta = r_y(i) - m_y(i);
         m_y(i+1) = m_y(i) + epsilon*delta;
         m_b(i+1) = m_b(i);
     end
end

figure
hold on
plot (P_b, 'b', 'linewidth', 2)
plot (P_y, 'y', 'linewidth', 2)
title (['Probability, Indirect Actor for Epsilon = ' num2str(epsilon)])
legend ('Blue flower', 'Yellow flower')
xlabel ('Trial')

figure
hold on
plot (m_b, 'b', 'linewidth', 2)
plot (m_y, 'y', 'linewidth', 2)
title (['Action values, Indirect Actor for Epsilon = ' num2str(epsilon)])
legend ('Blue flower', 'Yellow flower')
xlabel ('Trial')
xlim ([0 200])

figure
hold on
plot (r_b, 'b', 'linewidth', 2)
plot (r_y, 'y', 'linewidth', 2)
title (['Reward, Indirect Actor for Epsilon = ' num2str(epsilon)])
legend ('Blue flower', 'Yellow flower')
xlabel ('Trial')

R_b = cumsum(r_b);
R_y = cumsum(r_y);

figure
hold on
plot (R_b, 'b', 'linewidth', 2)
plot (R_y, 'y', 'linewidth', 2)
title (['Cumulative reward, Indirect Actor for Epsilon = ' num2str(epsilon)])
legend ('Blue flower', 'Yellow flower')
xlabel ('Trial')

%% DIRECT ACTOR
m_y = zeros(size(r_y));
m_b = m_y;
P_b = m_y;
P_y = m_y;
r = m_y;

r_y = [R_2,R_4]; % Reward for yellow flower in different trials
r_b = [R_1,R_3]; % Reward for blue flower in different trials

for i = 1: 2*trial
    P_b(i) = 1/(1+exp(beta*(m_y(i)-m_b(i))));
    P_y(i) = 1/(1+exp(beta*(m_b(i)-m_y(i))));
    if P_b(i) > rand;
        r_y(i) = 0;
        r(i) = r_b(i);
        if i < 10
            delta = r_b(i) - mean(r(1:i));
        else
            delta = r_b(i) - mean(r(i-9:i));
        end
        m_b(i+1) = m_b(i) + epsilon*(1-P_b(i))*delta;
        m_y(i+1) = m_y(i) - epsilon*P_y(i)*delta;
    else
        r_b(i) = 0;
        r(i) = r_y(i);
        if i < 10
            delta = r_y(i) - mean(r(1:i));
        else
            delta = r_y(i) - mean(r(i-9:i));
        end
        m_b(i+1) = m_b(i) + epsilon*P_b(i)*delta;
        m_y(i+1) = m_y(i) + epsilon*(1-P_y(i))*delta;
    end
end

figure
hold on
plot (P_b, 'b', 'linewidth', 2)
plot (P_y, 'y', 'linewidth', 2)
title (['Probability, Direct Actor for Epsilon = ' num2str(epsilon)])
legend ('Blue flower', 'Yellow flower')
xlabel ('Trial')

figure
hold on
plot (m_b, 'b', 'linewidth', 2)
plot (m_y, 'y', 'linewidth', 2)
title (['Action values, Direct Actor for Epsilon = ' num2str(epsilon)])
legend ('Blue flower', 'Yellow flower')
xlabel ('Trial')
xlim ([0 200])

figure
hold on
plot (r_b, 'b', 'linewidth', 2)
plot (r_y, 'y', 'linewidth', 2)
title (['Reward, Direct Actor for Epsilon = ' num2str(epsilon)])
legend ('Blue flower', 'Yellow flower')
xlabel ('Trial')

R_b = cumsum(r_b);
R_y = cumsum(r_y);

figure
hold on
plot (R_b, 'b', 'linewidth', 2)
plot (R_y, 'y', 'linewidth', 2)
title (['Cumulative reward, Direct Actor for Epsilon = ' num2str(epsilon)])
legend ('Blue flower', 'Yellow flower')
xlabel ('Trial')