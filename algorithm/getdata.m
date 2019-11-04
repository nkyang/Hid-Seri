function [Xtrain,Ytrain,Xvalid,Yvalid] = getdata(X,Y)
%% PCA降维
[coef,scores,~,~,explained,centers] = pca(X);
explainVar = 99/100;
cumsum(explained,'reverse');
numsToKeep = find(cumsum(explained)/sum(explained) >= explainVar,1);
coef = coef(:,1:numsToKeep);
predictors = scores(:,1:numsToKeep);
%% 数据集分为训练集与验证集
num = size(predictors,1);
X = mat2cell(predictors,ones(num,1));
X = cellfun(@transpose,X,'UniformOutput',false);
Y = mat2cell(Y,ones(num,1));
Y = cellfun(@transpose,Y,'UniformOutput',false);
idx = randperm(num,round(0.8*num));
idx_valid = setdiff(1:num,idx);
Xtrain = X(idx,:);
Ytrain = Y(idx,:);
Xvalid = X(idx_valid,:);
Yvalid = Y(idx_valid,:);
