function t = seriTimer(seriObj,fid)
t = timer;
t.BusyMode = 'drop';
t.StartFcn = {@seriStart,fid};
t.TimerFcn = {@seriProcess,seriObj,fid};
t.StopFcn  = {@seriStop,fid};
t.StartDelay = 2;
t.Period = 0.001;
t.TasksToExecute = 1e5;
t.ExecutionMode = 'fixedRate';
end 
function seriStart(~,~,fid)
fprintf(fid,'***ZigbeeЭ���������ĸ����ڵ�RSSI��Ϣ***\n');
fprintf(fid,'����ʱ��,���սڵ��ţ����ͽڵ�0��1��2��3��4��5��6��7��8��9��10��11��12��13\n');
end
function seriProcess(~,~,seriObj,fid)
% ���ڶ�ȡЭ�������������ݣ�ÿ2λ16������
Rx_data = fscanf(seriObj, '%2x');
% ��¼��ȡ�����ݵ�ʱ��
time = toc;
fprintf(fid,'%4.4f,',time);
fprintf(fid,'%2u,',Rx_data);
fprintf(fid,'\n');
end

function seriStop(myTimer,~,fid)
fprintf(fid,'�����ɼ�����\n')
delete(myTimer);
end