function [with, without] = reshaping_the_data(data_matrix)
distances = [0, 0.1, 0.25, 0.5, 0.8];
co_t_without_b = [];
contra_t_without_b = [];

co_t_with_b = [];
contra_t_with_b = [];

for i=[1:length(distances)]
    temp_co_without = [];
    temp_contra_without = [];
    temp_co_with = [];
    temp_contra_with = [];
    for k=[1:length(data_matrix)]
        if data_matrix(k,3:4)==[0 distances(i)]
            temp_co_without = [temp_co_without; data_matrix(k,2)];
            temp_contra_without = [temp_contra_without; data_matrix(k,1)];
        end
        if data_matrix(k,3:4)==[1 distances(i)]
            temp_co_with = [temp_co_with; data_matrix(k,2)];
            temp_contra_with = [temp_contra_with; data_matrix(k,1)];
        end
    end
    co_t_without_b =[co_t_without_b, temp_co_without];
    contra_t_without_b = [contra_t_without_b, temp_contra_without];
    co_t_with_b = [co_t_with_b, temp_co_with];
    contra_t_with_b = [contra_t_with_b, temp_contra_with];
            
end

with = co_t_with_b;
without = co_t_without_b;
% data = [co_t_with_b;co_t_without_b];

end