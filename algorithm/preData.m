function [predictor,response] = preData()
laserList = dir('../data/laser*.txt');
seriList = dir('../data/seri*.txt');
assert(numel(laserList) == numel(seriList));
const = [0 2.8 4 4.95 1.73];
predictor = [];
response = [];
for ii = 2:numel(laserList)
    dist = readmatrix(['../data/' laserList(ii).name]);
    rssi = readmatrix(['../data/' seriList(ii).name]);
    % laser传来的数据是上个时间节点的值
    dist = [dist(1:end-1,1),dist(2:end,2)];
    % 最开始的部分数据删除
    dist(dist(:,2)<0.4,:) = [];
    dist(dist(:,2)> 24.5,:) = [];
    errTime = findGap(dist);
    rssiNet = getTotalRSSI(rssi);
    dist    = delErrTime(dist,errTime);
    rssiNet = delErrTime(rssiNet,errTime);
    [X,Y]   = rssiMatchDist(dist, rssiNet);
    predictor = [predictor;X];
    tmp = [Y,const(ii)*ones(size(Y))];
    response = [response;tmp];
end
end


