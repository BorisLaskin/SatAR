function dlgstart(f,string)
figure(f);
set(f,'CloseRequestFcn','uiresume(gcbf)');
t=uicontrol('Style','text','String',string);
set(t,'Units','normalized','Position', [0.05 0.4 0.9 0.55]);
h=uicontrol('Units','normalized','Position', [0.2 0.05 0.6 0.3], 'String', 'Продолжить','Callback', 'uiresume(gcbf)');
uiwait(f);
delete(f);
end