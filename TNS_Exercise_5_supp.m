% Course on Teoretical Neuroscience
% Teacher: Jochen Braun
% Assistent Teachers: Ehsan Kakaei
% Exercise06: Operating point of a spiking neuron
% Name: Lee Po Shing & Fahmida Aktar
% Date: 7/12/2017
% Purpose: Generation of five testes for different pairs of N

clear all
clc
close all

% Abbreviation:
% Leaky channels = L
% Excitatory synapse = ex
% Inhibitory synapse = in

%%
% 2. Define input variables
c_v = zeros(5,6);
v_spk = zeros(5,6);
mean_vns = zeros(5,6);
test = [30 35 40 45 50 56];
for i = 1:6
    N = [test(i) 0]; %number of ex and in
    for j = 1:5
        [c_v(j,i),v_spk(j,i),mean_vns(j,i)]=spike_supp(N);
    end
    c_v(6,i) = mean(c_v(1:5,i));
    v_spk(6,i) = mean(v_spk(1:5,i));
    mean_vns(6,i) = mean(mean_vns(1:5,i));
    c_v(7,i) = std(c_v(1:5,i));
    v_spk(7,i) = std(v_spk(1:5,i));
    mean_vns(7,i) = std(mean_vns(1:5,i));
end

figure
subplot(2,2,1)
plot(test, v_spk(6,:))
errorbar(test,v_spk(6,:),v_spk(7,:))
xlabel('N_e_x')
ylabel('v_s_p_k [Hz]')

subplot(2,2,2)
plot(test, c_v(6,:))
errorbar(test,c_v(6,:),c_v(7,:))
xlabel('N_e_x')
ylabel('c_v')

subplot(2,2,3)
plot(test, mean_vns(6,:))
errorbar(test,mean_vns(6,:),mean_vns(7,:))
xlabel('N_e_x')
ylabel('Mean V_n_s [mV]')

subplot(2,2,4)
plot(c_v(6,:), mean_vns(6,:))
errorbar(c_v(6,:),mean_vns(6,:),c_v(7,:),c_v(7,:),mean_vns(7,:),mean_vns(7,:))
xlabel('c_v')
ylabel('Mean V_n_s [mV]')

c_v = zeros(5,6);
v_spk = zeros(5,6);
mean_vns = zeros(5,6);
test = [13 17 21 26 31 36];
for i = 1:6
    N = [100 test(i)]; %number of ex and in
    for j = 1:5
        [c_v(j,i),v_spk(j,i),mean_vns(j,i)]=spike_supp(N);
    end
    c_v(6,i) = mean(c_v(1:5,i));
    v_spk(6,i) = mean(v_spk(1:5,i));
    mean_vns(6,i) = mean(mean_vns(1:5,i));
    c_v(7,i) = std(c_v(1:5,i));
    v_spk(7,i) = std(v_spk(1:5,i));
    mean_vns(7,i) = std(mean_vns(1:5,i));
end

figure
subplot(2,2,1)
plot(test, v_spk(6,:))
errorbar(test,v_spk(6,:),v_spk(7,:))
xlabel('N_i_n')
ylabel('v_s_p_k [Hz]')

subplot(2,2,2)
plot(test, c_v(6,:))
errorbar(test,c_v(6,:),c_v(7,:))
xlabel('N_i_n')
ylabel('c_v')

subplot(2,2,3)
plot(test, mean_vns(6,:))
errorbar(test,mean_vns(6,:),mean_vns(7,:))
xlabel('N_i_n')
ylabel('Mean V_n_s [mV]')

subplot(2,2,4)
plot(c_v(6,:), mean_vns(6,:))
errorbar(c_v(6,:),mean_vns(6,:),c_v(7,:),c_v(7,:),mean_vns(7,:),mean_vns(7,:))
xlabel('c_v')
ylabel('Mean V_n_s [mV]')