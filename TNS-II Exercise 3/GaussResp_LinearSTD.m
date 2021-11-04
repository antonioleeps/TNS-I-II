function [R_i, R_noisy_i] = GaussResp_LinearSTD(nu, nu_pref, R_max, kappa)
% nu = stimulus frequency vector (of type [1,N])
% nu_pref = [1,N] vector of preferred frequencies
% kappa = parameter determining the S.D.
% R_Max = maximum response rate
% R_noisy_i & R_i = response vectors of type [1,N]

[Nu_pref, Nu] = meshgrid(nu_pref, nu);

sigma = kappa.*Nu_pref;
R_i = R_max*exp(-(1/2).*((Nu - Nu_pref)./(sigma)).^2);
R_noisy_i = R_i + normrnd(0, R_i);
R_noisy_i(R_noisy_i<0) = 0;