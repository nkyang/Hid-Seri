function [data,t] = readHidData(handle,rPtr,tStart)
%% handle 指向Hid设备的指针
% data 激光测距仪测得的真实距离 单位 0.1mm
% t    收到激光测距仪数据的当前时间 单位 秒
%% 设置初始值
% 如果收到的数据包不是ATD包
% 返回的data t 均为-1;
data = -1;
t = -1;
res = 0;
% 遍历直到收到激光测距仪发来的数据包
while res == 0
    res = calllib('hidapi','hid_read',handle,rPtr,uint64(25));
end
% 记录读取到数据的时间
time = toc(tStart);
% 如果读取到的数据是ATD帧（ATD帧返回当前测量值）
if isequal(rPtr.value(1:3),[65 84 68])
    data = double(rPtr.value(5))*65536 + double(rPtr.value(6))*256 + double(rPtr.value(7));
    t = time;
end
end