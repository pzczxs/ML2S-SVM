function [gamma_best, lambda_best, p_best, loss_best] = GridML2SSVM(instance_matrix, label_vector, fold, gamma_best, lambda_best, p_best, loss_best)
% 
% [gamma_best, lambda_best, p_best, loss_best] = GridML2SSVM(train_data, train_lbl, fold, gamma_best, lambda_best, p_best, loss_best)
% 
% author: XU, Shuo (pzczxs@gmail.com)
% date: 2016-01-24
% 
gamma = 2.^(-5: 2: 15); 
lambda = 2.^(-10: 2: 10); 
p = 2.^(-15: 2: 3);

[instance_matrix, label_vector] = random_perm(instance_matrix, label_vector); 
M = numel(labelSet(label_vector)); 
N = numel(label_vector); 

loss = zeros(fold, 1); 
for i = 1: length(gamma) 
    for j = 1: length(lambda)
        for k = 1: length(p) 
            for v = 1: fold
                [train_inst, train_lbl, test_inst, test_lbl] = folding(instance_matrix, label_vector, fold, v); 
                [alpha, b] = ML2SSVMTrain(train_inst, train_lbl, gamma(i), lambda(j), p(k)); 
                predict_lbl = ML2SSVMPredict(test_inst, train_inst, train_lbl, alpha, b, lambda(j), p(k)); 
                loss(v) = HammingLoss(test_lbl, predict_lbl, M); 
            end
            
            if loss_best > (sum(loss) / N)
                gamma_best = gamma(i); 
                lambda_best = lambda(j); 
                p_best = p(k); 
                loss_best = (sum(loss) / N);
            end
            
            fprintf('gamma = %g, lambda = %g, p = %g, mean_loss = %g (%g, %g, %g, %g)\n', ...
                log2(gamma(i)), log2(lambda(j)), log2(p(k)), (sum(loss) / N), ...
                log2(gamma_best), log2(lambda_best), log2(p_best), loss_best); 
        end
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% random permutation by swapping i and j instance for each class
function [svm_inst, svm_lbl] = random_perm(svm_inst, svm_lbl)
n = numel(svm_lbl); 
rand('state', 0);
for i = 1: n
    j = round(i + (n - i)*rand());   % [i, n]
    svm_inst([i, j], :) = svm_inst([j, i], :); 
    svm_lbl([i, j]) = svm_lbl([j, i]); 
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [train_inst, train_lbl, test_inst, test_lbl] = folding(svm_inst, svm_lbl, fold, k)
n = numel(svm_lbl); 

% folding instances
start_index = round((k - 1)*n/fold) + 1;
end_index = round(k*n/fold);
test_index = start_index: end_index;

% extract test instances and corresponding labels
test_inst = svm_inst(test_index, :);
test_lbl = svm_lbl(test_index);

% extract train instances and corresponding labels
train_inst = svm_inst;
train_inst(test_index, :) = [];
train_lbl = svm_lbl;
train_lbl(test_index) = [];
