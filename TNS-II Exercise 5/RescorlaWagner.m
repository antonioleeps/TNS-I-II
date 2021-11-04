function RescorlaWagner(u, Q, ANB, P_r)
%reward calcuation
r = zeros([1 length(u)]);
for i = 1:length(u)
    if ANB == 1;
        if u(1,i) == 1
            j = rand;
            if rand <= P_r
                r(i) = 1;
            end
        end
    end
    if ANB == 0;
        if u(:,i) == [1 0]'
            j = rand;
            if rand <= P_r
                r(i) =1;
            end
        end
    end
end

P_ru = mean(u.*[r;r], 2)
P_r_u = sum(u.*[r;r], 2)./sum(u, 2)
w_ss = Q^-1 * P_ru;

%Iterative calculation of Resorla-Wagner rule
epsilon = 0.05;
w = zeros(size(u));
delta = zeros(size(r));
for i = 1:length(u)-1
    delta(i+1) = r(i) - w(:,i)'*u(:,i);
    w(:,i+1) = w(:,i) + epsilon*delta(i+1)*u(:,i);
end
ShowSequence(u, r, delta, w)
end