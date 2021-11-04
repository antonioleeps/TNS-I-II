function [gamma, mu, var] = Maximize(sample, P_X_u)
gamma = mean(P_X_u, 2);
mu = mean(P_X_u.*sample, 2)./gamma;
var = mean((sample-mu).^2.*P_X_u, 2)./gamma;
end