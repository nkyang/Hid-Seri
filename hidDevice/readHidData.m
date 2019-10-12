function [data,t] = readHidData(handle,rPtr)
%% handle ָ��Hid�豸��ָ��
% data �������ǲ�õ���ʵ���� ��λ 0.1mm
% t    �յ������������ݵĵ�ǰʱ�� ��λ ��
%% ���ó�ʼֵ
% ����յ������ݰ�����ATD��
% ���ص�data t ��Ϊ-1;
data = -1;
t = -1;
res = 0;
% ����ֱ���յ��������Ƿ��������ݰ�
while res == 0
    res = calllib('hidapi','hid_read',handle,rPtr,uint64(25));
end
% ��¼��ȡ�����ݵ�ʱ��
time = toc;
% �����ȡ����������ATD֡��ATD֡���ص�ǰ����ֵ��
if isequal(rPtr.value(1:3),[65 84 68])
    data = double(rPtr.value(6))*256 + double(rPtr.value(7));
    t = time;
end
end