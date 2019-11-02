function [X,Y]= rssiMatchDist(dist,rssiNet)
rssiBegin = 1;
rssiEnd = size(rssiNet,1);
tmp = nan(size(rssiNet,1),2);
for ii = 1:size(dist,1)
    curTime = dist(ii,1);
    for jj = rssiBegin:rssiEnd
        if rssiNet(jj,1)<curTime
            tmp(jj,:) = dist(ii,:);
        else
            break
        end
    end
    rssiBegin = jj;
end
A =[rssiNet,tmp];
A(isnan(sum(A,2)),:) = [];
X = A(:,2:end-2);
Y = A(:,end);
t1 = A(:,1);
t2 = A(:,end-1);