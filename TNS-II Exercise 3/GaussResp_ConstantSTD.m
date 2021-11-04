function [R_j, R_noisy_j] = GaussResp_ConstantSTD(nu, nu_pref, R_max, sigma)

% nu = stimulus frequency vector (of type [1,N])
% nu_pref = [1,N] vector of preferred frequencies
% kappa = parameter determining the S.D.
% R_Max = maximum response rate
% R_noisy_j & R_j = response vectors of type [1,N]

[Nu_pref, Nu] = meshgrid(nu_pref, nu);

R_j = R_max*exp(-(1/2).*((Nu - Nu_pref)/(sigma)).^2);
R_noisy_j = R_j + normrnd(0, R_j);
R_noisy_j(R_noisy_j<0) = 0;

