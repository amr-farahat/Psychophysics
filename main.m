clear all
close all

patterns = struct('HX','[H][a-z]+[X]','HY','[H][a-z]+[Y]','VX','[V][a-z]+[X]','VY','[V][a-z]+[Y]','all','[HV][a-z]+[YX]');
% screen = 'all';
% pattern = patterns.(screen);
fields = fieldnames(patterns);
curves = cell([4 1]);
for i=1:numel(fields)-1
    pattern = patterns.(fields{i});
    [data_matrix, frequencies] = generate_data(pattern);
    descriptive_plotting(data_matrix, fields{i})
    [with, without] = reshaping_the_data(data_matrix);
    % doing 2 way Anova
%     data = [with;without];
    %[pv,tb,stats] = anova2(data, size(with,1));
    % figure;
    % c = multcompare(stats);
%     [parameters, r2s, pvalues] = screen_analysis(with, without, fields{i});

%     curves{i} = struct('screen', fields{i}, 'parameters', parameters, 'r2', r2s, 'pvalue', pvalues);
end


% modeling the frequency of perception shifting

% y = sum(frequencies,2);
% x = [1:10]';
% p = polyfit(x,y,1);
% yfit = polyval(p,x);
% ss_tot = sum((y-mean(y)).^2); 
% ss_res = sum((y-yfit).^2);
% r2_linear = 1 - (ss_res/ss_tot);
% 
% figure;
% hold on
% scatter(x,y)   
% plot(x, yfit, 'r--')
% title(['R2 = ',num2str(r2_linear)])
% 
% figure;
% for i=[1:size(frequencies,2)]
%     y = frequencies(:,i);
%     x = [1:10]';
%     p = polyfit(x,y,1);
%     yfit = polyval(p,x);
%     ss_tot = sum((y-mean(y)).^2); 
%     ss_res = sum((y-yfit).^2);
%     r2_linear = 1 - (ss_res/ss_tot);
%     subplot(3,4,i)
%     scatter(x,y) 
%     hold on
%     plot(x, yfit, 'r--')
%     title(['R2 = ',num2str(r2_linear)])
% 
% end

