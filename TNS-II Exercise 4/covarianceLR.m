function C = covarianceLR(gamma)
input_trial = 1000;

P_11 = gamma/4; %size of upstream population
P_10 = 0.5-gamma/4; %size of downstream population
P_01 = P_10;
P_00 = P_11;

u_11 = repmat([1;1], 1, uint16(input_trial*P_11));
u_10 = repmat([1;0], 1, uint16(input_trial*P_10));
u_01 = repmat([0;1], 1, uint16(input_trial*P_01));
u_00 = repmat([0;0], 1, uint16(input_trial*P_00));

temp_u = [u_11 u_10 u_01 u_00];
idx = randperm(length(temp_u));
u = temp_u(:,idx(1:input_trial));

C_LL = mean(u(1,:).^2) - mean(u(1,:))^2;
C_LR = mean(u(1,:).*u(2,:)) - mean(u(1,:))*mean(u(2,:));
C_RL = mean(u(2,:).*u(1,:)) - mean(u(2,:))*mean(u(1,:));
C_RR = mean(u(2,:).^2) - mean(u(2,:))^2;

C = [C_LL C_LR;C_RL C_RR];
ShowEigen(C)
end