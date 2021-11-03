function h = inputvect
h = zeros(1,20);
i = randi(20);
if i == 20
    h([1 i]) = 1+2*rand;
else
    h([i i+1]) = 1+2*rand;
end
end