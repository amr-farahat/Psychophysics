function [parameters, r2s, pvalues] = screen_analysis(with, without, t)


distances = [0, 0.1, 0.25, 0.5, 0.8];
data = cell(2,1);
data{1} = [with;without]
% data{2} = without;
parameters = [];
r2s = [];
pvalues = [];
fsigm = @(param,xval) param(1)+(param(2)-param(1))./(1+10.^((param(3)-xval)*param(4)));
for i=[1:1]
   %% fitting a sigmoidal curve

    x = repmat(distances, 1,size(data{i},1));
    y = reshape(data{i}',1,size(data{i},1)*size(data{i},2));
    % "min", "max", "x50", "slope"
    figure;
    [estimated_params]=sigm_fit(x,y, [], [], 1, i);
    parameters = [parameters; estimated_params];
    %% calculating R2

    ss_tot = sum((y-mean(y)).^2);
    ss_res = sum((y-fsigm(estimated_params,x)).^2);

    r2 = 1 - (ss_res/ss_tot);
    r2s = [r2s, r2];
    %% bootstrapping
    % resampling the samples to get rid of the outliers effect.
    r2_v_1 = [];
    for k=[1:1000]
        new_data = [];
        for j=[1:length(distances)]
            indexes = randi(size(data{i},2),1,size(data{i},2));
            new_data = [new_data, data{i}(indexes,j)];
        end
        x = repmat(distances, 1,size(new_data,1));
        y = reshape(new_data',1,size(new_data,1)*size(new_data,2));
        ss_tot = sum((y-mean(y)).^2);
        ss_res = sum((y-fsigm(estimated_params,x)).^2);
        r2_v_1 = [r2_v_1, 1 - (ss_res/ss_tot)];
    end
    figure;
    hold on
    hist(r2_v_1, 20)
    set(get(gca,'child'),'FaceColor','r','EdgeColor','w');
    title('resampling for each distance group separately and calculating R2 for each sample')
    

    % shuffling the samples around

    r2_v_2 = [];
    estimated_parameters = [];
    for k=[1:1000]
        new_data = reshape(data{i}',1,[]);
        indexes = randperm(length(new_data));
        new_data = new_data(indexes);
        x = repmat(distances, 1,size(new_data,2)/length(distances));
        y = new_data;
        [estimated_params]=sigm_fit(x,y, [], [], 0);
        estimated_parameters = [estimated_parameters; estimated_params];
        ss_tot = sum((y-mean(y)).^2);
        ss_res = sum((y-fsigm(estimated_params,x)).^2);
        r2_v_2 = [r2_v_2, 1 - (ss_res/ss_tot)];
    end
    pvalue = length(r2_v_2(r2_v_2>r2))/length(r2_v_2);
    pvalues = [pvalues, pvalue];
    hist(r2_v_2, 20)
    [counts, centers] = hist(r2_v_1, 20);
    plot([r2 r2], [0 max(counts)], 'y','linewidth', 2)
    title(t)

    legend({'resampling the groups', 'shuffling the data points', 'R2 value','Location','northwest'})

end


end