addpath hidDevice
addpath seriPort
%% 打开串口
seriObj = openSeriPort('COM5');
%% 打开激光测距仪SNDWAY
[handle,wPtr,rPtr]  = openHidDev(1155,22352); 
% 开始计时
tic;
%% 读取Zigbee协调器发来的数据
for ii = 1:10
    % 串口读取协调器发来的数据，每2位16进制数
    Rx_data = fscanf(seriObj, '%2x');
    % 记录读取到数据的时间
    time = toc;
    % 打印到命令行
    fprintf('Time: %4.3f; Node: %2d; RSSI:',time,Rx_data(1));
    fprintf('%2u ',Rx_data(2:end));
    fprintf('\n');
end
%% 读取激光测距仪的数据
for ii = 1:10
    % 第一次发送Read键（ATK001），准备测距
    sendKeyRead(handle,wPtr);
    % 收到激光测距仪的确认信息
    readHidData(handle,rPtr);
    % 第二次发送Read键（ATK001），开始测距
    sendKeyRead(handle,wPtr);
    % 收到激光测距仪的确认信息
    readHidData(handle,rPtr);
    % 发送要求回传数据的命令（ATD001）
    sendGetData(handle,wPtr);
    % 读取测距仪传来的测量值 并记录下收到数据的时间
    [data,t2] = readHidData(handle,rPtr);
    % 打印到命令行
    fprintf('Time: %4.3f;True Distance: %2.4f\n',t2,data/10000);
end

closeSeriPort(seriObj);
clear seriObj

closeHidDev(handle);
clear handle wPtr rPtr
