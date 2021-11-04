function P_X_u = Expect(sample, gamma, mu, var)
P_u_X = normpdf(sample, mu, sqrt(var));
P_uX = gamma.*P_u_X;
P_X_u = P_uX./sum(P_uX);
end