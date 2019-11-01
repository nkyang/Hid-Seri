function [X,Y,t1,t2] = preData()
laserList = dir('../data/laser*.txt');
seriList = dir('../data/seri*.txt');
assert(numel(laserList) == seriList);
for ii = 2:numel(laserList)
    dist = readmatrix(['../data/' laserList(ii).name]);
    % laser传来的数据是上个时间节点的值
    dist = [dist(1:end-1,1),dist(2:end,2)];
    num = size(dist,1);
    curDist = 0;
    % 标记不稳定的值
    flag = true(num,1);
    for ii = 1:num
        if dist(ii,2)< curDist - 0.1
            flag(ii) = false;
        else
            curDist = dist(ii,2);
        end
    end
    tmp = find(cumsum(diff(flag))==-1)+1;
    tmp = reshape(tmp,2,[]);
    tmp = tmp +[-1;1];
    errTime = reshape(dist(tmp,1),2,[]);
%% THE KING IS DEAD LONG LIVE THE KING
nodeNum = 13;
rssi = readmatrix('../data/seri1.txt');
lines = size(rssi,1);
curRSSI = nan(nodeNum,nodeNum);
idx = setdiff(1:nodeNum^2,1:nodeNum+1:nodeNum^2);
newRSSI = nan(lines,length(idx));
for ii = 1:lines
    nodeIdx = rssi(ii,2);
    curRSSI(:,nodeIdx) = rssi(ii,3:15);
    tmp = curRSSI(idx);
    tmp(tmp==0)=100;
    newRSSI(ii,:) = tmp;
end
newRSSI = [rssi(:,1),newRSSI];
newRSSI(isnan(sum(newRSSI,2)),:)=[];
%% THE KING IS DEAD LONG LIVE THE KING
rssiBegin = 1;
rssiEnd = size(newRSSI,1);
tmp = nan(size(newRSSI,1),2);
for ii = 1:size(newDist,1)
    curTime = newDist(ii,1);
    for jj = rssiBegin:rssiEnd
        if newRSSI(jj,1)<curTime
            tmp(jj,:) = newDist(ii,:);
        else
            break
        end
    end
    rssiBegin = jj;
end
A =[newRSSI,tmp];
A(isnan(sum(A,2)),:) = [];
X = A(:,2:end-2);
Y = A(:,end-1);
t1 = A(:,1);
t2 = A(:,end); 
end
function find
