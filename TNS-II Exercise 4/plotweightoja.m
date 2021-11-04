function plotweightoja(C)
%Using Oja's rule, the time development of weight with different initial
%inputs were computed and ploted.
dt = 0.01;
t = 0:dt:25;

w = zeros(2, length(t));

figure
xlim([0 1])
ylim([0 1])
xlabel('w_L')
ylabel('w_R')
axis 'square'
hold on

for i = 1:40
    w(1,1) = rand/2;
    w(2,1) = rand/2;
    
    for j = 1:length(t)-1 
        w(:,j+1) = w(:,j) + dt*(C*w(:,j) - 0.5*(w(:,j)'*C*w(:,j))*w(:,j));
        
        if w(1,j+1) >= 1
            w(1,j+1) = 1;
        else if w(1,j+1) <= 0
            w(1,j+1) = 0;
            end
        end
        
        if w(2,j+1) >= 1 
            w(2,j+1) = 1;
        else if w(2,j+1) <= 0
            w(2,j+1) = 0;
            end
        end
    end
    plot(w(1,:), w(2,:), 'g--')
    plot(w(1,1), w(2,1), 'ro')
    plot(w(1,length(t)), w(2,length(t)), 'bo')
end
legend('w(t)', 'w(0)', 'w(t_{end})')