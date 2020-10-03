% Course on Theoretical Neuroscience
% Teacher: Jochen Braun
% Assistent Teachers: Ehsan Kakaei
% Exercise04: The Hodgkin-Huxley Model
% Name: Lee Po Shing & Fahmida Aktar
% Date: 23/11/2017
% Purpose: Hodgkin-Huxley Model

clear all
clc
close all

% Abbreviation:
% Leaky channels = L
% Voltage gated-sodium channels = Na
% Voltage-gated potassium channel = K

%% First current and first set of starting activation variables
% 1. Set basic parameters
c_m = 10; %membrane capacity, in nF/mm^2
g = [3 1200 360]; %maximal conductance of L,Na and K, in \muS/mm^2
E = [-54.402 50 -77]; %reversal potential of L, Na and K, in mV

% 2. Create stable time and current vectors
t = [0:0.1:40]; %vector for time, from 0 to 40, stepsize 0.1, in ms
dt = 0.1; %time intervals, in ms
i_e = 0; %current 1, in nA/mm^2

% 3. Create dynamic vectors
V = -70; %vector for membrane voltage 1, in mV
n = 0.3; %vector for n(t) 1, no unit
m = 0; %vector for m(t) 1, no unit
h = 0; %vector for h(t) 1, no unit

% 4. Calculate dynamic vectors & plot the result
[m, h, n, tau_eff, V_eff_infty, V] = HH_time(c_m, g, E, t, dt, i_e, V, m, h, n);
% i_L = g(1)*(V-E(1));
% i_Na = g(2)*((m.^3).*h).*(V-E(2));
% i_K = g(3)*(n.^4).*(V-E(3));
% figure
% hold on
% plot(t,i_L)
% plot(t,i_Na)
% plot(t,i_K)
% legend('i_L','i_N_a','i_K')

%% Second current and  with set of activation variables at resting state
i_e = 100; %current 2, in nA/mm^2
V = V(length(t)); %vector for membrane voltage 2, in mV
m = m(length(t)); %vector for m(t) 2, no unit
h = h(length(t)); %vector for h(t) 2, no unit
n = n(length(n)); %vector for n(t) 2, no unit
[m, h, n, tau_eff, V_eff_infty, V] = HH_time(c_m, g, E, t, dt, i_e, V, m, h, n);

%figure
%hold on
%plot(t,m.^3.*h)
%plot(t,n.^4)

%% Third current and  a different set of starting activation variables
i_e = 62; %current 3, in nA/mm^2
V = -65; %vector for membrane voltage 3, in mV
m = 0.08; %vector for m(t) 3, no unit
h = 0.5; %vector for h(t) 3, no unit
n = 0.37; %vector for n(t) 3, no unit
[m, h, n, tau_eff, V_eff_infty, V] = HH_time(c_m, g, E, t, dt, i_e, V, m, h, n);

%% Extra current with even lower current
i_e = 61; %current 4, in nA/mm^2
V = -65; %vector for membrane voltage 4, in mV
m = 0.08; %vector for m(t) 4, no unit
h = 0.5; %vector for h(t) 4, no unit
n = 0.37; %vector for n(t) 4, no unit
[m, h, n, tau_eff, V_eff_infty, V] = HH_time(c_m, g, E, t, dt, i_e, V, m, h, n);
