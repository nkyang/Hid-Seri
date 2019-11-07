function [Xtrain,Ytrain,Xvalid,Yvalid] = getdata(X,Y)
%% PCA��ά
% [coef,scores,~,~,explained,centers] = pca(X);
% explainVar = 95/100;
% cumsum(explained,'reverse');
% numsToKeep = find(cumsum(explained)/sum(explained) >= explainVar,1);
numsToKeep = 156;
% coef = coef(:,1:numsToKeep);
% predictors = scores(:,1:numsToKeep);
%% ���ݼ���Ϊѵ��������֤��
num = size(X,1);
% X = mat2cell(predictors,ones(num,1));
% X = cellfun(@transpose,X,'UniformOutput',false);
% Y = mat2cell(Y,ones(num,1));
% Y = cellfun(@transpose,Y,'UniformOutput',false);
idx = randperm(num,round(0.8*num));
idx_valid = setdiff(1:num,idx);
% Xtrain = X(idx,:);
% Ytrain = Y(idx,:);
% Xvalid = X(idx_valid,:);
% Yvalid = Y(idx_valid,:);
X = reshape(X',1,1,numsToKeep,[]);
Xtrain = X(1,1,:,idx);
Xvalid = X(1,1,:,idx_valid);
Ytrain = Y(idx,:);
Yvalid = Y(idx_valid,:);
