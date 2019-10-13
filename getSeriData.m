function getSeriData()
addpath seriPort
seriObj = openSeriPort('COM5');
mf = memmapfile('shareMem.dat',...
    'Writable',false,...
    'Format',{'uint64',[1 1 1],'ts';'uint8',[1 1],'flag'},...
    'Repeat',1);
tStart = mf.Data.ts;
sfid = fopen('seri.txt','wt+');

fprintf(sfid,'***Zigbee协调器传来的各个节点RSSI信息***\n');
fprintf(sfid,'接收时间,接收节点编号，发送节点0，1，2，3，4，5，6，7，8，9，10，11，12，13\n');
while mf.Data.flag 
    % 串口读取协调器发来的数据，每2位16进制数
    Rx_data = fscanf(seriObj, '%2x');
    % 记录读取到数据的时间
    time = toc(tStart);
    fprintf(sfid,'%4.4f,',time);
    fprintf(sfid,'%2u,',Rx_data);
    fprintf(sfid,'\n');
end
fprintf(sfid,'结束采集数据\n');
fclose(sfid);
closeSeriPort(seriObj)
clear mf seriObj
end
