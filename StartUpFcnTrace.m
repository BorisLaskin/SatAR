function handles=StartUpFcnTrace(handles)
uipanelwidth=0.98;
uipanelheight=0.94;
uipanelx=0.01;
uipanely=0.01;
togglebwidth=0.1;
togglebheight=0.05;
set(handles.uiptrace,'Units','normalized','Position',[uipanelx,uipanely,uipanelwidth,uipanelheight]);
set(handles.uiptrace,'BackgroundColor',handles.preferences.color.panel);
set(handles.uiptrace,'Title','Трасса связи','TitlePosition','righttop','Visible','off');
%|||----------------------tbtrace--------------------------------
set(handles.tbtrace,'BackgroundColor',handles.preferences.color.tabs(1,:));
set(handles.tbtrace,'Units','normalized','Position',[0.51,0.95,togglebwidth,togglebheight]);
set(handles.tbtrace,'String','Трасса','Visible','off');

end