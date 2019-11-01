function [Xtrain,Ytrain,Xvalid,Yvalid] = getdata(X,Y)
%% PCA��ά
[coef,scores,~,~,explained,centers] = pca(X);
explainVar = 95/100;
cumsum(explained,'reverse');
numsToKeep = find(cumsum(explained)/sum(explained) >= explainVar,1);
coef = coef(:,1:numsToKeep);
predictors = scores(:,1:numsToKeep);
%% ���ݼ���Ϊѵ��������֤��
num = size(predictors,1);
Y = mat2cell(Y,ones(length(Y),1));
idx = randperm(num,round(0.8*num));
Xtrain = predictors(idx,:)';
Ytrain = Y(idx,:);
idx_valid = setdiff(1:num,idx);

Xvalid = predictors(idx_valid,:)';
Yvalid = Y(idx_valid,:);
