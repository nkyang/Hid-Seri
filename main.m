%% �����һ��MATLAB���̣����ڽ��д������ݵĶ�ȡ��
% ʹ���ļ�ӳ����Ϊ�������̼��ͨ�ŷ�ʽ
% ��ʼ���������̼�Ĺ����ļ�
fid = fopen('shareMem.dat','w+');
fwrite(fid,zeros(1,1024,'uint8'),'uint8');
fclose(fid);
% �����ļ�ӳ��
mf = memmapfile('shareMem.dat',...
    'Writable',true,...
    'Format',{'uint64',[1 1],'ts';'uint8',[1 1],'idx';'uint8',[1 1],'flag'},...
    'Repeat',1);
% ���ο���ʱ�����д�뵽������ļ�ӳ����
mf.Data.ts = tic;
mf.Data.idx = uint8(2);
mf.Data.flag = uint8(1);
curDty = cd;
eval(['!matlab -automation -sd ',curDty,' -r getSeriData &']);
eval(['!matlab -automation -sd ',curDty,' -r getHidData &']);

% pause(100)
% mf.Data.flag = uint8(0);
% clear mf




