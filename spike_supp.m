function [c_v,v_spk,mean_vns]=spike_supp(N)

% Course on Teoretical Neuroscience
% Exercise06: Operating point of a spiking neuron
% Name: Lee Po Shing & Fahmida Aktar
% Date: 27/12/2017
% Purpose: generation of V/t graph and calculation of c_v and v_spk with
% input of time range, no. and rate of ex & in synapse input 


% Abbreviation:
% Leaky channels = L
% Excitatory synapse = ex
% Inhibitory synapse = in

% 1. Define basic parameters
c_m = 10; %membrane capacity, in nF/mm^2
g = [1.2 0.1 0.5]; %maxmimum conductance of L, ex and in, in \muS/mm^2
E = [-65 0 -80]; %reversal potential of L, ex and in, in mV
tau = [1 2]; %time constant of ex and in, in ms
v = [20 20]; %spiking rate of ex and in, in Hz
V_reset = -70; % membrane voltage reset, in mV
V_th = -54; %membrane voltage threshold, in mV
t = [0:0.1:20000]; %time vector from 0 to 1000 with stepsize 0.1, in ms
dt = 0.1; %time interval, in ms

P_ex = synaptic_activation(v(1)*N(1), t, tau(1)); %synaptic time-course of ex
P_in = synaptic_activation(v(2)*N(2), t, tau(2)); %synaptic time-course of in

% 3. Calculate membrane voltage
V = zeros(size(t));
V_ns = zeros(size(t));
V(1) = V_reset;
V_ns(1) = V_reset;
t_i = [];
for i = 1:length(t)-1
    Fract_ratio = [1 P_ex(i) P_in(i)];
    tau_eff = c_m/sum(g.*Fract_ratio);
    V_infty = sum(g.*Fract_ratio.*E)*tau_eff/c_m;
    V(i+1) = V_infty+(V(i)-V_infty)*exp(-dt/tau_eff);
    V_ns(i+1) = V_infty+(V_ns(i)-V_infty)*exp(-dt/tau_eff);
    if V(i+1)>=V_th
        V(i+1) = V_reset;
        t_i = [t_i t(i+1)];
    end
end

t_isi = diff(t_i);
c_v = std(t_isi)/mean(t_isi);
v_spk = length(t_i)/t(end)*1000;
mean_vns = mean(V_ns);
end