function ShowEigen( C )

[VC, DC] = eig(C);

lC1 = DC(1,1);
lC2 = DC(2,2);

if VC(1,1) ~= 0 & VC(2,1) < 0 
    VC(:,1) = -1 * VC(:,1);
end

if VC(1,2) ~= 0 & VC(2,2) < 0 
    VC(:,2) = -1 * VC(:,2);
end

VC1 = VC(:,1)*lC1;
VC2 = VC(:,2)*lC2;

figure;
hold on
plot([0 VC(1,1)], [0 VC(2,1)], 'r', 'LineWidth', 2); 
plot([0 VC(1,2)], [0 VC(2,2)], 'b', 'LineWidth', 2); 

plot([0 VC1(1)], [0 VC1(2)], 'g', 'LineWidth', 1.5); 
plot([0 VC2(1)], [0 VC2(2)], 'g', 'LineWidth', 1.5); 

legend('1^{st} Eigenvector', '2^{nd} Eigenvector', '\lambdav_i', 'Location', 'Best');
%hold off;
axis 'equal';
xlabel('i')
ylabel('j')
return;