addpath hidDevice
addpath seriPort
%% �򿪴���
seriObj = openSeriPort('COM5');
%% �򿪼�������SNDWAY
[handle,wPtr,rPtr]  = openHidDev(1155,22352); 
% ��ʼ��ʱ
tic;
%% ��ȡZigbeeЭ��������������
for ii = 1:10
    % ���ڶ�ȡЭ�������������ݣ�ÿ2λ16������
    Rx_data = fscanf(seriObj, '%2x');
    % ��¼��ȡ�����ݵ�ʱ��
    time = toc;
    % ��ӡ��������
    fprintf('Time: %4.3f; Node: %2d; RSSI:',time,Rx_data(1));
    fprintf('%2u ',Rx_data(2:end));
    fprintf('\n');
end
%% ��ȡ�������ǵ�����
for ii = 1:10
    % ��һ�η���Read����ATK001����׼�����
    sendKeyRead(handle,wPtr);
    % �յ��������ǵ�ȷ����Ϣ
    readHidData(handle,rPtr);
    % �ڶ��η���Read����ATK001������ʼ���
    sendKeyRead(handle,wPtr);
    % �յ��������ǵ�ȷ����Ϣ
    readHidData(handle,rPtr);
    % ����Ҫ��ش����ݵ����ATD001��
    sendGetData(handle,wPtr);
    % ��ȡ����Ǵ����Ĳ���ֵ ����¼���յ����ݵ�ʱ��
    [data,t2] = readHidData(handle,rPtr);
    % ��ӡ��������
    fprintf('Time: %4.3f;True Distance: %2.4f\n',t2,data/10000);
end

closeSeriPort(seriObj);
clear seriObj

closeHidDev(handle);
clear handle wPtr rPtr
