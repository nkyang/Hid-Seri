%% 初始化
nodeNum = 13;
RSSI = nan(nodeNum,nodeNum);
%% 打开串口
seriObj = openSeriPort('COM6');
%% 打开激光测距仪SNDWAY
handle  = openHidDev(1155,22352); 
%% 读取数据
T1 = table;
T2 = table;
T3 = table;
T4 = table;
T5 = table;
T6 = table;
T7 = table;
packetIndex = uint32(0);
tic;
while true
    packetIndex = packetIndex + 1;
    Rx_data = fscanf(seriObj, '%2x');
    time = toc;
%     data = sscanf(Rx_data,'%2x');
    newT = array2table([ceil(time*1000),data']);
    RSSI(data(1),:) = -data(2:end);
    if mod(packetIndex,500) == 0
        fprintf('---------Run time:%-5.2f seconds--------\n',time);
        fprintf('|T\\ R|    |    |    |    |    |    |    |\n');
        fprintf('|X \\X|  1 |  2 |  3 |  4 |  5 |  6 |  7 |\n');
        fprintf('|  1 |% 4d|% 4d|% 4d|% 4d|% 4d|% 4d|% 4d|\n',RSSI(1,1),RSSI(1,2),RSSI(1,3),RSSI(1,4),RSSI(1,5),RSSI(1,6),RSSI(1,7));
        fprintf('|  2 |% 4d|% 4d|% 4d|% 4d|% 4d|% 4d|% 4d|\n',RSSI(2,1),RSSI(2,2),RSSI(2,3),RSSI(2,4),RSSI(2,5),RSSI(2,6),RSSI(2,7));
        fprintf('|  3 |% 4d|% 4d|% 4d|% 4d|% 4d|% 4d|% 4d|\n',RSSI(3,1),RSSI(3,2),RSSI(3,3),RSSI(3,4),RSSI(3,5),RSSI(3,6),RSSI(3,7));
        fprintf('|  4 |% 4d|% 4d|% 4d|% 4d|% 4d|% 4d|% 4d|\n',RSSI(4,1),RSSI(4,2),RSSI(4,3),RSSI(4,4),RSSI(4,5),RSSI(4,6),RSSI(4,7));
        fprintf('|  5 |% 4d|% 4d|% 4d|% 4d|% 4d|% 4d|% 4d|\n',RSSI(5,1),RSSI(5,2),RSSI(5,3),RSSI(5,4),RSSI(5,5),RSSI(5,6),RSSI(5,7));
        fprintf('|  6 |% 4d|% 4d|% 4d|% 4d|% 4d|% 4d|% 4d|\n',RSSI(6,1),RSSI(6,2),RSSI(6,3),RSSI(6,4),RSSI(6,5),RSSI(6,6),RSSI(6,7));
        fprintf('|  7 |% 4d|% 4d|% 4d|% 4d|% 4d|% 4d|% 4d|\n',RSSI(7,1),RSSI(7,2),RSSI(7,3),RSSI(7,4),RSSI(7,5),RSSI(7,6),RSSI(7,7));
        fprintf('------Received Packets:%-6d------------\n',packetIndex);
    end
    switch data(1)
        case 1
            T1 = [T1;newT];
            averageValue = mean(T1.Var4(max(end-9,1):end));
            if data(3)-averageValue>4
                sound(y,Fs);
            end
        case 2
            T2 = [T2;newT];
            averageValue = mean(T2.Var3(max(end-9,1):end));
            if data(2)-averageValue>4
                sound(y,Fs);
            end
        case 3
            T3 = [T3;newT];
        case 4
            T4 = [T4;newT];
        case 5
            T5 = [T5;newT];
        case 6
            T6 = [T6;newT];
        case 7
            T7 = [T7;newT];
end
end

