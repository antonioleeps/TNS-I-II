% Course on Theoretical Neuroscience
% Teacher: Prof. Jochen Braun
% Assistent Teacher: Ehsan Kakaei
% Students: Lee Po Shing & Fahmida Aktar
% Exercise02: Single-compartment model
% Main script
% Date: 05/11/17

% 1. Clear workspace
clear all
clc
close all

% 2. Define parameters
Rm = 0.9; %resistance, in 10^6*Ohm*mm^2
Cm = 12; %capacitance, in 10^-9*F/mm^2
I0 = 25; %amplitude of current, in nA/mm^2
taum = Rm*Cm; %membrane-time constant, in s

% 3. Define time vector
dt = 0.05; %time step, in ms
T = 250; %total time, in ms
t = 0:dt:T; %time vector, from t=0 ms to 250 ms with step size=0.05 ms

% 4. Generate constant input current vector
Ie1 = zeros(size(t));
for i = 1:length(t)
    Ie1(i) = 25; %constant input current, in nA/mm^2
end

% 5. Plot the current into the first axis
figure
hold on
subplot(2,1,1)
plot(t,Ie1,'b')
xlabel('time [ms]')
ylabel('current [nA/mm^2]')

% 6. Iteratively calculate membrane potential and capacitor current
V1(1) = 0; %membrane voltage, in mV
for i = 1:length(Ie1)-1
    V1(i+1) = V1(i)*(1-dt/taum)+Rm*Ie1(i)*dt/taum;
end

% 7. Plot the voltage into the second axis
subplot(2,1,2)
plot(t,V1,'b')
xlabel('time [ms]')
ylabel('membrane potential [mV]')

% Plot the additional currents into the first axis.
Ir1 = V1/Rm;
Ic1 = Cm*(Rm*Ie1-V1)/taum;

subplot(2,1,1)
hold on
plot(t,Ic1,'r')
plot(t,Ir1,'g')
legend('Ie','Ic','Ir')

% Plot the additional voltage into the second axis.
Vinfty1 = Rm*Ie1;

subplot(2,1,2)
hold on
plot(t,Vinfty1,'r')
legend('Vmem','Vinfty')

% [Ploting the above parameters when the current injected is low-frequent
% sinusoidal, high-frequent sinusoidal or high-frequent random input]

% Input current calculations
Ie2 = zeros(size(t));
for i = 1:length(t)
    Ie2(i) = I0*sin(2*pi*10*t(i)*1E-3); %sinmoidol input current with low frequency, in nA/mm^2
end

Ie3 = zeros(size(t));
for i = 1:length(t)
    Ie3(i) = I0*sin(2*pi*100*t(i)*1E-3); %sinmoidol input current with high frequency, in nA/mm^2
end

tcoarse = 0:10*dt:T;
Ie4 = I0*interp1( tcoarse, 2*(rand(size(tcoarse))-0.5), t); %high-frequent random input, in nA/mm^2

%membrane voltage calculations
V2(1) = 0; %membrane voltage for low frequent current, in mV
V3(1) = 0; %membrane voltage for high frequent current, in mV
V4(1) = 0; %membrane voltage for random current, in mV
for i = 1:length(Ie1)-1
    V2(i+1) = V2(i)*(1-dt/taum)+Rm*Ie2(i)*dt/taum;
    V3(i+1) = V3(i)*(1-dt/taum)+Rm*Ie3(i)*dt/taum;
    V4(i+1) = V4(i)*(1-dt/taum)+Rm*Ie4(i)*dt/taum;
end

% Extra parameter calculations
Ir2 = V2/Rm;
Ic2 = Cm*(Rm*Ie2-V2)/taum;
Vinfty2 = Rm*Ie2;

Ir3 = V3/Rm;
Ic3 = Cm*(Rm*Ie3-V3)/taum;
Vinfty3 = Rm*Ie3;

Ir4 = V4/Rm;
Ic4 = Cm*(Rm*Ie4-V4)/taum;
Vinfty4 = Rm*Ie4;

% Graph plotting
figure
subplot(2,1,1)
hold on
plot(t,Ie2,'b')
plot(t,Ic2,'r')
plot(t,Ir2,'g')
legend('Ie','Ic','Ir')

subplot(2,1,2)
hold on
plot(t,V2,'b')
plot(t,Vinfty2,'r')
legend('Vmem','Vinfty')

figure
subplot(2,1,1)
hold on
plot(t,Ie3,'b')
plot(t,Ic3,'r')
plot(t,Ir3,'g')
legend('Ie','Ic','Ir')

subplot(2,1,2)
hold on
plot(t,V3,'b')
plot(t,Vinfty3,'r')
legend('Vmem','Vinfty')

figure
subplot(2,1,1)
hold on
plot(t,Ie4,'b')
plot(t,Ic4,'r')
plot(t,Ir4,'g')
legend('Ie','Ic','Ir')

subplot(2,1,2)
hold on
plot(t,V4,'b')
plot(t,Vinfty4,'r')
legend('Vmem','Vinfty')