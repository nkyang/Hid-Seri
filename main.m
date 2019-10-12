addpath hidDevice
%% 另外打开一个MATLAB进程，用于进行串口数据的读取。
% 使用文件映射作为两个进程间的通信方式
% 初始化两个进程间的共享文件
fid = fopen('shareMem.dat','w+');
fwrite(fid,zeros(1,1e6,'uint8'),'uint8');
fclose(fid);
% 建立文件映射
mf = memmapfile('shareMem.dat',...
    'Writable',true,...
    'Format',{'uint64',[1 1 1],'t'},...
    'Repeat',1);
% 将参考的时间零点写入到共享的文件映射中
% tStart = tic;
mf.Data.t = tic;
curDty = cd;
eval(['!matlab -sd ',curDty,' -r getSeriData &']);
% 
%% 该进程用于读取HID设备的值
% 打开激光测距仪SNDWAY
[hidObj,wPtr,rPtr]  = openHidDev(1155,22352);
% 创建TXT文件laser.txt
% 用于存储激光测距仪数据
hidFileId = fopen('laser.txt','wt+');

while true
    sendKeyRead(hidObj,wPtr); % 第一次发送Read键（ATK001），准备测距
    readHidData(hidObj,rPtr); % 收到激光测距仪的确认信息
    
    sendKeyRead(hidObj,wPtr); % 第二次发送Read键（ATK001），开始测距
    readHidData(hidObj,rPtr); % 收到激光测距仪的确认信息
    
    sendGetData(hidObj,wPtr); % 发送要求回传数据的命令（ATD001）
    [data,t] = readHidData(hidObj,rPtr); % 读取传来的测量值 并记录下时间
    fprintf(fid,'%4.4f,%2.4f\n',t,data/10000);
end



