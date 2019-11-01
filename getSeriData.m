function getSeriData()
addpath('seriPort');
seriObj = openSeriPort('COM4');
mf = memmapfile('shareMem.dat',...
    'Writable',false,...
    'Format',{'uint64',[1 1],'ts';'uint8',[1 1],'idx';'uint8',[1 1],'flag'},...
    'Repeat',1);
tStart = mf.Data.ts;
id = mf.Data.idx;
sfid = fopen(['data\seri',num2str(id),'.txt'],'wt+');

fprintf(sfid,'*****Zigbee协调器传来的各个节点RSSI信息*****\n');
fprintf(sfid,'Timestamp,Tx ID，R00，R01，R02，R03，R04，R05，R06，R07，R08，R09，R10，R11，R12，R13\n');

fprintf('开始测量\n');
while mf.Data.flag 
    % 串口读取协调器发来的数据，每2位16进制数
    Rx_data = fscanf(seriObj, '%2x');
    % 记录读取到数据的时间
    time = toc(tStart);
    fprintf(sfid,'%4.4f,',time);
    fprintf(sfid,'%2u,',Rx_data);
    fprintf(sfid,'\n');
end
fprintf('测量完成\n');

fclose(sfid);
closeSeriPort(seriObj)
clear mf seriObj
end
