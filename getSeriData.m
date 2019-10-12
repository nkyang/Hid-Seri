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
    % 串口读取协调器发来的数据，每2位16进制数
    Rx_data = fscanf(seriObj, '%2x');
    % 记录读取到数据的时间
    time = toc(tStart);
    fprintf(fid,'%4.4f,',time);
    fprintf(fid,'%2u,',Rx_data);
    fprintf(fid,'\n');
end