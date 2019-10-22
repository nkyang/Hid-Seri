function closeSeriPort(seriObj)
%% 关闭串口
%  seriObj   串口对象
%  
fclose(seriObj);
delete(seriObj);
clear seriObj

end

