function t = seriTimer(seriObj,fid)
t = timer;
t.BusyMode = 'drop';
t.StartFcn = {@seriStart,fid};
t.TimerFcn = {@seriProcess,seriObj,fid};
t.StopFcn  = {@seriStop,fid};
t.StartDelay = 2;
t.Period = 0.001;
t.TasksToExecute = 1e5;
t.ExecutionMode = 'fixedRate';
end 
function seriStart(~,~,fid)
fprintf(fid,'***Zigbee协调器传来的各个节点RSSI信息***\n');
fprintf(fid,'接收时间,接收节点编号，发送节点0，1，2，3，4，5，6，7，8，9，10，11，12，13\n');
end
function seriProcess(~,~,seriObj,fid)
% 串口读取协调器发来的数据，每2位16进制数
Rx_data = fscanf(seriObj, '%2x');
% 记录读取到数据的时间
time = toc;
fprintf(fid,'%4.4f,',time);
fprintf(fid,'%2u,',Rx_data);
fprintf(fid,'\n');
end

function seriStop(myTimer,~,fid)
fprintf(fid,'结束采集数据\n')
delete(myTimer);
end