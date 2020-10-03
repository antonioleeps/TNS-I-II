function [m, h, n, tau_eff, V_eff_infty, V] = HH_time(c_m, g, E, t, dt, i_e, V, m, h, n)

act_ratio = [1 ((m^3)*h) (n^4)];
tau_eff = c_m/sum(g.*act_ratio);
V_eff_infty = (sum(g.*E.*act_ratio)+i_e)/sum(g.*act_ratio);

for i = 1:length(t)-1
    [m_infty, tau_m] = HH_equi_tau_m(V(i)); 
    [h_infty, tau_h] = HH_equi_tau_h(V(i));
    [n_infty, tau_n] = HH_equi_tau_n(V(i));
    
    m(i+1) = m_infty+(m(i)-m_infty)*exp(-dt/tau_m);
    h(i+1) = h_infty+(h(i)-h_infty)*exp(-dt/tau_h);
    n(i+1) = n_infty+(n(i)-n_infty)*exp(-dt/tau_n);
    act_ratio = [1 ((m(i+1)^3)*h(i+1)) (n(i+1)^4)];
            
    tau_eff(i+1) = c_m/sum(g.*act_ratio);
    V_eff_infty(i+1) = (sum(g.*E.*act_ratio)+i_e)/sum(g.*act_ratio);
    V(i+1) = V_eff_infty(i+1)+(V(i)-V_eff_infty(i+1))*exp(-dt/tau_eff(i+1));
end

figure
subplot(2,1,1)
hold on
plot(t,V)
plot(t,V_eff_infty)
legend('V','V_\infty')
xlabel('Time (ms)')
ylabel('Voltage (mV)')

subplot(2,1,2)
hold on
plot(t,m)
plot(t,h)
plot(t,n)
legend('m','h','n')
xlabel('Time (ms)')
ylabel('Activation State')
end