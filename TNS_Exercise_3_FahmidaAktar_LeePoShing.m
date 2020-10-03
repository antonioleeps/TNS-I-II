% Course on Theoretical Neuroscience
% Teacher: Jochen Braun
% Assistent Teacher: Ehsan Kakaei
% Exercise03: Leaky Integrate & Fire Neuron
% Name: Lee Po Shing & Fahmida Aktar
% Date: 16/8/2017
% Purpose: Based on SCM, the LIF model added a reset-mechanism 
% to mimic the sharp of an action potential

clear all
clc
close all

% 1. Define parameters
Rm = 1.5; %membrane resistance, in 10^6 Ohn mm^2
Cm = 20; %membrane capacitance, in 10^-9 F mm^-2
Taum = Rm*Cm; %membrane time constant, in ms

% 2. Define time vectors and parameters
t = [0:0.1:500]; %time vector, ranging from 0 to 500 with step-size 0.1, in ms
dt = 0.1; %time interval, in ms

% 3. Define input current, firstly with constant
I0 = 12; %current amplitude, in nA mm^-2
Ie1 = I0*ones(1,5001);

% 4. Plot the current against time in first axis
figure
subplot(2,1,1)
plot(t,Ie1)
xlabel('Time (ms)')
ylabel('Current (nA/mm^2)')

% 5. Compute the membrane voltage with spiking mechanism
% & 7. Store the time values when reset mechanisms trigger
V_th = -50; %spiking threshold, in mV
V1(1) = -65; %reversal potential or reset potential, in mV
reset_steps1 = []; % empty vector to hold the steps, when V is reset to -65 mV.

for i=1:length(t)-1
    V1(i+1) =  V1(i)*exp(-dt/Taum) + (Ie1(i)*Rm + V1(1))*(1-exp(-dt/Taum));

    if (V1(i+1)>=V_th) %reset mechanism
        V1(i+1) = V1(1); %reset V
        reset_steps1 = [reset_steps1, t(i+1)];
    end
    
end

% 6. Plot the membrane voltage again time in second axis
subplot(2,1,2)
plot(t,V1);
xlabel('Time (ms)');
ylabel('V (mV)');

% 8. Report time values with spike and inter-spike intervals
reset_steps1
tisi1 = diff(reset_steps1)

%% Different current input
% 1. Sinusoidal Current
Ie2 = I0*sin(2*pi*4*t/1000);
V2(1) = -65;
reset_steps2 = [];

for i=1:length(t)-1
    V2(i+1) =  V2(i)*exp(-dt/Taum) + (Ie2(i)*Rm + V2(1))*(1-exp(-dt/Taum));

    if (V2(i+1)>=V_th) %reset mechanism
        V2(i+1) = V2(1); %reset V
        reset_steps2 = [reset_steps2, t(i+1)];
    end
    
end

figure
subplot(2,1,1)
plot(t,Ie2)
xlabel('Time (ms)')
ylabel('Current (nA/mm^2)')

subplot(2,1,2)
plot(t, V2)
xlabel('Time (ms)')
ylabel('Membrane Voltage (mV)')

reset_steps2
tisi2 = diff(reset_steps2)

% 2. Ramping Current
Ie3 = I0*t/150;
V3(1) = -65;
reset_steps3 = [];
Ie3_spike = [];

for i=1:length(t)-1
    V3(i+1) =  V3(i)*exp(-dt/Taum) + (Ie3(i)*Rm + V3(1))*(1-exp(-dt/Taum));

    if (V3(i+1)>=V_th) %reset mechanism
        V3(i+1) = V3(1); %reset V
        reset_steps3 = [reset_steps3, t(i+1)];
        Ie3_spike = [Ie3_spike Ie3(i)];
    end
    
end

figure
subplot(2,1,1)
plot(t,Ie3)
xlabel('Time (ms)')
ylabel('Current (nA/mm^2)')

subplot(2,1,2)
plot(t, V3)
xlabel('Time (ms)')
ylabel('Membrane Voltage (mV)')

reset_steps3
tisi3 = diff(reset_steps3)

figure
hold on
plot(Ie3_spike(2:length(Ie3_spike)), 1./(tisi3*1000))
xlabel('Current (nA/mm^2)')
ylabel('Spiking Frequency (Hz)')