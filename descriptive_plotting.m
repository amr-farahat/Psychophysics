function descriptive_plotting(data_matrix, screen)

distances = [0, 0.1, 0.25, 0.5, 0.8];
d_co = [];
d_contra = [];
for i=[1:length(distances)]
    d_co =[d_co, data_matrix(data_matrix(:,4)==distances(i),2)];
    d_contra = [d_contra, data_matrix(data_matrix(:,4)==distances(i),1)];
end
means_d = [mean(d_contra)', mean(d_co)'];
% calculating the mean duration for co and contra rotations based on the
% difference in background
backgrounds = [0, 1];
b_co = [];
b_contra = [];
for i=[1:length(backgrounds)]
    b_co =[b_co, data_matrix(data_matrix(:,3)==backgrounds(i),2)];
    b_contra = [b_contra, data_matrix(data_matrix(:,3)==backgrounds(i),1)];
end
means_b = [mean(b_contra)', mean(b_co)'];

figure;
subplot(2,1,1)
bar(means_d)
set(gca, 'XTickLabel', {'0';'0.1';'0.25';'0.5';'0.8'});
legend({'contra rotation', 'co rotation'})
title(screen)

subplot(2,1,2)
bar(means_b)
set(gca, 'XTickLabel', {'without background';'with background'});
legend({'contra rotation', 'co rotation'})

figure;
hold on
plot(repmat(distances,size(d_co,1),1), d_co, 'ro', 'markersize', 8)
coplot = errorbar(distances,mean(d_co),std(d_co), 'r', 'linewidth', 1.2);

plot(repmat(distances,size(d_contra,1),1), d_contra, 'b*', 'markersize', 8)
contraplot = errorbar(distances,mean(d_contra),std(d_contra), 'b', 'linewidth', 1.2);

axis([-0.2 1 -0.2 1])
legend([coplot contraplot],'co rotation','contra rotation')
ylabel('relative percept duration')    
xlabel('distance')    
title(screen)


end