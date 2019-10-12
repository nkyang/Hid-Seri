function  closeHidDev(handle)
%% πÿ±’hid…Ë±∏
    calllib('hidapi','hid_close',handle);
    calllib('hidapi','hid_exit');
end

