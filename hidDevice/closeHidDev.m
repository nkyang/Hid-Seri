function  closeHidDev(handle)
%% �ر�hid�豸
    calllib('hidapi','hid_close',handle);
    calllib('hidapi','hid_exit');
end

