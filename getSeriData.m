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

fprintf(sfid,'*****ZigbeeЭ���������ĸ����ڵ�RSSI��Ϣ*****\n');
fprintf(sfid,'Timestamp,Tx ID��R00��R01��R02��R03��R04��R05��R06��R07��R08��R09��R10��R11��R12��R13\n');

fprintf('��ʼ����\n');
while mf.Data.flag 
    % ���ڶ�ȡЭ�������������ݣ�ÿ2λ16������
    Rx_data = fscanf(seriObj, '%2x');
    % ��¼��ȡ�����ݵ�ʱ��
    time = toc(tStart);
    fprintf(sfid,'%4.4f,',time);
    fprintf(sfid,'%2u,',Rx_data);
    fprintf(sfid,'\n');
end
fprintf('�������\n');

fclose(sfid);
closeSeriPort(seriObj)
clear mf seriObj
end
