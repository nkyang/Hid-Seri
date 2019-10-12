addpath hidDevice
%% �����һ��MATLAB���̣����ڽ��д������ݵĶ�ȡ��
% ʹ���ļ�ӳ����Ϊ�������̼��ͨ�ŷ�ʽ
% ��ʼ���������̼�Ĺ����ļ�
fid = fopen('shareMem.dat','w+');
fwrite(fid,zeros(1,1e6,'uint8'),'uint8');
fclose(fid);
% �����ļ�ӳ��
mf = memmapfile('shareMem.dat',...
    'Writable',true,...
    'Format',{'uint64',[1 1 1],'t'},...
    'Repeat',1);
% ���ο���ʱ�����д�뵽������ļ�ӳ����
% tStart = tic;
mf.Data.t = tic;
curDty = cd;
eval(['!matlab -sd ',curDty,' -r getSeriData &']);
% 
%% �ý������ڶ�ȡHID�豸��ֵ
% �򿪼�������SNDWAY
[hidObj,wPtr,rPtr]  = openHidDev(1155,22352);
% ����TXT�ļ�laser.txt
% ���ڴ洢������������
hidFileId = fopen('laser.txt','wt+');

while true
    sendKeyRead(hidObj,wPtr); % ��һ�η���Read����ATK001����׼�����
    readHidData(hidObj,rPtr); % �յ��������ǵ�ȷ����Ϣ
    
    sendKeyRead(hidObj,wPtr); % �ڶ��η���Read����ATK001������ʼ���
    readHidData(hidObj,rPtr); % �յ��������ǵ�ȷ����Ϣ
    
    sendGetData(hidObj,wPtr); % ����Ҫ��ش����ݵ����ATD001��
    [data,t] = readHidData(hidObj,rPtr); % ��ȡ�����Ĳ���ֵ ����¼��ʱ��
    fprintf(fid,'%4.4f,%2.4f\n',t,data/10000);
end



