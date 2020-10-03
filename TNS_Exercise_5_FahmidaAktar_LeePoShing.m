% Course on Teoretical Neuroscience
% Teacher: Jochen Braun
% Assistent Teachers: Ehsan Kakaei
% Exercise06: Operating point of a spiking neuron
% Name: Lee Po Shing & Fahmida Aktar
% Date: 7/12/2017
% Purpose: Representative graph with shorter time vector

clear all
clc
close all

% Abbreviation:
% Leaky channels = L
% Excitatory synapse = ex
% Inhibitory synapse = in

%%
% 2. Define input variables
t = [0:0.1:2000]; %time vector from 0 to 1000 with stepsize 0.1, in ms
N = [30 0]; %number of ex and in
[V,V_ns] = spike(t,N);

figure
subplot(3,2,1)
plot(t,V)
title('Membrane Voltage with Spikes')
xlabel('Time [ms]')
ylabel('V [mV]')

subplot(3,2,2)
plot(t,V_ns)
title('Membrane Voltage without Spike')
xlabel('Time [ms]')
ylabel('V_n_s [mV]')

N = [40 0]; %number of ex and in
[V,V_ns] = spike(t,N);

subplot(3,2,3)
plot(t,V,'color','r')
xlabel('Time [ms]')
ylabel('V [mV]')

subplot(3,2,4)
plot(t,V_ns,'color','r')
xlabel('Time [ms]')
ylabel('V_n_s [mV]')

N = [56 0]; %number of ex and in
[V,V_ns] = spike(t,N);

subplot(3,2,5)
plot(t,V,'color','g')
xlabel('Time [ms]')
ylabel('V [mV]')

subplot(3,2,6)
plot(t,V_ns,'color','g')
xlabel('Time [ms]')
ylabel('V_n_s [mV]')
set(gcf, 'Position', [400,400,1000, 450])

%%
N = [100 13]; %number of ex and in
[V,V_ns] = spike(t,N);

figure
subplot(3,2,1)
plot(t,V)
title('Membrane Voltage with Spikes')
xlabel('Time [ms]')
ylabel('V [mV]')

subplot(3,2,2)
plot(t,V_ns)
title('Membrane Voltage without Spike')
xlabel('Time [ms]')
ylabel('V_n_s [mV]')

N = [100 21]; %number of ex and in
[V,V_ns] = spike(t,N);

subplot(3,2,3)
plot(t,V,'color','r')
xlabel('Time [ms]')
ylabel('V [mV]')

subplot(3,2,4)
plot(t,V_ns,'color','r')
xlabel('Time [ms]')
ylabel('V_n_s [mV]')

N = [100 31]; %number of ex and in
[V,V_ns] = spike(t,N);

subplot(3,2,5)
plot(t,V,'color','g')
xlabel('Time [ms]')
ylabel('V [mV]')

subplot(3,2,6)
plot(t,V_ns,'color','g')
xlabel('Time [ms]')
ylabel('V_n_s [mV]')
set(gcf, 'Position', [500,500,1000, 450])