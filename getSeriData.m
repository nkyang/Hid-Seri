function getSeriData()
addpath seriPort
seriObj = openSeriPort('COM5');
mf = memmapfile('shareMem.dat',...
    'Writable',false,...
    'Format',{'uint64',[1 1 1],'t'},...
    'Repeat',1);
tStart = mf.Data.t;
fid = fopen('seri.txt','wt+');
while true 
    % ���ڶ�ȡЭ�������������ݣ�ÿ2λ16������
    Rx_data = fscanf(seriObj, '%2x');
    % ��¼��ȡ�����ݵ�ʱ��
    time = toc(tStart);
    fprintf(fid,'%4.4f,',time);
    fprintf(fid,'%2u,',Rx_data);
    fprintf(fid,'\n');
end