function [handle,wPtr,rPtr] = openHidDev(vendorID,productID)
%% 打开HID设备
%  vendorID 设备制造商代号 (VID)
%  productID 产品代号    (PID)
%  可以在设备管理器->人体输入学设备中找到硬件ID 
%  e.g. USB\VID_0483&PID_5750&REV_0200  
%  注意这里是十六进制数0x0483 0x5750
%  转换为10进制为VID:1155 PID: 22353
if ~libisloaded('hidapi')
    loadlibrary('hidapi','hidapi.h');
    libfunctionsview hidapi
end
% 空指针
nullPtr = libpointer;
% 打开HID设备
handle = calllib('hidapi','hid_open',uint16(vendorID),uint16(productID),nullPtr);
% 设置为非堵塞模式
calllib('hidapi','hid_set_nonblocking',handle,int32(0));
% 定义用于发送与接收的缓存数组
wStr = zeros(1,25,'uint8');
wPtr = libpointer('uint8Ptr',wStr);
rStr = zeros(1,25,'uint8');
rPtr = libpointer('uint8Ptr',rStr);
end

