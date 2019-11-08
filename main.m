clear
%% �����һ��MATLAB���̣����ڽ��д������ݵĶ�ȡ��
% ʹ���ļ�ӳ����Ϊ�������̼��ͨ�ŷ�ʽ
% ��ʼ���������̼�Ĺ����ļ�
fid = fopen('shareMem.dat','w+');
fwrite(fid,zeros(1,1024,'uint8'),'uint8');
fclose(fid);
% ��ȡ��ǰdata�ļ�����txt�ļ���Ŀ
fileNum = numel(dir('data/*.txt'));
% �����ļ�ӳ��
mf = memmapfile('shareMem.dat',...
    'Writable',true,...
    'Format',{'uint64',[1 1],'ts';'uint8',[1 1],'idx';'uint8',[1 1],'flag'},...
    'Repeat',1);
% ���ο���ʱ�����д�뵽������ļ�ӳ����
mf.Data.ts = tic;
% ���㵱ǰ�ļ����
mf.Data.idx = uint8(fileNum/2);
% ��ʼ������־��
mf.Data.flag = uint8(1);
% Current Folder
curDty = cd;
% ȷ���ļ��������ڳ�ͻ
flag1 = isfile(['data/laser' num2str(mf.Data.idx) '.txt']);
flag2 = isfile(['data/seri' num2str(mf.Data.idx) '.txt']);
assert(~(flag1&flag2),'�����ļ�����ͻ��ɾ��data�ļ��ж�����ļ�');

eval(['!matlab -automation -sd ',curDty,' -r getSeriData &']);
eval(['!matlab -automation -sd ',curDty,' -r getHidData &']);

% pause(100)
% mf.Data.flag = uint8(0);
% clear mf




