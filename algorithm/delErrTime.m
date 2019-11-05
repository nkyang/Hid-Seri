%% 删除位于errTime区间内的数据
function data = delErrTime(data,errTime)
flag = true(size(data,1),1);
id = 1;
for jj = 1:size(data,1)
    if data(jj,1) <= errTime(1,id)
        continue
    elseif data(jj,1) > errTime(1,id) && data(jj,1) < errTime(2,id)
        flag(jj) = false;
    elseif id<size(errTime,2)
        id = id+1;
        continue
    end
end
data = data(flag,:);
end