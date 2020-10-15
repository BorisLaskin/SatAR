function varargout = Preferences(varargin)
% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Preferences_OpeningFcn, ...
                   'gui_OutputFcn',  @Preferences_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before Preferences is made visible.
function Preferences_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
handles.preferences=varargin{1};
handles.preferencesold=varargin{1};
handles=StartUP(handles);
handles.Tabs.visible.flags=[1 0 0 0];
handles=ChangeTab(handles);
guidata(hObject, handles);
function varargout = Preferences_OutputFcn(hObject, eventdata, handles) 
uiwait(hObject);
handles=guidata(hObject);
if handles.accept
    varargout{1} = handles.preferences;
else
    varargout{1} = handles.preferencesold;
end
delete(hObject);
function figure1_CloseRequestFcn(hObject, eventdata, handles) %#ok<*DEFNU>
Val=questdlg('Сохранить изменения','');
if strcmp(Val,'Cancel')
elseif strcmp(Val,'No')
    uiresume(gcf);
elseif strcmp(Val,'Yes')
    handles.accept=1;
    uiresume(gcf);
end
% --- Executes on button press in pbcolor.
function pbcolor_Callback(hObject, eventdata, handles) %#ok<*INUSL>
handles.Tabs.visible.flags=[1 0 0 0];
handles=ChangeTab(handles);
guidata(hObject, handles);
function pbtext_Callback(hObject, eventdata, handles)
handles.Tabs.visible.flags=[0 1 0 0];
handles=ChangeTab(handles);
guidata(hObject, handles);
function pbotobr_Callback(hObject, eventdata, handles)
handles.Tabs.visible.flags=[0 0 1 0];
handles=ChangeTab(handles);
guidata(hObject, handles);
function pbparam_Callback(hObject, eventdata, handles)
handles.Tabs.visible.flags=[0 0 0 1];
handles=ChangeTab(handles);
guidata(hObject, handles);
function pbcancel_Callback(hObject, eventdata, handles) %#ok<*INUSD>
handles.accept=0;
guidata(hObject, handles);
uiresume(gcf);
function pbaccept_Callback(hObject, eventdata, handles)
handles.accept=1;
%string=('Для применения параметров требуется перезагрузка программы');
%dlg=dialog('WindowStyle', 'normal', 'Name', 'Информация','Units','normalized','Position',[0.4 0.5 0.2 0.1]);
%dlgstart(dlg,string);
guidata(hObject, handles);
uiresume(gcf);
%--------------------------------------------------------------------------
function handles=StartUP(handles)
handles.accept=0;
togglebwidth=0.19;
togglebheight=0.07;

fonttype.buttons=handles.preferences.fonttype.buttons;
fonttype.subpanel=handles.preferences.fonttype.subpanel;
fonttype.text=handles.preferences.fonttype.text;
fontsize.buttons=handles.preferences.fontsize.buttons;

set(handles.figure1,'Units','normalized','Name','Параметры');
set(handles.figure1,'Renderer','zbuffer');
set(handles.figure1,'Visible','off');
set(handles.pbaccept,'Units','normalized','Position',[0.61,0.01,togglebwidth,togglebheight]);
set(handles.pbaccept,'String','Принять');
set(handles.pbaccept,'FontName',fonttype.buttons,'FontSize',fontsize.buttons);
set(handles.pbcancel,'Units','normalized','Position',[0.8,0.01,togglebwidth,togglebheight]);
set(handles.pbcancel,'String','Отменить');
set(handles.pbcancel,'FontName',fonttype.buttons,'FontSize',fontsize.buttons);


handles=StartUPColor(handles);
handles=StartUPText(handles);
handles=StartUPOtobr(handles);
handles=StartUParam(handles);
handles.Tabs.visible.oldflags=[0 0 0 0];
function handles=ChangeTab(handles)
    flags=handles.Tabs.visible.flags;
	oldflags=handles.Tabs.visible.oldflags;
    %-------------------------------------------------------------------
    if oldflags(1)
        if ~flags(1)
        set(handles.uipcolor,'Visible','off');
        set(handles.pbcolor,'BackgroundColor',handles.preferences.color.tabs(1,:));
        end
    elseif flags(1)
        set(handles.uipcolor,'Visible','on');
        set(handles.pbcolor,'BackgroundColor',handles.preferences.color.tabs(2,:));
    end
    %-------------------------------------------------------------------
    if oldflags(2)
        if ~flags(2)
        set(handles.uiptext,'Visible','off');
        set(handles.pbtext,'BackgroundColor',handles.preferences.color.tabs(1,:));
        end
    elseif flags(2)
        set(handles.uiptext,'Visible','on');
        set(handles.pbtext,'BackgroundColor',handles.preferences.color.tabs(2,:));
    end
    %-------------------------------------------------------------------
    if oldflags(3)
        if ~flags(3)
        set(handles.uipotobr,'Visible','off');
        set(handles.pbotobr,'BackgroundColor',handles.preferences.color.tabs(1,:));
        end
    elseif flags(3)
        set(handles.uipotobr,'Visible','on');
        set(handles.pbotobr,'BackgroundColor',handles.preferences.color.tabs(2,:));
    end
    %-------------------------------------------------------------------
    if oldflags(4)
        if ~flags(4)
        set(handles.uipparam,'Visible','off');
        set(handles.pbparam,'BackgroundColor',handles.preferences.color.tabs(1,:));
        end
    elseif flags(4)
        set(handles.uipparam,'Visible','on');
        set(handles.pbparam,'BackgroundColor',handles.preferences.color.tabs(2,:));
    end
handles.Tabs.visible.oldflags=handles.Tabs.visible.flags;
function handles=StartUPColor(handles)
uipanelwidth=0.98;
uipanelheight=0.84;
uipanelx=0.01;
uipanely=0.09;
togglebwidth=0.19;
togglebheight=0.07;
fonttype.buttons=handles.preferences.fonttype.buttons;
fonttype.subpanel=handles.preferences.fonttype.subpanel;
fonttype.text=handles.preferences.fonttype.text;
fontsize.buttons=handles.preferences.fontsize.buttons;
fontsize.subpanel=handles.preferences.fontsize.subpanel;
fontsize.text=handles.preferences.fontsize.text;
set(handles.uipcolor,'Units','normalized','Position',[uipanelx,uipanely,uipanelwidth,uipanelheight]);
set(handles.uipcolor,'BackgroundColor',handles.preferences.color.panel);
set(handles.uipcolor,'Title','Настройка цвета','TitlePosition','righttop');
set(handles.uipcolor,'FontName',fonttype.subpanel,'FontSize',fontsize.subpanel);
%|||----------------------tbgeometr--------------------------------
set(handles.pbcolor,'BackgroundColor',handles.preferences.color.tabs(1,:));
set(handles.pbcolor,'Units','normalized','Position',[0.01,0.93,togglebwidth,togglebheight]);
set(handles.pbcolor,'String','Цвет');
set(handles.pbcolor,'FontName',fonttype.buttons,'FontSize',fontsize.buttons);
%--------------------------------------------------------------------------
dx1=0.1;dy1=0.07;dx2=0.3;
set(handles.tMcolor,'Units','normalized','Position',[0.05,0.88,dx2,dy1]);
set(handles.tMcolor,'String','Главное окно','HorizontalAlignment','left');
set(handles.tMcolor,'FontName',fonttype.text,'FontSize',fontsize.text);
set(handles.tPcolor,'Units','normalized','Position',[0.05,0.81,dx2,dy1]);
set(handles.tPcolor,'String','Панель','HorizontalAlignment','left');
set(handles.tPcolor,'FontName',fonttype.text,'FontSize',fontsize.text);
set(handles.tSPcolor,'Units','normalized','Position',[0.05,0.74,dx2,dy1]);
set(handles.tSPcolor,'String','Суб панель','HorizontalAlignment','left');
set(handles.tSPcolor,'FontName',fonttype.text,'FontSize',fontsize.text);
set(handles.tTcolor,'Units','normalized','Position',[0.05,0.67,dx2,dy1]);
set(handles.tTcolor,'String','Таба','HorizontalAlignment','left');
set(handles.tTcolor,'FontName',fonttype.text,'FontSize',fontsize.text);
set(handles.tAcolor,'Units','normalized','Position',[0.05,0.6,dx2,dy1]);
set(handles.tAcolor,'String','Вкл./выкл обл.','HorizontalAlignment','left');
set(handles.tAcolor,'FontName',fonttype.text,'FontSize',fontsize.text);
set(handles.tIcolor,'Units','normalized','Position',[0.05,0.53,dx2,dy1]);
set(handles.tIcolor,'String','Недоступный облучатель','HorizontalAlignment','left');
set(handles.tIcolor,'FontName',fonttype.text,'FontSize',fontsize.text);
set(handles.tCcolor,'Units','normalized','Position',[0.05,0.46,dx2,dy1]);
set(handles.tCcolor,'String','Города','HorizontalAlignment','left');
set(handles.tCcolor,'FontName',fonttype.text,'FontSize',fontsize.text);
set(handles.tRcolor,'Units','normalized','Position',[0.05,0.39,dx2,dy1]);
set(handles.tRcolor,'String','Реки','HorizontalAlignment','left');
set(handles.tRcolor,'FontName',fonttype.text,'FontSize',fontsize.text);
set(handles.tLcolor,'Units','normalized','Position',[0.05,0.32,dx2,dy1]);
set(handles.tLcolor,'String','Озера','HorizontalAlignment','left');
set(handles.tLcolor,'FontName',fonttype.text,'FontSize',fontsize.text);
set(handles.tVcolor,'Units','normalized','Position',[0.05,0.25,dx2,dy1]);
set(handles.tVcolor,'String','Зона видимости спутника','HorizontalAlignment','left');
set(handles.tVcolor,'FontName',fonttype.text,'FontSize',fontsize.text);
set(handles.tPolcolor,'Units','normalized','Position',[0.05,0.18,dx2,dy1]);
set(handles.tPolcolor,'String','Поляризации','HorizontalAlignment','left');
set(handles.tPolcolor,'FontName',fonttype.text,'FontSize',fontsize.text);

set(handles.pbMcolor,'Units','normalized','Position',[0.85,0.88,dx1,dy1]);
set(handles.pbMcolor,'String','','BackgroundColor',handles.preferences.color.MainWinC);
set(handles.pbMcolor,'FontName',fonttype.buttons,'FontSize',fontsize.buttons);
set(handles.pbPcolor,'Units','normalized','Position',[0.85,0.81,dx1,dy1]);
set(handles.pbPcolor,'String','','BackgroundColor',handles.preferences.color.panel);
set(handles.pbPcolor,'FontName',fonttype.buttons,'FontSize',fontsize.buttons);
set(handles.pbSPcolor,'Units','normalized','Position',[0.85,0.74,dx1,dy1]);
set(handles.pbSPcolor,'String','','BackgroundColor',handles.preferences.color.subpanel);
set(handles.pbSPcolor,'FontName',fonttype.buttons,'FontSize',fontsize.buttons);
set(handles.pbTcolor1,'Units','normalized','Position',[0.75,0.67,dx1,dy1]);
set(handles.pbTcolor1,'String','Нектив.','BackgroundColor',handles.preferences.color.tabs(1,:));
set(handles.pbTcolor1,'FontName',fonttype.buttons,'FontSize',fontsize.buttons);
set(handles.pbTcolor2,'Units','normalized','Position',[0.85,0.67,dx1,dy1]);
set(handles.pbTcolor2,'String','Актив.','BackgroundColor',handles.preferences.color.tabs(2,:));
set(handles.pbTcolor2,'FontName',fonttype.buttons,'FontSize',fontsize.buttons);
set(handles.pbAcolor1,'Units','normalized','Position',[0.75,0.6,dx1,dy1]);
set(handles.pbAcolor1,'String','Актив.','BackgroundColor',handles.preferences.color.beactiv(1,:));
set(handles.pbAcolor1,'FontName',fonttype.buttons,'FontSize',fontsize.buttons);
set(handles.pbAcolor2,'Units','normalized','Position',[0.85,0.6,dx1,dy1]);
set(handles.pbAcolor2,'String','Неактив.','BackgroundColor',handles.preferences.color.beactiv(2,:));
set(handles.pbAcolor2,'FontName',fonttype.buttons,'FontSize',fontsize.buttons);
set(handles.pbIcolor,'Units','normalized','Position',[0.85,0.53,dx1,dy1]);
set(handles.pbIcolor,'String','','BackgroundColor',handles.preferences.color.inaccessible);
set(handles.pbIcolor,'FontName',fonttype.buttons,'FontSize',fontsize.buttons);
set(handles.pbCcolor,'Units','normalized','Position',[0.85,0.46,dx1,dy1]);
set(handles.pbCcolor,'String','','BackgroundColor',handles.preferences.color.cities);
set(handles.pbCcolor,'FontName',fonttype.buttons,'FontSize',fontsize.buttons);
set(handles.pbRcolor,'Units','normalized','Position',[0.85,0.39,dx1,dy1]);
set(handles.pbRcolor,'String','','BackgroundColor',handles.preferences.color.rivers);
set(handles.pbRcolor,'FontName',fonttype.buttons,'FontSize',fontsize.buttons);
set(handles.pbLcolor,'Units','normalized','Position',[0.85,0.32,dx1,dy1]);
set(handles.pbLcolor,'String','','BackgroundColor',handles.preferences.color.lakes);
set(handles.pbLcolor,'FontName',fonttype.buttons,'FontSize',fontsize.buttons);
set(handles.pbVcolor,'Units','normalized','Position',[0.85,0.25,dx1,dy1]);
set(handles.pbVcolor,'String','','BackgroundColor',handles.preferences.color.VisibleZone);
set(handles.pbVcolor,'FontName',fonttype.buttons,'FontSize',fontsize.buttons);
set(handles.pbPolcolor1,'Units','normalized','Position',[0.55,0.18,dx1,dy1]);
set(handles.pbPolcolor1,'String','Пол.1','BackgroundColor',handles.preferences.color.polar(1,:));
set(handles.pbPolcolor1,'FontName',fonttype.buttons,'FontSize',fontsize.buttons);
set(handles.pbPolcolor2,'Units','normalized','Position',[0.65,0.18,dx1,dy1]);
set(handles.pbPolcolor2,'String','Пол.2','BackgroundColor',handles.preferences.color.polar(2,:));
set(handles.pbPolcolor2,'FontName',fonttype.buttons,'FontSize',fontsize.buttons);
set(handles.pbPolcolor3,'Units','normalized','Position',[0.75,0.18,dx1,dy1]);
set(handles.pbPolcolor3,'String','Пол.3','BackgroundColor',handles.preferences.color.polar(3,:));
set(handles.pbPolcolor3,'FontName',fonttype.buttons,'FontSize',fontsize.buttons);
set(handles.pbPolcolor4,'Units','normalized','Position',[0.85,0.18,dx1,dy1]);
set(handles.pbPolcolor4,'String','Пол.4','BackgroundColor',handles.preferences.color.polar(4,:));
set(handles.pbPolcolor4,'FontName',fonttype.buttons,'FontSize',fontsize.buttons);
%--------------------------------------------------------------------------

set(handles.uipcolor,'Visible','off');
function handles=StartUPText(handles)
uipanelwidth=0.98;
uipanelheight=0.84;
uipanelx=0.01;
uipanely=0.09;
togglebwidth=0.19;
togglebheight=0.07;
fonttype.buttons=handles.preferences.fonttype.buttons;
fonttype.subpanel=handles.preferences.fonttype.subpanel;
fonttype.text=handles.preferences.fonttype.text;
fontsize.buttons=handles.preferences.fontsize.buttons;
fontsize.subpanel=handles.preferences.fontsize.subpanel;
fontsize.text=handles.preferences.fontsize.text;
set(handles.uiptext,'Units','normalized','Position',[uipanelx,uipanely,uipanelwidth,uipanelheight]);
set(handles.uiptext,'BackgroundColor',handles.preferences.color.panel);
set(handles.uiptext,'Title','Настройка текстовых полей','TitlePosition','righttop');
set(handles.uiptext,'FontName',fonttype.subpanel,'FontSize',fontsize.subpanel);
%|||----------------------tbgeometr--------------------------------
set(handles.pbtext,'BackgroundColor',handles.preferences.color.tabs(1,:));
set(handles.pbtext,'Units','normalized','Position',[0.2,0.93,togglebwidth,togglebheight]);
set(handles.pbtext,'String','Текст');
set(handles.pbtext,'FontName',fonttype.buttons,'FontSize',fontsize.buttons);
%--------------------------------------------------------------------------
dx1=0.1;dy1=0.07;dx2=0.3;
set(handles.tbut,'Units','normalized','Position',[0.05,0.88,dx2,dy1]);
set(handles.tbut,'String','Кнопоки','HorizontalAlignment','left');
set(handles.tbut,'FontName',fonttype.text,'FontSize',fontsize.text);
set(handles.tsubp,'Units','normalized','Position',[0.05,0.81,dx2,dy1]);
set(handles.tsubp,'String','Панели','HorizontalAlignment','left');
set(handles.tsubp,'FontName',fonttype.text,'FontSize',fontsize.text);
set(handles.tax,'Units','normalized','Position',[0.05,0.74,dx2,dy1]);
set(handles.tax,'String','Графики','HorizontalAlignment','left');
set(handles.tax,'FontName',fonttype.text,'FontSize',fontsize.text);
set(handles.ttxt,'Units','normalized','Position',[0.05,0.67,dx2,dy1]);
set(handles.ttxt,'String','Текстовые поля','HorizontalAlignment','left');
set(handles.ttxt,'FontName',fonttype.text,'FontSize',fontsize.text);
set(handles.tmatr,'Units','normalized','Position',[0.05,0.6,dx2,dy1]);
set(handles.tmatr,'String','Матрицы','HorizontalAlignment','left');
set(handles.tmatr,'FontName',fonttype.text,'FontSize',fontsize.text);

set(handles.tbutC,'Units','normalized','Position',[0.35,0.88,dx2,dy1]);
set(handles.tbutC,'String',strcat(handles.preferences.fonttype.buttons,'__',...
    num2str(handles.preferences.fontsize.buttons)),'HorizontalAlignment','center');
set(handles.tbutC,'FontName',fonttype.text,'FontSize',fontsize.text);
set(handles.tsubpC,'Units','normalized','Position',[0.35,0.81,dx2,dy1]);
set(handles.tsubpC,'String',strcat(handles.preferences.fonttype.subpanel,'__',...
    num2str(handles.preferences.fontsize.subpanel)),'HorizontalAlignment','center');
set(handles.tsubpC,'FontName',fonttype.text,'FontSize',fontsize.text);
set(handles.taxC,'Units','normalized','Position',[0.35,0.74,dx2,dy1]);
set(handles.taxC,'String',strcat(handles.preferences.fonttype.axes,'__',...
    num2str(handles.preferences.fontsize.axes)),'HorizontalAlignment','center');
set(handles.taxC,'FontName',fonttype.text,'FontSize',fontsize.text);
set(handles.ttxtC,'Units','normalized','Position',[0.35,0.67,dx2,dy1]);
set(handles.ttxtC,'String',strcat(handles.preferences.fonttype.text,'__',...
    num2str(handles.preferences.fontsize.text)),'HorizontalAlignment','center');
set(handles.ttxtC,'FontName',fonttype.text,'FontSize',fontsize.text);
set(handles.tmatrC,'Units','normalized','Position',[0.35,0.6,dx2,dy1]);
set(handles.tmatrC,'String',strcat(handles.preferences.fonttype.matrix,'__',...
    num2str(handles.preferences.fontsize.matrix)),'HorizontalAlignment','center');
set(handles.tmatrC,'FontName',fonttype.text,'FontSize',fontsize.text);

set(handles.pbbut,'Units','normalized','Position',[0.85,0.88,dx1,dy1]);
set(handles.pbbut,'String','');
set(handles.pbbut,'FontName',fonttype.buttons,'FontSize',fontsize.buttons);
set(handles.pbsubp,'Units','normalized','Position',[0.85,0.81,dx1,dy1]);
set(handles.pbsubp,'String','');
set(handles.pbsubp,'FontName',fonttype.buttons,'FontSize',fontsize.buttons);
set(handles.pbax,'Units','normalized','Position',[0.85,0.74,dx1,dy1]);
set(handles.pbax,'String','');
set(handles.pbax,'FontName',fonttype.buttons,'FontSize',fontsize.buttons);
set(handles.pbtxt,'Units','normalized','Position',[0.85,0.67,dx1,dy1]);
set(handles.pbtxt,'String','');
set(handles.pbtxt,'FontName',fonttype.buttons,'FontSize',fontsize.buttons);
set(handles.pbmatr,'Units','normalized','Position',[0.85,0.6,dx1,dy1]);
set(handles.pbmatr,'String','');
set(handles.pbmatr,'FontName',fonttype.buttons,'FontSize',fontsize.buttons);

set(handles.uiptext,'Visible','off');
function handles=StartUPOtobr(handles)
uipanelwidth=0.98;
uipanelheight=0.84;
uipanelx=0.01;
uipanely=0.09;
togglebwidth=0.19;
togglebheight=0.07;
fonttype.buttons=handles.preferences.fonttype.buttons;
fonttype.subpanel=handles.preferences.fonttype.subpanel;
fonttype.text=handles.preferences.fonttype.text;
fontsize.buttons=handles.preferences.fontsize.buttons;
fontsize.subpanel=handles.preferences.fontsize.subpanel;
fontsize.text=handles.preferences.fontsize.text;
set(handles.uipotobr,'Units','normalized','Position',[uipanelx,uipanely,uipanelwidth,uipanelheight]);
set(handles.uipotobr,'BackgroundColor',handles.preferences.color.panel);
set(handles.uipotobr,'Title','Настройка параметров отображения','TitlePosition','righttop');
set(handles.uipotobr,'FontName',fonttype.subpanel,'FontSize',fontsize.subpanel);
%|||----------------------tbgeometr--------------------------------
set(handles.pbotobr,'BackgroundColor',handles.preferences.color.tabs(1,:));
set(handles.pbotobr,'Units','normalized','Position',[0.39,0.93,togglebwidth,togglebheight]);
set(handles.pbotobr,'String','Отображение');
set(handles.pbotobr,'FontName',fonttype.buttons,'FontSize',fontsize.buttons);

dx1=0.1;dy1=0.07;dx2=0.3;

set(handles.tgraph,'Units','normalized','Position',[0.05,0.88,dx2,dy1]);
set(handles.tgraph,'String','Толщина линий графиков','HorizontalAlignment','left');
set(handles.tgraph,'FontName',fonttype.text,'FontSize',fontsize.text);
set(handles.tcontour,'Units','normalized','Position',[0.05,0.81,dx2,dy1]);
set(handles.tcontour,'String','Толщина линий контуров лучей','HorizontalAlignment','left');
set(handles.tcontour,'FontName',fonttype.text,'FontSize',fontsize.text);
set(handles.taxant,'Units','normalized','Position',[0.05,0.74,dx2,dy1]);
set(handles.taxant,'String','Разрешение модели антенны','HorizontalAlignment','left');
set(handles.taxant,'FontName',fonttype.text,'FontSize',fontsize.text);
set(handles.tDN,'Units','normalized','Position',[0.05,0.67,dx2,dy1]);
set(handles.tDN,'String','Разрешение графиков ДН','HorizontalAlignment','left');
set(handles.tDN,'FontName',fonttype.text,'FontSize',fontsize.text);
set(handles.tDNob,'Units','normalized','Position',[0.05,0.6,dx2,dy1]);
set(handles.tDNob,'String','Разрешение объемных ДН','HorizontalAlignment','left');
set(handles.tDNob,'FontName',fonttype.text,'FontSize',fontsize.text);
set(handles.tmap,'Units','normalized','Position',[0.05,0.46-0.07/2,dx2,dy1]);
set(handles.tmap,'String','Настройка карты','HorizontalAlignment','left');
set(handles.tmap,'FontName',fonttype.text,'FontSize',fontsize.text);
set(handles.tcvet,'Units','normalized','Position',[0.35,0.53,dx2,dy1]);
set(handles.tcvet,'String','Цветовое разделение стран','HorizontalAlignment','left');
set(handles.tcvet,'FontName',fonttype.text,'FontSize',fontsize.text);
set(handles.tcities,'Units','normalized','Position',[0.35,0.46,dx2,dy1]);
set(handles.tcities,'String','Города','HorizontalAlignment','left');
set(handles.tcities,'FontName',fonttype.text,'FontSize',fontsize.text);
set(handles.trivers,'Units','normalized','Position',[0.35,0.39,dx2,dy1]);
set(handles.trivers,'String','Реки','HorizontalAlignment','left');
set(handles.trivers,'FontName',fonttype.text,'FontSize',fontsize.text);
set(handles.tlakes,'Units','normalized','Position',[0.35,0.32,dx2,dy1]);
set(handles.tlakes,'String','Озера','HorizontalAlignment','left');
set(handles.tlakes,'FontName',fonttype.text,'FontSize',fontsize.text);

set(handles.edgraph,'Units','normalized','Position',[0.85,0.88,dx1,dy1]);
set(handles.edgraph,'String',num2str(handles.preferences.GraphWidth),'HorizontalAlignment','center');
set(handles.edgraph,'FontName',fonttype.text,'FontSize',fontsize.text);
set(handles.edcontour,'Units','normalized','Position',[0.85,0.81,dx1,dy1]);
set(handles.edcontour,'String',num2str(handles.preferences.Karta.ContourWidth),'HorizontalAlignment','center');
set(handles.edcontour,'FontName',fonttype.text,'FontSize',fontsize.text);
set(handles.edaxant,'Units','normalized','Position',[0.85,0.74,dx1,dy1]);
set(handles.edaxant,'String',num2str(handles.preferences.tol.ax3Dant),'HorizontalAlignment','center');
set(handles.edaxant,'FontName',fonttype.text,'FontSize',fontsize.text);
set(handles.edDN,'Units','normalized','Position',[0.85,0.67,dx1,dy1]);
set(handles.edDN,'String',num2str(handles.preferences.tol.DNotobr),'HorizontalAlignment','center');
set(handles.edDN,'FontName',fonttype.text,'FontSize',fontsize.text);
set(handles.edDNob,'Units','normalized','Position',[0.85,0.6,dx1,dy1]);
set(handles.edDNob,'String',num2str(handles.preferences.tol.DNotobr3D),'HorizontalAlignment','center');
set(handles.edDNob,'FontName',fonttype.text,'FontSize',fontsize.text)

set(handles.cbcvet,'Units','normalized','Position',[0.85,0.53,dx1,dy1]);
set(handles.cbcvet,'String','','Value',handles.preferences.Karta.MapConfig(1));
set(handles.cbcities,'Units','normalized','Position',[0.85,0.46,dx1,dy1]);
set(handles.cbcities,'String','','Value',handles.preferences.Karta.MapConfig(2));
set(handles.cbrivers,'Units','normalized','Position',[0.85,0.39,dx1,dy1]);
set(handles.cbrivers,'String','','Value',handles.preferences.Karta.MapConfig(3));
set(handles.cblakes,'Units','normalized','Position',[0.85,0.32,dx1,dy1]);
set(handles.cblakes,'String','','Value',handles.preferences.Karta.MapConfig(4));

set(handles.uipotobr,'Visible','off');
function handles=StartUParam(handles)
uipanelwidth=0.98;
uipanelheight=0.84;
uipanelx=0.01;
uipanely=0.09;
togglebwidth=0.19;
togglebheight=0.07;
fonttype.buttons=handles.preferences.fonttype.buttons;
fonttype.subpanel=handles.preferences.fonttype.subpanel;
fonttype.text=handles.preferences.fonttype.text;
fontsize.buttons=handles.preferences.fontsize.buttons;
fontsize.subpanel=handles.preferences.fontsize.subpanel;
fontsize.text=handles.preferences.fontsize.text;
set(handles.uipparam,'Units','normalized','Position',[uipanelx,uipanely,uipanelwidth,uipanelheight]);
set(handles.uipparam,'BackgroundColor',handles.preferences.color.panel);
set(handles.uipparam,'Title','Настройка параметров расчета','TitlePosition','righttop');
set(handles.uipparam,'FontName',fonttype.subpanel,'FontSize',fontsize.subpanel);
%|||----------------------tbgeometr--------------------------------
set(handles.pbparam,'BackgroundColor',handles.preferences.color.tabs(1,:));
set(handles.pbparam,'Units','normalized','Position',[0.58,0.93,togglebwidth,togglebheight]);
set(handles.pbparam,'String','Расчет');
set(handles.pbparam,'FontName',fonttype.buttons,'FontSize',fontsize.buttons);

dx1=0.1;dy1=0.07;dx2=0.3;

set(handles.tfncP,'Units','normalized','Position',[0.05,0.88,dx2,dy1]);
set(handles.tfncP,'String','Функция расчета поля','HorizontalAlignment','left');
set(handles.tfncP,'FontName',fonttype.text,'FontSize',fontsize.text,'Visible','off');
set(handles.tfncD,'Units','normalized','Position',[0.05,0.81,dx2,dy1]);
set(handles.tfncD,'String','Функция расчета диаграмм','HorizontalAlignment','left');
set(handles.tfncD,'FontName',fonttype.text,'FontSize',fontsize.text,'Visible','off');
set(handles.tacurP,'Units','normalized','Position',[0.05,0.88,dx2,dy1]);
set(handles.tacurP,'String','Точность расчета поля','HorizontalAlignment','left');
set(handles.tacurP,'FontName',fonttype.text,'FontSize',fontsize.text);
set(handles.tacurD,'Units','normalized','Position',[0.05,0.81,dx2,dy1]);
set(handles.tacurD,'String','Точность расчета диаграмм','HorizontalAlignment','left');
set(handles.tacurD,'FontName',fonttype.text,'FontSize',fontsize.text);
set(handles.tacurF,'Units','normalized','Position',[0.05,0.74,dx2,dy1]);
set(handles.tacurF,'String','Точность поиска уровня','HorizontalAlignment','left');
set(handles.tacurF,'FontName',fonttype.text,'FontSize',fontsize.text);
set(handles.tacurM,'Units','normalized','Position',[0.05,0.67,dx2,dy1]);
set(handles.tacurM,'String','Множитель моделирования','HorizontalAlignment','left');
set(handles.tacurM,'FontName',fonttype.text,'FontSize',fontsize.text);
set(handles.tacurA,'Units','normalized','Position',[0.05,0.6,dx2,dy1]);
set(handles.tacurA,'String','Множитель анализа','HorizontalAlignment','left');
set(handles.tacurA,'FontName',fonttype.text,'FontSize',fontsize.text);
set(handles.tpikM,'Units','normalized','Position',[0.05,0.53,dx2,dy1]);
set(handles.tpikM,'String','Множитель пиков','HorizontalAlignment','left');
set(handles.tpikM,'FontName',fonttype.text,'FontSize',fontsize.text);
set(handles.tsigS,'Units','normalized','Position',[0.05,0.46,dx2,dy1]);
set(handles.tsigS,'String','Множитель угла поворота','HorizontalAlignment','left');
set(handles.tsigS,'FontName',fonttype.text,'FontSize',fontsize.text);
set(handles.tporog,'Units','normalized','Position',[0.05,0.39,dx2,dy1]);
set(handles.tporog,'String','Порог целевой функции','HorizontalAlignment','left');
set(handles.tporog,'FontName',fonttype.text,'FontSize',fontsize.text);
set(handles.tfncPdata,'Units','normalized','Position',[0.35,0.88,dx2,dy1]);
set(handles.tfncPdata,'String','Озера','HorizontalAlignment','left');
set(handles.tfncPdata,'FontName',fonttype.text,'FontSize',fontsize.text,'Visible','off');
set(handles.tfncDdata,'Units','normalized','Position',[0.35,0.81,dx2,dy1]);
set(handles.tfncDdata,'String','Озера','HorizontalAlignment','left');
set(handles.tfncDdata,'FontName',fonttype.text,'FontSize',fontsize.text,'Visible','off');

set(handles.pbfncP,'Visible','off');
set(handles.pbfncD,'Visible','off');

set(handles.edacurP,'Units','normalized','Position',[0.85,0.88,dx1,dy1]);
set(handles.edacurP,'String',num2str(handles.preferences.tol.pole),'HorizontalAlignment','center');
set(handles.edacurP,'FontName',fonttype.text,'FontSize',fontsize.text);
set(handles.edacurD,'Units','normalized','Position',[0.85,0.81,dx1,dy1]);
set(handles.edacurD,'String',num2str(handles.preferences.tol.findPSI.Nglotsch),'HorizontalAlignment','center');
set(handles.edacurD,'FontName',fonttype.text,'FontSize',fontsize.text);
set(handles.edacurF,'Units','normalized','Position',[0.85,0.74,dx1,dy1]);
set(handles.edacurF,'String',num2str(handles.preferences.tol.findPSI.level),'HorizontalAlignment','center');
set(handles.edacurF,'FontName',fonttype.text,'FontSize',fontsize.text);
set(handles.edacurM,'Units','normalized','Position',[0.85,0.67,dx1,dy1]);
set(handles.edacurM,'String',num2str(handles.preferences.Karta.Ntochek),'HorizontalAlignment','center');
set(handles.edacurM,'FontName',fonttype.text,'FontSize',fontsize.text);
set(handles.edacurA,'Units','normalized','Position',[0.85,0.6,dx1,dy1]);
set(handles.edacurA,'String',num2str(handles.preferences.Karta.Ntochek1),'HorizontalAlignment','center');
set(handles.edacurA,'FontName',fonttype.text,'FontSize',fontsize.text);
set(handles.edpikM,'Units','normalized','Position',[0.85,0.53,dx1,dy1]);
set(handles.edpikM,'String',num2str(handles.preferences.Karta.pikmnog),'HorizontalAlignment','center');
set(handles.edpikM,'FontName',fonttype.text,'FontSize',fontsize.text);
set(handles.edsigS,'Units','normalized','Position',[0.85,0.46,dx1,dy1]);
set(handles.edsigS,'String',num2str(handles.preferences.Karta.sigmascan),'HorizontalAlignment','center');
set(handles.edsigS,'FontName',fonttype.text,'FontSize',fontsize.text);
set(handles.edporog,'Units','normalized','Position',[0.85,0.39,dx1,dy1]);
set(handles.edporog,'String',num2str(handles.preferences.Karta.maxPPporog),'HorizontalAlignment','center');
set(handles.edporog,'FontName',fonttype.text,'FontSize',fontsize.text);

set(handles.uipparam,'Visible','off');
%--------------------------------------------------------------------------
function pbMcolor_Callback(hObject, eventdata, handles)
C=uisetcolor();
if numel(C)~=1
set(handles.pbMcolor,'BackgroundColor',C);
handles.preferences.color.MainWinC=C;
end
guidata(hObject, handles);
function pbPcolor_Callback(hObject, eventdata, handles)
C=uisetcolor();
if numel(C)~=1
set(handles.pbPcolor,'BackgroundColor',C);
handles.preferences.color.panel=C;
end
guidata(hObject, handles);
function pbSPcolor_Callback(hObject, eventdata, handles)
C=uisetcolor();
if numel(C)~=1
set(handles.pbSPcolor,'BackgroundColor',C);
handles.preferences.color.subpanel=C;
end
guidata(hObject, handles);
function pbTcolor1_Callback(hObject, eventdata, handles)
C=uisetcolor();
if numel(C)~=1
set(handles.pbTcolor1,'BackgroundColor',C);
handles.preferences.color.tabs(1,:)=C;
end
guidata(hObject, handles);
function pbTcolor2_Callback(hObject, eventdata, handles)
C=uisetcolor();
if numel(C)~=1
set(handles.pbTcolor2,'BackgroundColor',C);
handles.preferences.color.tabs(2,:)=C;
end
guidata(hObject, handles);
function pbAcolor1_Callback(hObject, eventdata, handles)
C=uisetcolor();
if numel(C)~=1
set(handles.pbAcolor1,'BackgroundColor',C);
handles.preferences.color.beactiv(1,:)=C;
end
guidata(hObject, handles);
function pbAcolor2_Callback(hObject, eventdata, handles)
C=uisetcolor();
if numel(C)~=1
set(handles.pbAcolor2,'BackgroundColor',C);
handles.preferences.color.beactiv(2,:)=C;
end
guidata(hObject, handles);
function pbIcolor_Callback(hObject, eventdata, handles)
C=uisetcolor();
if numel(C)~=1
set(handles.pbIcolor,'BackgroundColor',C);
handles.preferences.color.inaccessible=C;
end
guidata(hObject, handles);
function pbCcolor_Callback(hObject, eventdata, handles)
C=uisetcolor();
if numel(C)~=1
set(handles.pbCcolor,'BackgroundColor',C);
handles.preferences.color.cities=C;
end
guidata(hObject, handles);
function pbRcolor_Callback(hObject, eventdata, handles)
C=uisetcolor();
if numel(C)~=1
set(handles.pbRcolor,'BackgroundColor',C);
handles.preferences.color.rivers=C;
end
guidata(hObject, handles);
function pbLcolor_Callback(hObject, eventdata, handles)
C=uisetcolor();
if numel(C)~=1
set(handles.pbLcolor,'BackgroundColor',C);
handles.preferences.color.lakes=C;
end
guidata(hObject, handles);
function pbVcolor_Callback(hObject, eventdata, handles)
C=uisetcolor();
if numel(C)~=1
set(handles.pbVcolor,'BackgroundColor',C);
handles.preferences.color.VisibleZone=C;
end
guidata(hObject, handles);
function pbPolcolor1_Callback(hObject, eventdata, handles)
C=uisetcolor();
if numel(C)~=1
set(handles.pbPolcolor1,'BackgroundColor',C);
handles.preferences.color.polar(1,:)=C;
end
guidata(hObject, handles);
function pbPolcolor2_Callback(hObject, eventdata, handles)
C=uisetcolor();
if numel(C)~=1
set(handles.pbPolcolor2,'BackgroundColor',C);
handles.preferences.color.polar(2,:)=C;
end
guidata(hObject, handles);
function pbPolcolor3_Callback(hObject, eventdata, handles)
C=uisetcolor();
if numel(C)~=1
set(handles.pbPolcolor3,'BackgroundColor',C);
handles.preferences.color.polar(3,:)=C;
end
guidata(hObject, handles);
function pbPolcolor4_Callback(hObject, eventdata, handles)
C=uisetcolor();
if numel(C)~=1
set(handles.pbPolcolor4,'BackgroundColor',C);
handles.preferences.color.polar(4,:)=C;
end
guidata(hObject, handles);
%--------------------------------------------------------------------------
function pbbut_Callback(hObject, eventdata, handles)
data=uisetfont();
if isstruct(data)
    handles.preferences.fonttype.buttons=data.FontName;
    handles.preferences.fontsize.buttons=data.FontSize;
    set(handles.tbutC,'String',strcat(handles.preferences.fonttype.buttons,'__',...
    num2str(handles.preferences.fontsize.buttons)),'HorizontalAlignment','center');
end
guidata(hObject, handles);
function pbsubp_Callback(hObject, eventdata, handles)
data=uisetfont();
if isstruct(data)
    handles.preferences.fonttype.subpanel=data.FontName;
    handles.preferences.fontsize.subpanel=data.FontSize;
    set(handles.tsubpC,'String',strcat(handles.preferences.fonttype.subpanel,'__',...
    num2str(handles.preferences.fontsize.subpanel)),'HorizontalAlignment','center');
end
guidata(hObject, handles);
function pbax_Callback(hObject, eventdata, handles)
data=uisetfont();
if isstruct(data)
    handles.preferences.fonttype.axes=data.FontName;
    handles.preferences.fontsize.axes=data.FontSize;
    set(handles.taxC,'String',strcat(handles.preferences.fonttype.axes,'__',...
    num2str(handles.preferences.fontsize.axes)),'HorizontalAlignment','center');
end
guidata(hObject, handles);
function pbtxt_Callback(hObject, eventdata, handles)
data=uisetfont();
if isstruct(data)
    handles.preferences.fonttype.text=data.FontName;
    handles.preferences.fontsize.text=data.FontSize;
    set(handles.ttxtC,'String',strcat(handles.preferences.fonttype.text,'__',...
    num2str(handles.preferences.fontsize.text)),'HorizontalAlignment','center');
end
guidata(hObject, handles);
function pbmatr_Callback(hObject, eventdata, handles)
data=uisetfont();
if isstruct(data)
    handles.preferences.fonttype.matrix=data.FontName;
    handles.preferences.fontsize.matrix=data.FontSize;
    set(handles.tmatrC,'String',strcat(handles.preferences.fonttype.matrix,'__',...
    num2str(handles.preferences.fontsize.matrix)),'HorizontalAlignment','center');
end
guidata(hObject, handles);
%--------------------------------------------------------------------------
function edgraph_Callback(hObject, eventdata, handles)
temp=str2double(get(hObject,'String'));
if ~isnan(temp)
    if temp>=0
        handles.preferences.GraphWidth=temp;
    else
        errordlg('Толщина линий должна быть больше 0','Ошибка');
    end
end
guidata(hObject, handles);
function edgraph_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function edcontour_Callback(hObject, eventdata, handles)
temp=str2double(get(hObject,'String'));
if ~isnan(temp)
    if temp>=0
        handles.preferences.Karta.ContourWidth=temp;
    else
        errordlg('Толщина линий должна быть больше 0','Ошибка');
    end
end
guidata(hObject, handles);
function edcontour_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function edaxant_Callback(hObject, eventdata, handles)
temp=str2double(get(hObject,'String'));
if ~isnan(temp)
    if temp>=0
        handles.preferences.tol.ax3Dant=temp;
    else
        errordlg('Величина разрешения не может быть меньше 0','Ошибка');
    end
end
guidata(hObject, handles);
function edaxant_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function edDN_Callback(hObject, eventdata, handles)
temp=str2double(get(hObject,'String'));
if ~isnan(temp)
    if temp>=0
        handles.preferences.tol.DNotobr=temp;
    else
        errordlg('Величина разрешения не может быть меньше 0','Ошибка');
    end
end
guidata(hObject, handles);
function edDN_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function edDNob_Callback(hObject, eventdata, handles)
temp=str2double(get(hObject,'String'));
if ~isnan(temp)
    if temp>=0
        handles.preferences.tol.DNotobr3D=temp;
    else
        errordlg('Величина разрешения не может быть меньше 0','Ошибка');
    end
end
guidata(hObject, handles);
function edDNob_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function cbcvet_Callback(hObject, eventdata, handles)
temp=get(hObject,'Value');
handles.preferences.Karta.MapConfig(1)=temp;
guidata(hObject, handles);
function cbcities_Callback(hObject, eventdata, handles)
temp=get(hObject,'Value');
handles.preferences.Karta.MapConfig(2)=temp;
guidata(hObject, handles);
function cbrivers_Callback(hObject, eventdata, handles)
temp=get(hObject,'Value');
handles.preferences.Karta.MapConfig(3)=temp;
guidata(hObject, handles);
function cblakes_Callback(hObject, eventdata, handles)
temp=get(hObject,'Value');
handles.preferences.Karta.MapConfig(4)=temp;
guidata(hObject, handles);
%--------------------------------------------------------------------------
function pbfncP_Callback(hObject, eventdata, handles)
function pbfncD_Callback(hObject, eventdata, handles)
function edacurP_Callback(hObject, eventdata, handles)
temp=str2double(get(hObject,'String'));
if ~isnan(temp)
    if temp>=0
        handles.preferences.tol.pole=temp;
    else
        errordlg('Величина разрешения не может быть меньше 0','Ошибка');
    end
end
guidata(hObject, handles);
function edacurP_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function edacurD_Callback(hObject, eventdata, handles)
temp=str2double(get(hObject,'String'));
if ~isnan(temp)
    if temp>=0
        handles.preferences.tol.findPSI.Nglotsch=temp;
    else
        errordlg('Величина разрешения не может быть меньше 0','Ошибка');
    end
end
guidata(hObject, handles);
function edacurD_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function edacurF_Callback(hObject, eventdata, handles)
temp=str2double(get(hObject,'String'));
if ~isnan(temp)
    if temp>=0&&temp<=1
        handles.preferences.tol.findPSI.level=temp;
    else
        errordlg('Точность поиска уровня принадлежит от 0 до 1','Ошибка');
    end
end
guidata(hObject, handles);
function edacurF_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function edacurM_Callback(hObject, eventdata, handles)
temp=str2double(get(hObject,'String'));
if ~isnan(temp)
    if temp>=0
        handles.preferences.Karta.Ntochek=temp;
    else
        errordlg('Величина разрешения не может быть меньше 0','Ошибка');
    end
end
guidata(hObject, handles);
function edacurM_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function edacurA_Callback(hObject, eventdata, handles)
temp=str2double(get(hObject,'String'));
if ~isnan(temp)
    if temp>=0
        handles.preferences.Karta.Ntochek1=temp;
    else
        errordlg('Величина разрешения не может быть меньше 0','Ошибка');
    end
end
guidata(hObject, handles);
function edacurA_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function edpikM_Callback(hObject, eventdata, handles)
temp=str2double(get(hObject,'String'));
if ~isnan(temp)
    if temp>=0
        handles.preferences.Karta.pikmnog=temp;
    else
        errordlg('Величина разрешения не может быть меньше 0','Ошибка');
    end
end
guidata(hObject, handles);
function edpikM_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function edsigS_Callback(hObject, eventdata, handles)
temp=str2double(get(hObject,'String'));
if ~isnan(temp)
    if temp>=0
        handles.preferences.Karta.sigmascan=temp;
    else
        errordlg('Величина разрешения не может быть меньше 0','Ошибка');
    end
end
guidata(hObject, handles);
function edsigS_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function edporog_Callback(hObject, eventdata, handles)
temp=str2double(get(hObject,'String'));
if ~isnan(temp)
    if temp>=0
        handles.preferences.Karta.maxPPporog=temp;
    else
        errordlg('Величина порога целевой функции принадлежит от 0 до 1','Ошибка');
    end
end
guidata(hObject, handles);
function edporog_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
