% Course on Teoretical Neuroscience
% Teacher: Jochen Braun
% Assistent Teachers: Ehsan Kakaei
% Exercise04: Development of ocular dominanace
% Name: Viviana Villafane & Tasnuba Tazeen & Lee Po Shing
% Date: 17/05/2018
% Purpose: 

clear all
clc
close all

% For each of three different gamma values, the covariance matrix of the
% two inputs was computed, followed by the time-development plotting of
% weight using normal covariance rule and Oja's rule.
gamma = 0.46;
C_1 = covarianceLR(gamma)
plotweight(C_1);
plotweightoja(C_1);

gamma = 1;
C_2 = covarianceLR(gamma)
plotweight(C_2);
plotweightoja(C_2);

gamma = 1.72;
C_3 = covarianceLR(gamma)
plotweight(C_3);
plotweightoja(C_3);