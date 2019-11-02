%% 找到位置发生变化的时刻，标记为errTime
function errTime = findGap(dist)
num = size(dist,1);
curDist = 0;
flag = true(num,1);
for ii = 1:num
    if dist(ii,2)< curDist - 0.1
        flag(ii) = false;
    else
        curDist = dist(ii,2);
    end
end
tmp1 = find(diff(flag)==-1);
tmp2 = find(diff(flag)==1)+1;
tmp = [tmp1,tmp2]';
errTime = reshape(dist(tmp,1),2,[]);
end

