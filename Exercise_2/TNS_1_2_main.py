import numpy as np
from matplotlib import pyplot as plt

Rm = 0.9 # resistance, in 10^6 Ohm*mm^2
Cm = 12 # capacitance, in 10^-9*F/mm^2
I0 = 25 # amplitude of current, in nA/mm^2
taum = Rm*Cm # membrane-time canstant, in s


dt = 0.05 # time step, in ms
T = 250 # total time, in ms
t = np.arange(0, T+dt, dt)

Ie1 = np.ones(*np.shape(t)) * 25 # constant input current, in nA/mm^2

fig1, (ax1, ax2) = plt.subplots(2, 1)
ax1.plot(t, Ie1, 'b')
ax1.set_xlabel('time [ms]')
ax1.set_ylabel('$current [nA/mm^2]$')

V1 = np.zeros(*np.shape(t))
for i in range(len(t)-1):
    V1[i+1] = V1[i]*(1-dt/taum) + Rm*Ie1[i]*dt/taum

ax2.plot(t, V1, 'b')
ax2.set_xlabel('time [ms]')
ax2.set_ylabel('membrane potential [mV]')

Ir1 = V1/Rm
Ic1 = Cm*(Rm*Ie1-V1)/taum

ax1.plot(t, Ic1, 'r')
ax1.plot(t, Ir1, 'g')
ax1.legend(['Ie', 'Ic', 'Ir'])

Vinfty1 = Rm*Ie1
ax2.plot(t, Vinfty1, 'r')
ax2.legend(['$V_{mem}$', '$V_{inf}$'])

plt.show()
