function [ret] = HammingLoss(Y, Z, M)
%
% [ret] = HammingLoss(Y, Z, M)
% 
% author: XU, Shuo (pzczxs@gmail.com)
% date: 2016-01-24
%
if numel(Y) ~= numel(Z)
    display('The number of Y does not match that of Z.'); 
    return
end

ret = 0; 
for n = 1: numel(Y)
    tmpY = Convert2Binary(Y{n}, M);  
    tmpZ = Convert2Binary(Z{n}, M);  
    
    ret = ret + sum(tmpY ~= tmpZ); 
end

%ret = ret / (M * numel(Y)); 
ret = ret / M; 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [v] = Convert2Binary(u, M) 
v = zeros(M, 1); 
for i = 1: numel(u)
    v(u(i) + 1) = 1; 
end