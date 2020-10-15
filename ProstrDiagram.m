function varargout = ProstrDiagram(varargin)
% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ProstrDiagram_OpeningFcn, ...
                   'gui_OutputFcn',  @ProstrDiagram_OutputFcn, ...
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


% --- Executes just before ProstrDiagram is made visible.
function ProstrDiagram_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
handles.antenna=varargin{1};
handles.preferences=varargin{2};
handles=StartUP(handles);
guidata(hObject, handles);

% --- Outputs from this function are returned to the command line.
function varargout = ProstrDiagram_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
handles.system.selected=1;
handles.system.choseDN=get(hObject,'Value');
handles=DNplot(handles);
guidata(hObject, handles);
function pushbutton1_Callback(hObject, eventdata, handles)
handles.system.tipDN=mod(handles.system.tipDN+1,2);
if handles.system.tipDN
    set(handles.pushbutton1,'String','Нормированная');
else
    set(handles.pushbutton1,'String','дБ');
end
if handles.system.selected
    handles=DNplot(handles);
end
guidata(hObject, handles);
function popupmenu1_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function edit1_Callback(hObject, eventdata, handles)
temp=str2double(get(handles.edit1,'String'));
if isnan(temp)
    errordlg('Не является числом','Ошибка');
elseif ~isnan(temp)&&temp<0
    errordlg('Радиус отображения принадлежит [0;18]','Ошибка');
elseif ~isnan(temp)&&temp>0
    if temp>18
        errordlg('Радиус отображения принадлежит [0;18]','Ошибка');
    else
        handles.system.diapazon=temp*pi/180;
        if handles.system.selected
            handles=DNplot(handles);
        end
    end
end
guidata(hObject, handles);
% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function handles=StartUP(handles)
handles.system.tipDN=0;%0 - normal; 1 - dec
handles.system.choseDN=0;
handles.system.selected=0;
handles.system.diapazon=0.1*pi/2;
set(gcf,'Units','normalized');
set(handles.axes1,'Units','normalized','Position',[0.1 0.1 0.8 0.7]);
delete(allchild(handles.axes1));
set(handles.pushbutton1,'Units','normalized','Position',[0.7 0.9 0.2 0.05]);
set(handles.pushbutton1,'String','дБ');
set(handles.popupmenu1,'Units','normalized','Position',[0.1 0.85 0.55 0.1]);
set(handles.text1,'Units','normalized','Position',[0.4 0.83 0.3 0.05]);
set(handles.text1,'String','Радиус отобраажения (град):');
set(handles.edit1,'Units','normalized','Position',[0.7 0.83 0.2 0.05]);
set(handles.edit1,'String','9');
handles=GetStat(handles);
set(handles.popupmenu1,'String',handles.system.String);
function handles=GetStat(handles)
n=numel(handles.antenna.klaster);
schet=0;
for i=1:n
    for j=1:4
        if handles.antenna.System.DNotobr(i).DNinit(j)
            schet=schet+1;
        end
    end
end
number=schet;
schet=1;
Stat=zeros(schet,2);
String=cell(schet,1);
for i=1:n
    for j=1:4
        if handles.antenna.System.DNotobr(i).DNinit(j)
            Stat(schet,1)=i;
            Stat(schet,2)=j;
            schet=schet+1;
        end
    end
end
for i=1:number
    String{i}=strcat('IZL №:',num2str(Stat(i,1)),';X:',num2str(handles.antenna.klaster(Stat(i,1)).X),...
        ';Y:',num2str(handles.antenna.klaster(Stat(i,1)).Y),...
        ';Polar:',handles.antenna.DN(Stat(i,1)).Diagram(Stat(i,2)).parametrs.Polar,...
        ';Frequency:',num2str(handles.antenna.DN(Stat(i,1)).Diagram(Stat(i,2)).parametrs.Frequency));
end
handles.system.number=number;
handles.system.Stat=Stat;
handles.system.String=String;
function handles=DNplot(handles)
axes(handles.axes1);
TH=linspace(-handles.system.diapazon,handles.system.diapazon,handles.preferences.tol.DNotobr3D);
[THL,THT]=meshgrid(TH);
num=handles.system.choseDN;
num1=handles.system.Stat(num,1);
num2=handles.system.Stat(num,2);
stkX=handles.antenna.DN(num1).Diagram(num2).DiagramSTK.ProstrX;
stkY=handles.antenna.DN(num1).Diagram(num2).DiagramSTK.ProstrY;
data=handles.antenna.DN(num1).Diagram(num2).Prostr;
Ga=handles.antenna.DN(num1).Diagram(num2).parametrs.Ga;
data=20*log10(data);
    data=data+Ga;
if ~handles.system.tipDN
    data=data/20;
    data=10.^(data);
end
RES=interp2(stkX,stkY,data,THL,THT);
RES=Rechange(THL,THT,RES,handles.system.diapazon);
mesh(THL,THT,RES);
xlabel('ThethaL');
ylabel('ThethaT');
function res=Rechange(THL,THT,RES,ogranichenie)
TH=Thethafromstk(THL,THT);
A=ogranichenie-TH;
res=RES;
res(find(A<0))= NaN; %#ok<FNDSB>
function res=Thethafromstk(stkL,stkT)
    fi=atan(tan(stkT)./tan(stkL));
    fi(find(stkL<0))=fi(find(stkL<0))+pi; %#ok<FNDSB>
    th=atan(tan(stkL)./cos(fi));
    th(find(stkL==0))=abs(stkT(find(stkL==0))); %#ok<FNDSB>
    res=th;
