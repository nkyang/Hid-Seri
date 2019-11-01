function sendKeyRead(handle,wPtr)
%% Read¼ü
% °´ÏÂRead¼ü
% wPtr.value = [0 65 84 75 48 48 49 35];
wPtr.value = [0 65 84 75 48 48 49 35 0 0 0 0 65 0 0  0 84 0 0 0 68 0 0 0 0];
res = calllib('hidapi','hid_write',handle,wPtr,uint64(25));
if res < 0
    fprintf('Unable to send');
end
end
