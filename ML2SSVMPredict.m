function [predict_lbl]= ML2SSVMPredict(test_inst, train_inst, train_lbl, alpha, b, mu, p)
% 
% [predict_lbl]= ML2SSVMPredict(test_inst, train_inst, train_lbl, alpha, b, mu, p); 
% 
% author: XU, Shuo (pzczxs@gmail.com)
% date: 2016-01-24
% 
[trnX, trnY, trnN] = ConvertToML2SSVM(train_inst, train_lbl); 

T = numel(trnN); 
predict_lbl = cell(size(test_inst, 1), 1); 

K = Kerfun('rbf', test_inst, trnX, p, 0) .* repmat(trnY', size(test_inst, 1), 1); 
predictY = K * alpha; 
for n = 1: size(test_inst, 1)
    predict_lbl{n} = []; 
    for t = 1: T
        trn_idx1 = sum(trnN(1: t-1)) + 1; 
        trn_idx2 = sum(trnN(1: t)); 
        tmpY = predictY(n) + K(n, trn_idx1: trn_idx2)*alpha(trn_idx1: trn_idx2).*(T/mu) + b(t); 
        if tmpY >= 0 
            predict_lbl{n} = [predict_lbl{n}; t - 1]; 
        end
    end
end
