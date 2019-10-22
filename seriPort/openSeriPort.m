function seriObj = openSeriPort(portId)
%% ´ò¿ª´®¿Ú
% portId: COM1 COM2 COM3 COM4 COM5 COM6
seriObj = instrfind('Type', 'serial', 'Port', portId);
if isempty(seriObj)
    seriObj = serial(portId);
else
    fclose(seriObj);
    seriObj = seriObj(1);
end
fopen(seriObj);
set(seriObj, 'BaudRate', 115200);
end

