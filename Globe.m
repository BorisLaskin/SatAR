function varargout = Globe(varargin)
% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Globe_OpeningFcn, ...
                   'gui_OutputFcn',  @Globe_OutputFcn, ...
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


% --- Executes just before Globe is made visible.
function Globe_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
handles.antenna=varargin{1};
handles.preferences=varargin{2};
handles=StartUP(handles);
guidata(hObject, handles);

% UIWAIT makes Globe wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Globe_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;


% --- Executes on button press in checkbox1.
function checkbox1_Callback(hObject, eventdata, handles)
handles.flags(1)=get(hObject,'Value');
guidata(hObject, handles);
function checkbox2_Callback(hObject, eventdata, handles)
handles.flags(2)=get(hObject,'Value');
guidata(hObject, handles);
function checkbox3_Callback(hObject, eventdata, handles)
function handles=StartUP(handles)
%set(handles.figure1,'Renderer','painters');
set(handles.figure1,'Renderer','zbuffer');
%set(handles.figure1,'Renderer','OpenGL');
%set(handles.figure1,'Renderer','None');
dx=0.4;dy=0.05;
set(gcf,'Units','normalized');
handles.flags=[0 0];
set(handles.axes1,'Units','normalized','Position',[0.1 0.1 0.8 0.7]);
delete(allchild(handles.axes1));
set(handles.checkbox1,'Units','normalized','Position',[0.1 0.9 dx dy]);
set(handles.checkbox1,'String','Заполнение контура','Visible','off');
set(handles.checkbox2,'Units','normalized','Position',[0.1 0.85 dx dy]);
set(handles.checkbox2,'String','Номера и Ga','Visible','off');
set(handles.checkbox3,'String','Учет трассы','Visible','off');
handles.KartaObj.Luch=[];
axes(handles.axes1);
grs80 = handles.preferences.Karta.grs80;
ax = axesm('globe','Geoid',grs80,'Grid','on', ...
    'GLineWidth',1,'GLineStyle','-',...
    'Gcolor',[0.9 0.9 0.1],'Galtitude',100);
view(90+handles.antenna.System.navparam.muka,0);
axis equal off;
try
    thisdir=cd;
    cd('MapData');
    load topo1;
    cd(thisdir);
catch
    cd(thisdir);
    string=lasterr;
    errordlg(string,'Ошибка');
end
geoshow(topo,topolegend,'DisplayType','texturemap');
demcmap(topo);
thisdir=cd;
cd('MapData');
%-------------inicialize-----------------------------------------
load coast1;
load worldlo1;
%-------------inicialize_end----------------------------------------- 
cd(thisdir);
h=geoshow(lat,long);
set(h,'Color','black');
h=geoshow(POline(1).lat,POline(1).long);
set(h,'Color','black');
handles=PutOnMap(handles);
function handles=PutOnMap(handles)
list2={'F1T','F1L','F2T','F2L'};
n=numel(handles.antenna.klaster);
if numel(handles.KartaObj.Luch)~=0
    delete(handles.KartaObj.Luch);
end
handles.KartaObj.Luch=[];
for i=1:n
    string=strcat(handles.antenna.klaster(i).frequency,handles.antenna.klaster(i).polarization);
        ind2=find(strcmp(list2,string));
    handles.KartaObj.Luch(i)=LevelOnTheMap(handles,...
        handles.antenna.System.Contour.DN(i).Contour,handles.preferences.color.polar(ind2,:)); %#ok<FNDSB>
    if ~strcmp(handles.antenna.klaster(i).beactiv,'on')
        set(handles.KartaObj.Luch(i),'Visible','off');
    else
        set(handles.KartaObj.Luch(i),'Visible','on');
    end
end
    
function h=LevelOnTheMap(handles,Matrix,color)
axes(handles.axes1);
limit = size(Matrix, 2);
i = 1;
h = [];
hg=hggroup;
if limit~=0
    while (i < limit)
        npoints = Matrix(2, i);
        nexti = i + npoints + 1;
        xdata = Matrix(1, i + 1 : i + npoints);
        ydata = Matrix(2, i + 1 : i + npoints);
        % Create the patches or lines
        cu = geoshow(ydata, xdata);
        set(cu,'Color','red');
        set(cu, 'Parent', hg,'LineWidth',handles.preferences.Karta.ContourWidth);
        set(cu,'Clipping','on');
        i = nexti;
    end
end
h=hg;