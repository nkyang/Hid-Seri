function sendGetData(handle,wPtr)
%% ���ͻ�ȡ���ݵ�����
%   handle ָ��HID�豸��ָ��
%   wPtr дָ�룬ָ��Ҫд������
%            [.  A  T  D  0  0  1  # . . . .  A . . .  T . . .  K . . .  0]
wPtr.value = [0 65 84 68 48 48 49 35 0 0 0 0 65 0 0 0 84 0 0 0 75 0 0 0 48];
res = calllib('hidapi','hid_write',handle,wPtr,uint64(25));
if res < 0
    fprintf('Unable to send\n');
end
end

