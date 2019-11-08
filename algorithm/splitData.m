function [Xtrain,Ytrain,Xvalid,Yvalid] = splitData(X,Y)

numsToKeep = 156;

%% 数据集分为训练集与验证集
num = size(X,1);
idx = randperm(num,round(0.8*num));
idx_valid = setdiff(1:num,idx);

X = reshape(X',1,1,numsToKeep,[]);
Xtrain = X(1,1,:,idx);
Xvalid = X(1,1,:,idx_valid);
Ytrain = Y(idx,:);
Yvalid = Y(idx_valid,:);
