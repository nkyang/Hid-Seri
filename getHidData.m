function getHidData()
addpath hidDevice
%% 该进程用于读取HID设备的值
% 打开激光测距仪SNDWAY
[hidObj,wPtr,rPtr]  = openHidDev(1155,22352);
% 创建TXT文件laser.txt
% 用于存储激光测距仪数据
hfid = fopen('laser.txt','wt+');
% 建立文件映射
mf = memmapfile('shareMem.dat',...
    'Writable',false,...
    'Format',{'uint64',[1 1],'ts';'uint8',[1 1],'flag'},...
    'Repeat',1);
tStart = mf.Data.ts;

fprintf(hfid,'***激光测距仪传来的距离信息***\n');
fprintf(hfid,'接收时间，距离\n');
while mf.Data.flag
    sendKeyRead(hidObj,wPtr); % 第一次发送Read键（ATK001），准备测距
    readHidData(hidObj,rPtr,tStart); % 收到激光测距仪的确认信息
    
    sendKeyRead(hidObj,wPtr); % 第二次发送Read键（ATK001），开始测距
    readHidData(hidObj,rPtr,tStart); % 收到激光测距仪的确认信息
    
    sendGetData(hidObj,wPtr); % 发送要求回传数据的命令（ATD001）
    [data,t] = readHidData(hidObj,rPtr,tStart); % 读取传来的测量值 并记录下时间
    fprintf(hfid,'%4.4f,%2.4f\n',t,data/10000);
end
fprintf(hfid,'结束采集数据');

fclose(hfid);
closeHidDev(hidObj);
clear mf
unloadlibrary('hidapi');
end
