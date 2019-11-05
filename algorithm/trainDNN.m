layers = [
    imageInputLayer([1 1 156],"Name","input")
    fullyConnectedLayer(128,"Name","fc_1")
    batchNormalizationLayer("Name","bn_1")
    clippedReluLayer(3,"Name","crelu_1")
    fullyConnectedLayer(128,"Name","fc_2")
    batchNormalizationLayer("Name","bn_2")
    reluLayer("Name","crelu_2")
    fullyConnectedLayer(128,"Name","fc_3")
    batchNormalizationLayer("Name","bn_3")
    clippedReluLayer(3,"Name","crelu_3")
    fullyConnectedLayer(128,"Name","fc_4")
    batchNormalizationLayer("Name","bn_4")
    clippedReluLayer(3,"Name","crelu_4")
    fullyConnectedLayer(128,"Name","fc_5")
    batchNormalizationLayer("Name","bn_5")
    clippedReluLayer(3,"Name","crelu_5")
    fullyConnectedLayer(128,"Name","fc_6")
    batchNormalizationLayer("Name","bn_6")
    clippedReluLayer(3,"Name","crelu_6")
    fullyConnectedLayer(128,"Name","fc_7")
    batchNormalizationLayer("Name","bn_7")
    clippedReluLayer(3,"Name","crelu_7")
    fullyConnectedLayer(128,"Name","fc_8")
    batchNormalizationLayer("Name","bn_8")
    clippedReluLayer(3,"Name","crelu_8")
    fullyConnectedLayer(128,"Name","fc_9")
    batchNormalizationLayer("Name","bn_9")
    clippedReluLayer(3,"Name","crelu_9")
    fullyConnectedLayer(128,"Name","fc_10")
    batchNormalizationLayer("Name","bn_10")
    clippedReluLayer(3,"Name","crelu_10")
    fullyConnectedLayer(128,"Name","fc_11")
    batchNormalizationLayer("Name","bn_11")
    clippedReluLayer(3,"Name","crelu_11")
    fullyConnectedLayer(2,"Name","fc_12")
    regressionLayer("Name","output")];

options = trainingOptions('adam', ...
...    'Momentum',0.9, ...
    'MiniBatchSize',8192, ...
    'MaxEpochs',30, ...
    'Shuffle','every-epoch', ...
    'InitialLearnRate',1e-3, ...
    'LearnRateSchedule','piecewise',...
    'LearnRateDropPeriod',20,...
    'LearnRateDropFactor',0.2,...
    'ValidationData',{Xvalid,Yvalid}, ...
    'ValidationFrequency',10, ...
    'ValidationPatience',10,...
    'Verbose',false, ...
    'ExecutionEnvironment','cpu',...
    'Plots','training-progress',...);
    'GradientThreshold',6);

 net = trainNetwork(Xtrain,Ytrain,layers,options);