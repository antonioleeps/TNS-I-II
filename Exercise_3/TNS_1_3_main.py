import numpy as np
import math
from matplotlib import pyplot as plt

# 1. Define parameters
Rm = 1.5  # resistance, in 10^6 Ohm*mm^2
Cm = 20  # capacitance, in 10^-9*F/mm^2
taum = Rm * Cm  # membrane-time constant, in s

# 2. Define time vectors and parameters
dt = 0.1  # time step, in ms
T = 500  # total time, in ms
t = np.arange(0, T+dt, dt)

# 3. Define input current, firstly with constant
I0 = 12  # amplitude of current, in nA/mm^2
Ie1 = np.full_like(t, I0)  # constant input current, in nA/mm^2

# 4. Plot the current against time in first axis
fig1, (ax1, ax2) = plt.subplots(2, 1)
ax1.plot(t, Ie1, 'b')
ax1.set_xlabel('time [ms]')
ax1.set_ylabel('$I_{e} [nA/mm^2]$')

# 5. Compute the membrane voltage with spiking mechanism
# & 7. Store the time values when reset mechanisms trigger
V_th = -50  # spiking threshold, in mV
V1 = np.zeros_like(t)
V1[0] = -65  # reversal potential or reset potential, in mV
reset_steps1 = []  # empty vector to hold the steps, when V is reset to -65 mV.

for i in range(len(t) - 1):
    V1[i+1] = V1[i] * math.exp(-dt/taum) + (Ie1[i]*Rm + V1[0]) * (1-math.exp(-dt/taum))

    if V1[i+1] >= V_th:  # reset mechanism
        V1[i+1] = V1[0]  # reset V
        reset_steps1.append(t[i+1])

# 6. Plot the membrane voltage again time in second axis
ax2.plot(t, V1, 'b')
ax2.set_xlabel('time [ms]')
ax2.set_ylabel('$V [mV]$')

# 8. Report time values with spike and inter-spike intervals
print(reset_steps1)
print(np.diff(reset_steps1))

# Different current input
# 1. Sinusoidal Current
Ie2 = I0 * np.sin(t * 2 * math.pi * 4 / 1000);
V2 = np.zeros_like(t)
V2[0] = -65;
reset_steps2 = [];

for i in range(len(t) - 1):
    V2[i+1] = V2[i] * math.exp(-dt/taum) + (Ie2[i]*Rm + V2[0]) * (1-math.exp(-dt/taum));
    if V2[i+1] >= V_th:  # reset mechanism
        V2[i+1] = V2[0]  # reset V
        reset_steps2.append(t[i + 1])

fig2, (ax1, ax2) = plt.subplots(2, 1)
ax1.plot(t, Ie2, 'b')
ax1.set_xlabel('time [ms]')
ax1.set_ylabel('$I_{e} [nA/mm^2]$')

ax2.plot(t, V2, 'b')
ax2.set_xlabel('time [ms]')
ax2.set_ylabel('$V [mV]$')

print(reset_steps2)
print(np.diff(reset_steps2))

# 2. Ramping Current
Ie3 = t * I0 / 150
V3 = np.zeros_like(t)
V3[0] = -65
reset_steps3 = []
Ie3_spike = []

for i in range(len(t)-1):
    V3[i+1] = V3[i] * math.exp(-dt/taum) + (Ie3[i]*Rm + V3[i]) * (1-math.exp(-dt/taum))

    if V3[i+1] >= V_th:  #reset mechanism
        V3[i+1] = V3[0]  #reset V
        reset_steps3.append(t[i+1])
        Ie3_spike.append(Ie3[i])

fig3, (ax1, ax2) = plt.subplots(2, 1)
ax1.plot(t, Ie3, 'b')
ax1.set_xlabel('time [ms]')
ax1.set_ylabel('$I_{e} [nA/mm^2]$')

ax2.plot(t, V3, 'b')
ax2.set_xlabel('time [ms]')
ax2.set_ylabel('$V [mV]$')

print(reset_steps3)
tisi3 = np.diff(reset_steps3)

fig4, ax = plt.subplots()
ax.plot(Ie3_spike[1:], np.reciprocal(tisi3*1000))
ax.set_xlabel('Current (nA/mm^2)')
ax.set_ylabel('Spiking Frequency (Hz)')

plt.show()