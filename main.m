clear
%% 另外打开一个MATLAB进程，用于进行串口数据的读取。
% 使用文件映射作为两个进程间的通信方式
% 初始化两个进程间的共享文件
fid = fopen('shareMem.dat','w+');
fwrite(fid,zeros(1,1024,'uint8'),'uint8');
fclose(fid);
% 获取当前data文件夹内txt文件数目
fileNum = numel(dir('data/*.txt'));
% 建立文件映射
mf = memmapfile('shareMem.dat',...
    'Writable',true,...
    'Format',{'uint64',[1 1],'ts';'uint8',[1 1],'idx';'uint8',[1 1],'flag'},...
    'Repeat',1);
% 将参考的时间零点写入到共享的文件映射中
mf.Data.ts = tic;
% 计算当前文件编号
mf.Data.idx = uint8(fileNum/2);
% 开始工作标志符
mf.Data.flag = uint8(1);
% Current Folder
curDty = cd;
% 确保文件名不存在冲突
flag1 = isfile(['data/laser' num2str(mf.Data.idx) '.txt']);
flag2 = isfile(['data/seri' num2str(mf.Data.idx) '.txt']);
assert(~(flag1&flag2),'错误！文件名冲突！删除data文件夹多余的文件');

eval(['!matlab -automation -sd ',curDty,' -r getSeriData &']);
eval(['!matlab -automation -sd ',curDty,' -r getHidData &']);

% pause(100)
% mf.Data.flag = uint8(0);
% clear mf




