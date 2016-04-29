function [labels] = labelSet(label_vector)
% 
% [labels] = labelSet(label_vector);
% 
% author: XU, Shuo (pzczxs@gmail.com)
% date: 2016-01-24
%
tmp = []; 
for i = 1: numel(label_vector)
    tmp = [tmp; label_vector{i}(:)]; 
end
labels = unique(tmp); 
