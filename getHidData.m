function getHidData()
addpath('hidDevice')
%% �ý������ڶ�ȡHID�豸��ֵ
% �򿪼�������SNDWAY
[hidObj,wPtr,rPtr]  = openHidDev(1155,22352);
% �����ļ�ӳ��
mf = memmapfile('shareMem.dat',...
    'Writable',false,...
    'Format',{'uint64',[1 1],'ts';'uint8',[1 1],'idx';'uint8',[1 1],'flag'},...
    'Repeat',1);
tStart = mf.Data.ts;
id = mf.Data.idx;
% ����TXT�ļ�laser.txt
% ���ڴ洢������������
hfid = fopen(['data\laser',num2str(id),'.txt'],'wt+');
fprintf(hfid,'***�������Ǵ����ľ�����Ϣ***\n');
fprintf(hfid,'***Receive Timestamp��Distance***\n');
fprintf('��ʼ����\n');
while mf.Data.flag
    sendKeyRead(hidObj,wPtr); % ��һ�η���Read����ATK001����׼�����
    readHidData(hidObj,rPtr,tStart); % �յ��������ǵ�ȷ����Ϣ
    
    sendKeyRead(hidObj,wPtr); % �ڶ��η���Read����ATK001������ʼ���
    readHidData(hidObj,rPtr,tStart); % �յ��������ǵ�ȷ����Ϣ
    
    sendGetData(hidObj,wPtr); % ����Ҫ��ش����ݵ����ATD001��
    [data,t] = readHidData(hidObj,rPtr,tStart); % ��ȡ�����Ĳ���ֵ ����¼��ʱ��
    fprintf(hfid,'%4.4f,%2.4f\n',t,data/10000);
end
fprintf('�������\n');
fclose(hfid);
closeHidDev(hidObj);
clear mf hidObj
unloadlibrary('hidapi');
end
