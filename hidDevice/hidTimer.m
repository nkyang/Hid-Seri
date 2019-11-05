function t = hidTimer(hidObj,wPtr,rPtr,fid)
%UNTITLED3 �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
t = timer;
t.BusyMode = 'drop';
t.StartFcn = {@hidStart,fid};
t.TimerFcn = {@hidProcess,hidObj,wPtr,rPtr,fid};
t.StopFcn  = {@hidStop,fid};
t.StartDelay = 2;
t.Period = 0.001;
t.TasksToExecute = 1e2;
t.ExecutionMode = 'fixedRate';
end

function hidStart(~,~,fid)
if ~libisloaded('hidapi')
    loadlibrary('hidapi','hidapi.h');
end
fprintf(fid,'***�������Ǵ����ľ�����Ϣ***\n');
fprintf(fid,'����ʱ�䣬����\n');
end

function hidProcess(~,~,hidObj,wPtr,rPtr,fid)
sendKeyRead(hidObj,wPtr); % ��һ�η���Read����ATK001����׼�����
readHidData(hidObj,rPtr); % �յ��������ǵ�ȷ����Ϣ

sendKeyRead(hidObj,wPtr); % �ڶ��η���Read����ATK001������ʼ���
readHidData(hidObj,rPtr); % �յ��������ǵ�ȷ����Ϣ

sendGetData(hidObj,wPtr); % ����Ҫ��ش����ݵ����ATD001��
[data,t] = readHidData(hidObj,rPtr); % ��ȡ�����Ĳ���ֵ ����¼��ʱ��
fprintf(fid,'%4.4f,%2.4f\n',t,data/10000);
end

function hidStop(myTimer,~,fid)
fprintf(fid,'�����ɼ�����');
delete(myTimer)
end
