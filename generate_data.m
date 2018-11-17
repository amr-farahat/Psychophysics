function [data_matrix, frequencies] = generate_data(pattern)
files = dir('*');
data_matrix = [];
frequencies = [];

for i=[1:length(files)]
    fname = files(i).name;
    match = regexp(fname, pattern, 'match');
    if ~isempty(match)
        load(fname)
        background = zeros(10,1);
        distance = zeros(10,1);
        contra = zeros(10,1);
        co = zeros(10,1);
        f = zeros(10,1);
        for j=[1:10]
            background(j) = Block{j}.Settings.Background.ShowBackground;
            distance(j) = Block{j}.Settings.Traction.Distance;
            p = Block{j}.Percept;
            t = Block{j}.Time;
            p1 = p(p~=45);
            t1 = t(p~=45);
            f(j) = length(t1);
            for i=[2:length(t1)]
                if p1(i)==114 
                    co(j) = co(j) + t1(i) - t1(i-1);
                end
                if p1(i)==108 
                    contra(j) = contra(j) + t1(i) - t1(i-1);
                end
            end
        end
        data_matrix = [data_matrix; contra/300, co/300, background, distance];
        frequencies = [frequencies, f];
    end
end

end