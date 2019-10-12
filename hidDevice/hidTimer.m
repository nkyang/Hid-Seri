function t = hidTimer(hidObj,wPtr,rPtr,fid)
%UNTITLED3 此处显示有关此函数的摘要
%   此处显示详细说明
t = timer;
t.BusyMode = 'drop';
t.StartFcn = {@hidStart,fid};
t.TimerFcn = {@hidProcess,hidObj,wPtr,rPtr,fid};
t.StopFcn  = {@hidStop,fid};
t.StartDelay = 2;
t.Period = 0.001;
t.TasksToExecute = 1e2;
t.ExecutionMode = 'fixedRate';
end

function hidStart(~,~,fid)
if ~libisloaded('hidapi')
    loadlibrary('hidapi','hidapi.h');
end
fprintf(fid,'***激光测距仪传来的距离信息***\n');
fprintf(fid,'接收时间，距离\n');
end

function hidProcess(~,~,hidObj,wPtr,rPtr,fid)
sendKeyRead(hidObj,wPtr); % 第一次发送Read键（ATK001），准备测距
readHidData(hidObj,rPtr); % 收到激光测距仪的确认信息

sendKeyRead(hidObj,wPtr); % 第二次发送Read键（ATK001），开始测距
readHidData(hidObj,rPtr); % 收到激光测距仪的确认信息

sendGetData(hidObj,wPtr); % 发送要求回传数据的命令（ATD001）
[data,t] = readHidData(hidObj,rPtr); % 读取传来的测量值 并记录下时间
fprintf(fid,'%4.4f,%2.4f\n',t,data/10000);
end

function hidStop(myTimer,~,fid)
fprintf(fid,'结束采集数据');
delete(myTimer)
end
