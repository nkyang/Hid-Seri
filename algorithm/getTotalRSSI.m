%% 将每个节点的rssi向量按照时间顺序拼接成整个网络的RSSI矩阵
function rssiNet = getTotalRSSI(rssi)
nodeNum = 13;
lines = size(rssi,1);
curRSSI = nan(nodeNum,nodeNum);
idx = setdiff(1:nodeNum^2,1:nodeNum+1:nodeNum^2);
rssiNet = nan(lines,length(idx));
for ii = 1:lines
    nodeIdx = rssi(ii,2);
    curRSSI(:,nodeIdx) = rssi(ii,3:15);
    tmp = curRSSI(idx);
    tmp(tmp==0)=100;
    rssiNet(ii,:) = tmp;
end
rssiNet = [rssi(:,1),rssiNet];
rssiNet(isnan(sum(rssiNet,2)),:)=[];
end