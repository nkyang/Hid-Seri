function getSeriData()
addpath seriPort
seriObj = openSeriPort('COM5');
mf = memmapfile('shareMem.dat',...
    'Writable',false,...
    'Format',{'uint64',[1 1 1],'ts';'uint8',[1 1],'flag'},...
    'Repeat',1);
tStart = mf.Data.ts;
sfid = fopen('seri.txt','wt+');

fprintf(sfid,'***ZigbeeЭ���������ĸ����ڵ�RSSI��Ϣ***\n');
fprintf(sfid,'����ʱ��,���սڵ��ţ����ͽڵ�0��1��2��3��4��5��6��7��8��9��10��11��12��13\n');
while mf.Data.flag 
    % ���ڶ�ȡЭ�������������ݣ�ÿ2λ16������
    Rx_data = fscanf(seriObj, '%2x');
    % ��¼��ȡ�����ݵ�ʱ��
    time = toc(tStart);
    fprintf(sfid,'%4.4f,',time);
    fprintf(sfid,'%2u,',Rx_data);
    fprintf(sfid,'\n');
end
fprintf(sfid,'�����ɼ�����\n');
fclose(sfid);
closeSeriPort(seriObj)
clear mf seriObj
end
