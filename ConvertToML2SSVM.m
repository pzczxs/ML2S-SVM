function [X, Y, N] = ConvertToML2SSVM(instance_matrix, label_vector)
% 
% [X, Y, N] = ConvertToML2SSVM(instance_matrix, label_vector);
% 
% author: XU, Shuo (pzczxs@gmail.com)
% date: 2016-01-24
% 
if (size(instance_matrix, 1) ~= numel(label_vector))
    display('The number of instances does not match that of labels.'); 
    return
end

X = [];
Y = [];
N = [];

labels = labelSet(label_vector); 
for i = 1: numel(labels)
    idx1 = []; 
    idx2 = []; 
    for n = 1: numel(label_vector)
        if (sum(label_vector{n} == labels(i)) > 0) 
            idx1 = [idx1; n]; 
        else 
            idx2 = [idx2; n]; 
        end        
    end
    
    X = [X; instance_matrix(idx1, :)];
    Y = [Y; ones(numel(idx1), 1)];
    X = [X; instance_matrix(idx2, :)];
    Y = [Y; -1 * ones(numel(idx2), 1)];
    N = [N; numel(idx1) + numel(idx2)];
end
