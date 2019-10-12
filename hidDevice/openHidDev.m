function [handle,wPtr,rPtr] = openHidDev(vendorID,productID)
%% ��HID�豸
%  vendorID �豸�����̴��� (VID)
%  productID ��Ʒ����    (PID)
%  �������豸������->��������ѧ�豸���ҵ�Ӳ��ID 
%  e.g. USB\VID_0483&PID_5750&REV_0200  
%  ע��������ʮ��������0x0483 0x5750
%  ת��Ϊ10����ΪVID:1155 PID: 22353
if ~libisloaded('hidapi')
    loadlibrary('hidapi','hidapi.h');
    libfunctionsview hidapi
end
% ��ָ��
nullPtr = libpointer;
% ��HID�豸
handle = calllib('hidapi','hid_open',uint16(vendorID),uint16(productID),nullPtr);
% ����Ϊ�Ƕ���ģʽ
calllib('hidapi','hid_set_nonblocking',handle,int32(0));
% �������ڷ�������յĻ�������
wStr = zeros(1,25,'uint8');
wPtr = libpointer('uint8Ptr',wStr);
rStr = zeros(1,25,'uint8');
rPtr = libpointer('uint8Ptr',rStr);
end

