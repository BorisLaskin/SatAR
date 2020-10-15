function varargout = mainfigure(varargin)
% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @mainfigure_OpeningFcn, ...
                   'gui_OutputFcn',  @mainfigure_OutputFcn, ...
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
% --- Executes just before mainfigure is made visible.
function mainfigure_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
guidata(hObject, handles);
handles=StartUpFcn(handles);
tbgeometr_Callback(hObject, eventdata, handles);
handles=guidata(hObject);
guidata(hObject, handles);

% --- Outputs from this function are returned to the command line.
function varargout = mainfigure_OutputFcn(hObject, eventdata, handles)  %#ok<*INUSL>
varargout{1} = handles.output;

%------------------------CALLBACKS----------------------------------------
function tbgeometr_Callback(hObject, eventdata, handles)%done
if ~handles.IsBusy
handles.Tabs.visible.flags=[1 0 0 0 0 0];
handles=ChangeTab(handles);
if ~handles.Tabs.drawedflags(1)
    if handles.antenna.initflags(1)
        Geomplot(hObject, eventdata,handles);
        handles=guidata(hObject);
    end
end
end
guidata(hObject, handles);
function tbklaster_Callback(hObject, eventdata, handles)%done
if ~handles.IsBusy
handles.Tabs.visible.flags=[0 1 0 0 0 0];
handles=ChangeTab(handles);
if(~handles.Tabs.drawedflags(2))
    handles=ClearKlaster(handles);
    if(handles.antenna.initflags(2))
        Klasterplot(hObject, eventdata,handles);
        handles=guidata(hObject);
    end
end
end
guidata(hObject, handles);
function tbpolar_Callback(hObject, eventdata, handles)%done
if ~handles.IsBusy
handles.Tabs.visible.flags=[0 0 1 0 0 0];
handles=ChangeTab(handles);
if(~handles.Tabs.drawedflags(3))
    handles=ClearPolar(handles);
    if(handles.antenna.initflags(3))
        Polarplot(hObject, eventdata,handles);
        handles=guidata(hObject);
        handles.Tabs.toredrawed(1)=0;
    end
elseif handles.Tabs.toredrawed(1)
    handles=APPOplot(handles);
    n=numel(handles.antenna.klaster);
    for i=1:n
        if strcmp(handles.antenna.klaster(i).beactiv,'on')
            dataactiv{i}=logical(1); %#ok<*LOGL,*AGROW>
        elseif strcmp(handles.antenna.klaster(i).beactiv,'off')
            dataactiv{i}=logical(0);
        end
    end
    set(handles.uiton_off,'Data',[dataactiv']); %#ok<*NBRAK>
    handles.Tabs.toredrawed(1)=0;
end
end
guidata(hObject, handles);
function tbdn_Callback(hObject, eventdata, handles)%done
if ~handles.IsBusy
handles.Tabs.visible.flags=[0 0 0 1 0 0];
handles=ChangeTab(handles);
if(~handles.Tabs.drawedflags(4))
    handles=ClearDN(handles);
    DNplot(hObject, eventdata, handles);
    handles=guidata(hObject);
end
end
guidata(hObject, handles);
function tbtrace_Callback(hObject, eventdata, handles)
handles.Tabs.visible.flags=[0 0 0 0 1 0];
handles=ChangeTab(handles);
guidata(hObject, handles);
function tbkarta_Callback(hObject, eventdata, handles)%done
if ~handles.IsBusy
handles.Tabs.visible.flags=[0 0 0 0 0 1];
handles=ChangeTab(handles);
if(~handles.Tabs.drawedflags(6))
    handles=ClearKarta(handles);
    Kartaplot(hObject, eventdata,handles);
    handles=guidata(hObject);
    handles.Tabs.toredrawed(2)=0;
elseif handles.Tabs.toredrawed(2)
    handles.Tabs.toredrawed(2)=0;
    handles=APKartaOplot(handles);
end
end
guidata(hObject, handles);

%----------------------VKLADKA_GEOMETR--------------------------------
function popupmpolar_Callback(hObject, eventdata, handles)%done
if ~handles.IsBusy
handles.Tabs.chosepolar=get(hObject,'Value');
handles=RaspredPlot(handles,handles.Tabs.chosepolar);
end
guidata(hObject, handles);
function pbparhelp_Callback(hObject, eventdata, handles) %#ok<*INUSD>
function pbantoptim_Callback(hObject, eventdata, handles)%zablokirovanno
if 0
if numel(handles.Optim.D)>0
    if (handles.Optim.D(1)~=handles.antenna.allparam.D)|(handles.Optim.C(1)~=handles.antenna.allparam.C)|...
        (handles.Optim.F(1)~=handles.antenna.allparam.F)|(handles.Optim.alfa0(1)~=handles.antenna.allparam.alfa0)|...
        (handles.Optim.R0(1)~=handles.antenna.allparam.R0)|(handles.Optim.kip(1)~=handles.antenna.allparam.kip) %#ok<*OR2>
        
        handles.Optim.D=[handles.antenna.allparam.D,handles.Optim.D];
        handles.Optim.C=[handles.antenna.allparam.C,handles.Optim.C];
        handles.Optim.F=[handles.antenna.allparam.F,handles.Optim.F];
        handles.Optim.alfa0=[handles.antenna.allparam.alfa0,handles.Optim.alfa0];
        handles.Optim.R0=[handles.antenna.allparam.R0,handles.Optim.R0];
        handles.Optim.n=[handles.antenna.allparam.n,handles.Optim.n];
        handles.Optim.v=[handles.antenna.allparam.v,handles.Optim.v];
        handles.Optim.kip=[handles.antenna.allparam.kip,handles.Optim.kip];
    end
elseif handles.antenna.initflags(1)==1
    handles.Optim.D=[handles.antenna.allparam.D];
    handles.Optim.C=[handles.antenna.allparam.C];
    handles.Optim.F=[handles.antenna.allparam.F];
    handles.Optim.alfa0=[handles.antenna.allparam.alfa0];
    handles.Optim.R0=[handles.antenna.allparam.R0];
    handles.Optim.n=[handles.antenna.allparam.n];
    handles.Optim.v=[handles.antenna.allparam.v];
    handles.Optim.kip=[handles.antenna.allparam.kip];
end
if handles.antenna.initflags(1)==1
    [handles.antenna,handles.preferences,handles.Optim]=optimize(handles.antenna,handles.preferences,handles.Optim);
    Geomplot(hObject, eventdata,handles);
    handles=guidata(hObject);
end
end
guidata(hObject, handles);
function edD_Callback(hObject, eventdata, handles)%done
if ~handles.IsBusy
handles.antenna.baseparam.D=str2double(get(hObject,'String'));
if ~isnan(handles.antenna.baseparam.D)
    if handles.antenna.baseparam.D>0
        handles.antenna.paramflags(1)=1;
        if handles.antenna.paramflags
            GeomRaschet(hObject, eventdata,handles);
            handles=guidata(hObject);
        end
    else
        string=('D ������ ���� ������ ����');
        dlg=dialog('WindowStyle', 'normal', 'Name', '������','Units','normalized','Position',[0.4 0.5 0.2 0.1]);
        dlgstart(dlg,string);
    end
else
    handles.antenna.paramflags(1)=0;
end
else
    if ~isnan(handles.antenna.baseparam.D)
        set(handles.edF2,'String',num2str(handles.antenna.baseparam.D));
    end
end
guidata(hObject, handles);
function edC_Callback(hObject, eventdata, handles)%done
if ~handles.IsBusy
handles.antenna.baseparam.C=str2double(get(hObject,'String'));
if ~isnan(handles.antenna.baseparam.C)
    if handles.antenna.baseparam.C>0
        handles.antenna.paramflags(2)=1;
        if handles.antenna.paramflags
            GeomRaschet(hObject, eventdata,handles);
            handles=guidata(hObject);
        end
    else
        string=('C ������ ���� ������ ���� ��� ������ ���� "�����"');
        dlg=dialog('WindowStyle', 'normal', 'Name', '������','Units','normalized','Position',[0.4 0.5 0.2 0.1]);
        dlgstart(dlg,string);
    end
else
    handles.antenna.paramflags(2)=0;
end
else
    if ~isnan(handles.antenna.baseparam.C)
        set(handles.edF2,'String',num2str(handles.antenna.baseparam.C));
    end
end
guidata(hObject, handles);
function edF_Callback(hObject, eventdata, handles)%done
if ~handles.IsBusy
handles.antenna.baseparam.F=str2double(get(hObject,'String'));
if ~isnan(handles.antenna.baseparam.F)
    if handles.antenna.baseparam.F>0
        handles.antenna.paramflags(3)=1;
        if handles.antenna.paramflags
            GeomRaschet(hObject, eventdata,handles);
            handles=guidata(hObject);
        end
    else
        string=('F ������ ���� ������ ����');
        dlg=dialog('WindowStyle', 'normal', 'Name', '������','Units','normalized','Position',[0.4 0.5 0.2 0.1]);
        dlgstart(dlg,string);
    end
else
    handles.antenna.paramflags(3)=0;
end
else
    if ~isnan(handles.antenna.baseparam.F)
        set(handles.edF2,'String',num2str(handles.antenna.baseparam.F));
    end
end
guidata(hObject, handles);
function edalfa0_Callback(hObject, eventdata, handles)%done
if ~handles.IsBusy
handles.antenna.baseparam.alfa0=str2double(get(hObject,'String'));
if ~isnan(handles.antenna.baseparam.alfa0)
    handles.antenna.paramflags(4)=1;
    if handles.antenna.paramflags
        GeomRaschet(hObject, eventdata,handles);
        handles=guidata(hObject);
    end
else
    handles.antenna.paramflags(4)=0;
end
else
    if ~isnan(handles.antenna.baseparam.alfa0)
        set(handles.edF2,'String',num2str(handles.antenna.baseparam.alfa0));
    end
end
guidata(hObject, handles);
function edR0_Callback(hObject, eventdata, handles)%done
if ~handles.IsBusy
handles.antenna.baseparam.R0=str2double(get(hObject,'String'));
if ~isnan(handles.antenna.baseparam.R0)
    if handles.antenna.baseparam.R0>0
        handles.antenna.paramflags(5)=1;
        if handles.antenna.paramflags
            GeomRaschet(hObject, eventdata,handles);
            handles=guidata(hObject);
        end
    else
        string=('R0 ������ ���� ������ ����');
        dlg=dialog('WindowStyle', 'normal', 'Name', '������','Units','normalized','Position',[0.4 0.5 0.2 0.1]);
        dlgstart(dlg,string);
    end
else
    handles.antenna.paramflags(5)=0;
end
else
    if ~isnan(handles.antenna.baseparam.R0)
        set(handles.edF2,'String',num2str(handles.antenna.baseparam.R0));
    end
end
guidata(hObject, handles);
function edF1_Callback(hObject, eventdata, handles)%done
if ~handles.IsBusy
handles.antenna.baseparam.F1=str2double(get(hObject,'String'));
if ~isnan(handles.antenna.baseparam.F1)
    if handles.antenna.baseparam.F1>0&&handles.antenna.baseparam.F1<=40
        if handles.antenna.paramflags(7)
            if abs(handles.antenna.baseparam.F1-handles.antenna.baseparam.F2)>0.25
                handles.antenna.paramflags(6)=1;
                if handles.antenna.paramflags
                    GeomRaschet(hObject, eventdata,handles);
                    handles=guidata(hObject);
                end
            else
                string=('������ ������ ������ ���� ������ 0.25 ���');
                dlg=dialog('WindowStyle', 'normal', 'Name', '������','Units','normalized','Position',[0.4 0.5 0.2 0.1]);
                dlgstart(dlg,string);
            end
        else
            handles.antenna.paramflags(6)=1;
            if handles.antenna.paramflags
                GeomRaschet(hObject, eventdata,handles);
                handles=guidata(hObject);
            end
        end
    else
        string=('F1 ����������� [0;40]');
        dlg=dialog('WindowStyle', 'normal', 'Name', '������','Units','normalized','Position',[0.4 0.5 0.2 0.1]);
        dlgstart(dlg,string);
    end
else
    handles.antenna.paramflags(6)=0;
end
else
    if ~isnan(handles.antenna.baseparam.F1)
        set(handles.edF2,'String',num2str(handles.antenna.baseparam.F1));
    end
end
guidata(hObject, handles);
function edF2_Callback(hObject, eventdata, handles)%done
if ~handles.IsBusy
handles.antenna.baseparam.F2=str2double(get(hObject,'String'));
if ~isnan(handles.antenna.baseparam.F2)
    if handles.antenna.baseparam.F2>0&&handles.antenna.baseparam.F2<=40
        if handles.antenna.paramflags(6)
            if abs(handles.antenna.baseparam.F1-handles.antenna.baseparam.F2)>0.25
                handles.antenna.paramflags(7)=1;
                if handles.antenna.paramflags
                    GeomRaschet(hObject, eventdata,handles);
                    handles=guidata(hObject);
                end
            else
                string=('������ ������ ������ ���� ������ 0.25 ���');
                dlg=dialog('WindowStyle', 'normal', 'Name', '������','Units','normalized','Position',[0.4 0.5 0.2 0.1]);
                dlgstart(dlg,string);
            end
        else
            handles.antenna.paramflags(7)=1;
            if handles.antenna.paramflags
                GeomRaschet(hObject, eventdata,handles);
                handles=guidata(hObject);
            end
        end
    else
        string=('F2 ����������� [0;40]');
        dlg=dialog('WindowStyle', 'normal', 'Name', '������','Units','normalized','Position',[0.4 0.5 0.2 0.1]);
        dlgstart(dlg,string);
    end
else
    handles.antenna.paramflags(7)=0;
end
else
    if ~isnan(handles.antenna.baseparam.F2)
        set(handles.edF2,'String',num2str(handles.antenna.baseparam.F2));
    end
end
guidata(hObject, handles);
function pbopenant_Callback(hObject, eventdata, handles)
if ~handles.IsBusy
[name,dir]=uigetfile('.ant','������� ���� �������');
if name~=0
    thisdir=cd;
    cd(dir);
    handles.Tabs.drawedflags=[0 0 0 0 0 0];
    
    try
        handles.antenna=[];
        handles.antenna=load(name,'-mat');
        cd(thisdir);
     
        set(handles.edD,'String',num2str(handles.antenna.baseparam.D));
        set(handles.edC,'String',num2str(handles.antenna.baseparam.C));
        set(handles.edF,'String',num2str(handles.antenna.baseparam.F));
        set(handles.edalfa0,'String',num2str(handles.antenna.baseparam.alfa0));
        set(handles.edR0,'String',num2str(handles.antenna.baseparam.R0));
        set(handles.edF1,'String',num2str(handles.antenna.baseparam.F1));
        set(handles.edF2,'String',num2str(handles.antenna.baseparam.F2));
        Geomplot(hObject, eventdata,handles);
        handles=guidata(hObject);
        handles.antenna.initflags(1)=1;
        handles.Tabs.KLconfigChanged=0; %izmenenie dannih klastera posle rascheta
        handles.Tabs.KLconfigChangedPrint=0;
    catch
        string=('������ �������� �����, ���� ���������');
        dlg=dialog('WindowStyle', 'normal', 'Name', '������','Units','normalized','Position',[0.4 0.5 0.2 0.1]);
        dlgstart(dlg,string);
        cd(thisdir);
    end
    
    guidata(hObject, handles);
end
end 
function pbsaveant_Callback(hObject, eventdata, handles)%done
if ~handles.IsBusy
if handles.antenna.paramflags
    [name,dir]=uiputfile('.ant','��������� ���� �������');
    if name~=0
        thisdir=cd;
        cd(dir);
        s=handles.antenna; %#ok<NAS%#ok<MSNU> GU>
        save(name,'-struct','s');
        cd(thisdir);
    end
end
end
guidata(hObject, handles);
%----------------------VKLADKA_KLASTER--------------------------------
function pbopenkl_Callback(hObject, eventdata, handles)%done
if ~handles.IsBusy
[name,dir]=uigetfile('.kl','������� ���� ��������� ��������');
if name~=0
    thisdir=cd;
    cd(dir);
    try
        
        s=load(name,'-mat');
        loadklaster=s.klaster;
        cd(thisdir);
        [stat,errlist]=KLRight(loadklaster); %#ok<*NASGU>
        if ~stat
            handles=ClearKlaster(handles);
            handles=KlasterPrisvaivanie(handles,loadklaster);
            Klasterplot(hObject, eventdata,handles);
            handles=guidata(hObject);
        else
            string=('������ �������� �����, �������� ������������ �����������');
            dlg=dialog('WindowStyle', 'normal', 'Name', '������','Units','normalized','Position',[0.4 0.5 0.2 0.1]);
            dlgstart(dlg,string);
        end
    catch
        string=('������ �������� �����, ���� ���������');
        dlg=dialog('WindowStyle', 'normal', 'Name', '������','Units','normalized','Position',[0.4 0.5 0.2 0.1]);
        dlgstart(dlg,string);
        cd(thisdir);
        handles.antenna.initflags(2)=0;
        handles.antenna.initflags(3)=0;
        handles.antenna.initflags(4)=0;
        handles.antenna.initflags(6)=0;
        handles.Tabs.drawedflags(3)=0;
        handles.Tabs.drawedflags(4)=0;
        handles.Tabs.drawedflags(6)=0;
    end
    guidata(hObject, handles);
end
end
function pbsavekl_Callback(hObject, eventdata, handles)%done
if ~handles.IsBusy
try
    if numel(handles.antenna.klaster)
        [name,dir]=uiputfile('.kl','��������� ���� ��������� ��������');
        if name~=0
            thisdir=cd;
            cd(dir);
            klaster=handles.antenna.klaster;
            save(name,'-mat','klaster');
            cd(thisdir);
        end
    else
        string=('������ ���������� ���������');
        dlg=dialog('WindowStyle', 'normal', 'Name', '������','Units','normalized','Position',[0.4 0.5 0.2 0.1]);
        dlgstart(dlg,string);
    end
catch
    string=('������ ���������� ���������');
    dlg=dialog('WindowStyle', 'normal', 'Name', '������','Units','normalized','Position',[0.4 0.5 0.2 0.1]);
    dlgstart(dlg,string);
end
end
guidata(hObject, handles);
function pbclearkl_Callback(hObject, eventdata, handles)%done
if ~handles.IsBusy
try
    handles=ClearKlaster(handles);
    handles.antenna.initflags(2)=0;
    handles.antenna.initflags(3)=0;
    handles.antenna.initflags(4)=0;
    handles.antenna.initflags(6)=0;
    handles.Tabs.drawedflags(3)=0;
    handles.Tabs.drawedflags(4)=0;
    handles.Tabs.drawedflags(6)=0;
    handles.antenna.klaster=[];
    handles.antenna.DN=[];
catch
    string=lasterr;
    dlg=dialog('WindowStyle', 'normal', 'Name', '������','Units','normalized','Position',[0.4 0.5 0.2 0.1]);
    dlgstart(dlg,string);
end
end
guidata(hObject, handles);
function pbsortkl_Callback(hObject, eventdata, handles)%done
if ~handles.IsBusy
try
    if numel(handles.antenna.klaster)~=0
        Modklaster=KLSort(handles.antenna.klaster);
        handles=ClearKlaster(handles);
        handles=KlasterPrisvaivanie(handles,Modklaster);
        Klasterplot(hObject, eventdata,handles);
        handles=guidata(hObject);
    end
catch
    string=lasterr;
    dlg=dialog('WindowStyle', 'normal', 'Name', '������','Units','normalized','Position',[0.4 0.5 0.2 0.1]);
    dlgstart(dlg,string);
    handles.antenna.initflags(2)=0;
    handles.antenna.initflags(3)=0;
    handles.antenna.initflags(4)=0;
    handles.antenna.initflags(6)=0;
    handles.Tabs.drawedflags(3)=0;
    handles.Tabs.drawedflags(4)=0;
    handles.Tabs.drawedflags(6)=0;
end
end
guidata(hObject, handles);
function pbaddobl_Callback(hObject, eventdata, handles)%done
if ~handles.IsBusy
X=str2double(get(handles.edaddX,'String'));
Y=str2double(get(handles.edaddY,'String'));
if ~isnan(X)
    if ~isnan(Y)
        n=numel(handles.antenna.klaster);
        newklaster=handles.antenna.klaster;
        izl=InitIZL(X,Y);
        if n==0
            newklaster=izl;
        else
            newklaster(n+1,1)=izl;
        end
        [stat,errlist]=KLRight(newklaster);
        if ~stat
            Modklaster=KLSort(newklaster);
            handles=ClearKlaster(handles);
            handles=KlasterPrisvaivanie(handles,Modklaster);
            Klasterplot(hObject, eventdata,handles);
            handles=guidata(hObject);
        else
            string=('�������� ������������ �����������');
            dlg=dialog('WindowStyle', 'normal', 'Name', '������','Units','normalized','Position',[0.4 0.5 0.2 0.1]);
            dlgstart(dlg,string);
        end
    else
        string=('Y �� �������� ������');
        dlg=dialog('WindowStyle', 'normal', 'Name', '������','Units','normalized','Position',[0.4 0.5 0.2 0.1]);
        dlgstart(dlg,string);
    end
else
    string=('X �� �������� ������');
    dlg=dialog('WindowStyle', 'normal', 'Name', '������','Units','normalized','Position',[0.4 0.5 0.2 0.1]);
    dlgstart(dlg,string);
end
end
guidata(hObject, handles);
function edaddX_Callback(hObject, eventdata, handles)%done
if ~handles.IsBusy
temp=str2double(get(hObject,'String'));
if isnan(temp)
    string=('�� �������� ������');
    dlg=dialog('WindowStyle', 'normal', 'Name', '������','Units','normalized','Position',[0.4 0.5 0.2 0.1]);
    dlgstart(dlg,string);
end
end
guidata(hObject, handles);
function edaddY_Callback(hObject, eventdata, handles)%done
if ~handles.IsBusy
temp=str2double(get(hObject,'String'));
if isnan(temp)
    string=('�� �������� ������');
    dlg=dialog('WindowStyle', 'normal', 'Name', '������','Units','normalized','Position',[0.4 0.5 0.2 0.1]);
    dlgstart(dlg,string);
end
end
guidata(hObject, handles);
function pbdelobl_Callback(hObject, eventdata, handles)%done
if ~handles.IsBusy
tempI=str2double(get(handles.eddeloblN,'String'));
if ~isnan(tempI)
    if numel(handles.antenna.klaster)~=0
        handles.antenna.klaster(tempI)=[];
        if numel(handles.antenna.klaster)==0
            handles=ClearKlaster(handles);
            handles.antenna.initflags(2)=0;
            handles.antenna.initflags(3)=0;
            handles.antenna.initflags(4)=0;
            handles.antenna.initflags(6)=0;
            handles.Tabs.drawedflags(3)=0;
            handles.Tabs.drawedflags(4)=0;
            handles.Tabs.drawedflags(6)=0;
        else
            Modklaster=KLSort(handles.antenna.klaster);
            handles=ClearKlaster(handles);
            handles=KlasterPrisvaivanie(handles,Modklaster);
            Klasterplot(hObject, eventdata,handles);
            handles=guidata(hObject);    
        end
    end
else
    string=('�� �������� ������');
    dlg=dialog('WindowStyle', 'normal', 'Name', '������','Units','normalized','Position',[0.4 0.5 0.2 0.1]);
    dlgstart(dlg,string);
end
end
guidata(hObject, handles);
function eddeloblN_Callback(hObject, eventdata, handles)%done
if ~handles.IsBusy
temp=str2double(get(hObject,'String'));
if isnan(temp)
    string=('�� �������� ������');
    dlg=dialog('WindowStyle', 'normal', 'Name', '������','Units','normalized','Position',[0.4 0.5 0.2 0.1]);
    dlgstart(dlg,string);
elseif temp<0
    string=('�������� ����� ����������');
    dlg=dialog('WindowStyle', 'normal', 'Name', '������','Units','normalized','Position',[0.4 0.5 0.2 0.1]);
    dlgstart(dlg,string);
elseif temp>numel(handles.antenna.klaster)
    string=('�������� ����� ����������');
    dlg=dialog('WindowStyle', 'normal', 'Name', '������','Units','normalized','Position',[0.4 0.5 0.2 0.1]);
    dlgstart(dlg,string);
end
end
guidata(hObject, handles);
function pbdelmanyobl_Callback(hObject, eventdata, handles)%done
if ~handles.IsBusy
n=numel(handles.antenna.klaster);
if n~=0
    Data=get(handles.uitkledit,'Data');
    for i=n:-1:1
        if Data{i,3}==1
            handles.antenna.klaster(i)=[];
        end
    end
    if numel(handles.antenna.klaster)==0
        handles=ClearKlaster(handles);
        handles.antenna.initflags(2)=0;
        handles.antenna.initflags(3)=0;
        handles.antenna.initflags(4)=0;
        handles.antenna.initflags(6)=0;
        handles.Tabs.drawedflags(3)=0;
        handles.Tabs.drawedflags(4)=0;
        handles.Tabs.drawedflags(6)=0;
    else
        Modklaster=KLSort(handles.antenna.klaster);
        handles=ClearKlaster(handles);
        handles=KlasterPrisvaivanie(handles,Modklaster);
        Klasterplot(hObject, eventdata,handles);
        handles=guidata(hObject);    
    end
end
end
guidata(hObject, handles);
function pbgeksgen_Callback(hObject, eventdata, handles)%done
if ~handles.IsBusy
Net=str2double(get(handles.edgeksNet,'String'));
Ncobl=str2double(get(handles.edgeksNcentr,'String'));
dX=str2double(get(handles.edgeksdx,'String'));
dY=str2double(get(handles.edgeksdy,'String'));
if ~isnan(Net)&&~isnan(Ncobl)&&~isnan(dX)&&~isnan(dY)
    kldata=KLGeksGen(Net,Ncobl,dX,dY);
    genklaster=InitIZL(kldata(1).X,kldata(1).Y);
    for i=2:numel(kldata);
        genklaster(i,1)=InitIZL(kldata(i).X,kldata(i).Y);
    end
    [stat,errlist]=KLRight(genklaster);
    if ~stat
        handles=ClearKlaster(handles);
        Modklaster=KLSort(genklaster);
        handles=KlasterPrisvaivanie(handles,Modklaster);
        Klasterplot(hObject, eventdata,handles);
        handles=guidata(hObject);
    else
        string=('�������� ������������ �����������');
        dlg=dialog('WindowStyle', 'normal', 'Name', '������','Units','normalized','Position',[0.4 0.5 0.2 0.1]);
        dlgstart(dlg,string);
    end
end
end
guidata(hObject, handles);
function edgeksNet_Callback(hObject, eventdata, handles)%done
if ~handles.IsBusy
temp=str2double(get(hObject,'String'));
if isnan(temp)
    string=('�� �������� ������');
    dlg=dialog('WindowStyle', 'normal', 'Name', '������','Units','normalized','Position',[0.4 0.5 0.2 0.1]);
    dlgstart(dlg,string);
elseif temp<=0
    string=('���������� ������ ������ ���� ������ ����');
    dlg=dialog('WindowStyle', 'normal', 'Name', '������','Units','normalized','Position',[0.4 0.5 0.2 0.1]);
    dlgstart(dlg,string);
end
end
guidata(hObject, handles);
function edgeksdx_Callback(hObject, eventdata, handles)%done
if ~handles.IsBusy
temp=str2double(get(hObject,'String'));
if isnan(temp)
    string=('�� �������� ������');
    dlg=dialog('WindowStyle', 'normal', 'Name', '������','Units','normalized','Position',[0.4 0.5 0.2 0.1]);
    dlgstart(dlg,string);
elseif temp<2
    string=('�������������� �������� ������ ���� ������ 2 R0');
    dlg=dialog('WindowStyle', 'normal', 'Name', '������','Units','normalized','Position',[0.4 0.5 0.2 0.1]);
    dlgstart(dlg,string);
end
end
guidata(hObject, handles);
function edgeksNcentr_Callback(hObject, eventdata, handles)%done
if ~handles.IsBusy
temp=str2double(get(hObject,'String'));
if isnan(temp)
    string=('�� �������� ������');
    dlg=dialog('WindowStyle', 'normal', 'Name', '������','Units','normalized','Position',[0.4 0.5 0.2 0.1]);
    dlgstart(dlg,string);
elseif temp<0
    string=('���������� ����������� � ����������� ����� ������ ���� ������ ����');
    dlg=dialog('WindowStyle', 'normal', 'Name', '������','Units','normalized','Position',[0.4 0.5 0.2 0.1]);
    dlgstart(dlg,string);
end
end
guidata(hObject, handles);
function edgeksdy_Callback(hObject, eventdata, handles)%done
if ~handles.IsBusy
temp=str2double(get(hObject,'String'));
if isnan(temp)
    string=('�� �������� ������');
    dlg=dialog('WindowStyle', 'normal', 'Name', '������','Units','normalized','Position',[0.4 0.5 0.2 0.1]);
    dlgstart(dlg,string);
elseif temp<1.73
    string=('������������ �������� ������ ���� ������ Sqrt(3) R0 (1.73)');
    dlg=dialog('WindowStyle', 'normal', 'Name', '������','Units','normalized','Position',[0.4 0.5 0.2 0.1]);
    dlgstart(dlg,string);
end
end
guidata(hObject, handles);
function pbortogen_Callback(hObject, eventdata, handles)%done
if ~handles.IsBusy
Net=str2double(get(handles.edortoNet,'String'));
Nobl=str2double(get(handles.edortoNoblet,'String'));
dX=str2double(get(handles.edortodx,'String'));
dY=str2double(get(handles.edortody,'String'));
if ~isnan(Net)&&~isnan(Nobl)&&~isnan(dX)&&~isnan(dY)
    kldata=KLOrtoGen(Net,Nobl,dX,dY);
    genklaster=InitIZL(kldata(1).X,kldata(1).Y);
    for i=2:numel(kldata);
        genklaster(i,1)=InitIZL(kldata(i).X,kldata(i).Y);
    end
    [stat,errlist]=KLRight(genklaster);
    if ~stat
        handles=ClearKlaster(handles);
        Modklaster=KLSort(genklaster);
        handles=KlasterPrisvaivanie(handles,Modklaster);
        Klasterplot(hObject, eventdata,handles);
        handles=guidata(hObject);
    else
        string=('�������� ������������ �����������');
        dlg=dialog('WindowStyle', 'normal', 'Name', '������','Units','normalized','Position',[0.4 0.5 0.2 0.1]);
        dlgstart(dlg,string);
    end
end
end
guidata(hObject, handles);
function edortoNet_Callback(hObject, eventdata, handles)%done
if ~handles.IsBusy
temp=str2double(get(hObject,'String'));
if isnan(temp)
    string=('�� �������� ������');
    dlg=dialog('WindowStyle', 'normal', 'Name', '������','Units','normalized','Position',[0.4 0.5 0.2 0.1]);
    dlgstart(dlg,string);
elseif temp<=0
    string=('���������� ������ ������ ���� ������ ����');
    dlg=dialog('WindowStyle', 'normal', 'Name', '������','Units','normalized','Position',[0.4 0.5 0.2 0.1]);
    dlgstart(dlg,string);
end
end
guidata(hObject, handles);
function edortodx_Callback(hObject, eventdata, handles)%done
if ~handles.IsBusy
temp=str2double(get(hObject,'String'));
if isnan(temp)
    string=('�� �������� ������');
    dlg=dialog('WindowStyle', 'normal', 'Name', '������','Units','normalized','Position',[0.4 0.5 0.2 0.1]);
    dlgstart(dlg,string);
elseif temp<2
    string=('�������������� �������� ������ ���� ������ 2 R0');
    dlg=dialog('WindowStyle', 'normal', 'Name', '������','Units','normalized','Position',[0.4 0.5 0.2 0.1]);
    dlgstart(dlg,string);
end
end
guidata(hObject, handles);
function edortoNoblet_Callback(hObject, eventdata, handles)%done
if ~handles.IsBusy
temp=str2double(get(hObject,'String'));
if isnan(temp)
    string=('�� �������� ������');
    dlg=dialog('WindowStyle', 'normal', 'Name', '������','Units','normalized','Position',[0.4 0.5 0.2 0.1]);
    dlgstart(dlg,string);
elseif temp<0
    string=('���������� ����������� � ����� ������ ���� ������ ����');
    dlg=dialog('WindowStyle', 'normal', 'Name', '������','Units','normalized','Position',[0.4 0.5 0.2 0.1]);
    dlgstart(dlg,string);
end
end
guidata(hObject, handles);
function edortody_Callback(hObject, eventdata, handles)%done
if ~handles.IsBusy
temp=str2double(get(hObject,'String'));
if isnan(temp)
    string=('�� �������� ������');
    dlg=dialog('WindowStyle', 'normal', 'Name', '������','Units','normalized','Position',[0.4 0.5 0.2 0.1]);
    dlgstart(dlg,string);
elseif temp<2
    string=('������������ �������� ������ ���� ������ 2 R0');
    dlg=dialog('WindowStyle', 'normal', 'Name', '������','Units','normalized','Position',[0.4 0.5 0.2 0.1]);
    dlgstart(dlg,string);
end
end
guidata(hObject, handles);
function uitkledit_CellEditCallback(hObject, eventdata, handles) %#ok<*DEFNU> done
data=get(handles.uitkledit,'Data');
if ~handles.IsBusy
n=numel(handles.antenna.klaster);
if n~=0
    if ~isnan(eventdata.NewData)
        newklaster=handles.antenna.klaster;
        if eventdata.Indices(1,2)~=3
            if eventdata.Indices(1,2)==1
                newklaster(eventdata.Indices(1,1)).X=eventdata.NewData;
            elseif eventdata.Indices(1,2)==2
                newklaster(eventdata.Indices(1,1)).Y=eventdata.NewData;
            end
            [stat,errlist]=KLRight(newklaster);
            if ~stat
                handles=ClearKlaster(handles);
                handles=KlasterPrisvaivanie(handles,newklaster);
                Klasterplot(hObject, eventdata,handles);
                handles=guidata(hObject);
            else
                OldData=get(handles.uitkledit,'Data');
                for i=1:n
                    datax{i}=handles.antenna.klaster(i).X;
                    datay{i}=handles.antenna.klaster(i).Y;
                    datadel{i}=OldData{i,3};
                end
                set(handles.uitkledit,'Data',[datax' datay' datadel']);
                string=('�������� ������������ �����������');
                dlg=dialog('WindowStyle', 'normal', 'Name', '������','Units','normalized','Position',[0.4 0.5 0.2 0.1]);
                dlgstart(dlg,string);
            end
        end
    else
        string=('�� �������� ������');
        dlg=dialog('WindowStyle', 'normal', 'Name', '������','Units','normalized','Position',[0.4 0.5 0.2 0.1]);
        dlgstart(dlg,string);
        OldData=get(handles.uitkledit,'Data');
        for i=1:n
            datax{i}=handles.antenna.klaster(i).X;
            datay{i}=handles.antenna.klaster(i).Y;
            datadel{i}=OldData{i,3};
        end
        set(handles.uitkledit,'Data',[datax' datay' datadel']);
    end
end
else
    set(handles.uitkledit,'Data',data);
end
guidata(hObject, handles);
%----------------------VKLADKA_OBLU4ATEL'--------------------------------
function pbonall_Callback(hObject, eventdata, handles)%done
if ~handles.IsBusy
n=numel(handles.antenna.klaster);
handles.Tabs.toredrawed(2)=1;
if n~=0
    for i=1:n
        handles.antenna.klaster(i).beactiv='on';
    end
    set(handles.Tabs.Klaster.pRupr2,'FaceColor',handles.preferences.color.beactiv(1,:));
    for i=1:numel(handles.antenna.klaster)
        dataactiv{i}=logical(1);
    end
    set(handles.uiton_off,'Data',[dataactiv']);
end
end
guidata(hObject, handles);
function pboffall_Callback(hObject, eventdata, handles)%done
if ~handles.IsBusy
n=numel(handles.antenna.klaster);
handles.Tabs.toredrawed(2)=1;
if n~=0
    for i=1:n
        handles.antenna.klaster(i).beactiv='off';
    end
    set(handles.Tabs.Klaster.pRupr2,'FaceColor',handles.preferences.color.beactiv(2,:));
    for i=1:numel(handles.antenna.klaster)
        dataactiv{i}=logical(0);
    end
    set(handles.uiton_off,'Data',[dataactiv']);
end
end
guidata(hObject, handles);
function uiton_off_CellEditCallback(hObject, eventdata, handles)%done
data=get(handles.uiton_off,'Data');
if ~handles.IsBusy

n=numel(handles.antenna.klaster);
handles.Tabs.toredrawed(2)=1;
if n~=0
    if ~isnan(eventdata.NewData)
        if eventdata.NewData
            handles.antenna.klaster(eventdata.Indices(1,1)).beactiv='on';
            set(handles.Tabs.Klaster.pRupr2(eventdata.Indices(1,1)),'FaceColor',handles.preferences.color.beactiv(1,:));
        else
            handles.antenna.klaster(eventdata.Indices(1,1)).beactiv='off';
            set(handles.Tabs.Klaster.pRupr2(eventdata.Indices(1,1)),'FaceColor',handles.preferences.color.beactiv(2,:));
        end
    else
        string=('�� �������� ������');
        dlg=dialog('WindowStyle', 'normal', 'Name', '������','Units','normalized','Position',[0.4 0.5 0.2 0.1]);
        dlgstart(dlg,string);
        for i=1:n
            dataactiv{i}=handles.antenna.klaster(i).beactiv;
        end
        set(handles.uiton_off,'Data',dataactiv');
    end
end
else
    set(handles.uiton_off,'Data',data);
end
guidata(hObject, handles);
function uipactivpolar_SelectionChangeFcn(hObject, eventdata, handles)%done
n=numel(handles.antenna.klaster);
temp1=eventdata.OldValue;
if ~handles.IsBusy
    list1={'F1T','F1L','F2T','F2L'};
    list2={'T','L'};
    handles.Tabs.toredrawed(2)=1;
    if handles.antenna.initflags(4)&&~handles.antenna.CountType
        handles.Tabs.KLconfigChanged=1;
    end
        if n~=0
            switch eventdata.NewValue
                case handles.rbT
                    set(handles.Tabs.Klaster.pRupr3,'FaceColor',handles.preferences.color.polar(1,:));
                    handles.antenna.System.polardevision=1;
                    for i=1:n
                        handles.antenna.klaster(i).frequency='F1';
                        handles.antenna.klaster(i).polarization=list2{1};
                    end
                case handles.rbL
                    set(handles.Tabs.Klaster.pRupr3,'FaceColor',handles.preferences.color.polar(2,:));
                    handles.antenna.System.polardevision=2;
                    for i=1:n
                        handles.antenna.klaster(i).frequency='F1';
                        handles.antenna.klaster(i).polarization=list2{2};
                    end
                case handles.rbTF
                    set(handles.Tabs.Klaster.pRupr3,'FaceColor',handles.preferences.color.polar(3,:));
                    handles.antenna.System.polardevision=3;
                    for i=1:n
                        handles.antenna.klaster(i).frequency='F2';
                        handles.antenna.klaster(i).polarization=list2{1};
                    end
                case handles.rbLF
                    set(handles.Tabs.Klaster.pRupr3,'FaceColor',handles.preferences.color.polar(4,:));
                    handles.antenna.System.polardevision=4;
                    for i=1:n
                        handles.antenna.klaster(i).frequency='F2';
                        handles.antenna.klaster(i).polarization=list2{2};
                    end    
                case handles.rbF1F2TL
                    poltable=PolinKL(handles);
                    handles.antenna.System.polardevision=3;
                    for i=1:n
                        if poltable(1,i)==0
                            set(handles.Tabs.Klaster.pRupr3(i),'FaceColor',handles.preferences.color.polar(1,:));
                            handles.antenna.klaster(i).frequency='F1';
                            handles.antenna.klaster(i).polarization=list2{1};
                        elseif poltable(1,i)==1
                            set(handles.Tabs.Klaster.pRupr3(i),'FaceColor',handles.preferences.color.polar(2,:));
                            handles.antenna.klaster(i).frequency='F1';
                            handles.antenna.klaster(i).polarization=list2{2};
                        elseif poltable(1,i)==2
                            set(handles.Tabs.Klaster.pRupr3(i),'FaceColor',handles.preferences.color.polar(3,:));
                            handles.antenna.klaster(i).frequency='F2';
                            handles.antenna.klaster(i).polarization=list2{1};
                        elseif poltable(1,i)==3
                            set(handles.Tabs.Klaster.pRupr3(i),'FaceColor',handles.preferences.color.polar(4,:));
                            handles.antenna.klaster(i).frequency='F2';
                            handles.antenna.klaster(i).polarization=list2{2};
                        end
                    end
                case handles.rbF1F2LT
                    poltable=PolinKL(handles);
                    handles.antenna.System.polardevision=6;
                    for i=1:n
                        if poltable(1,i)==0
                            set(handles.Tabs.Klaster.pRupr3(i),'FaceColor',handles.preferences.color.polar(3,:));
                            handles.antenna.klaster(i).frequency='F2';
                            handles.antenna.klaster(i).polarization=list2{1};
                        elseif poltable(1,i)==1
                            set(handles.Tabs.Klaster.pRupr3(i),'FaceColor',handles.preferences.color.polar(4,:));
                            handles.antenna.klaster(i).frequency='F2';
                            handles.antenna.klaster(i).polarization=list2{2};
                        elseif poltable(1,i)==2
                            set(handles.Tabs.Klaster.pRupr3(i),'FaceColor',handles.preferences.color.polar(1,:));
                            handles.antenna.klaster(i).frequency='F1';
                            handles.antenna.klaster(i).polarization=list2{1};
                        elseif poltable(1,i)==3
                            set(handles.Tabs.Klaster.pRupr3(i),'FaceColor',handles.preferences.color.polar(2,:));
                            handles.antenna.klaster(i).frequency='F1';
                            handles.antenna.klaster(i).polarization=list2{2};
                        end
                    end    
                otherwise    
            end
        end
    if handles.Tabs.KLconfigChanged
        handles=KLConfigError(handles);
    end
else
    set(temp1,'Value',1);
end
guidata(hObject, handles);
function pbpolarhelp_Callback(hObject, eventdata, handles)%zablokirovanno
function pbzerophase_Callback(hObject, eventdata, handles)%zablokirovanno
if 0
n=numel(handles.antenna.klaster); %#ok<*UNRCH>
if n~=0
    for i=1:n
        handles.antenna.klaster(i).phase=0;
        dataphase{i}=handles.antenna.klaster(i).phase;
    end
    set(handles.uitphase,'Data',[dataphase']);
end
end
guidata(hObject, handles);
function uitphase_CellEditCallback(hObject, eventdata, handles)%zablokirovanno
if 0
n=numel(handles.antenna.klaster);
if n~=0
    if ~isnan(eventdata.NewData)
        handles.antenna.klaster(eventdata.Indices(1,1)).phase=eventdata.NewData;
    else
        errordlg('�� �������� ������','������');
        for i=1:n
            dataphase{i}=handles.antenna.klaster(i).phase;
        end
        set(handles.uitphase,'Data',dataphase');
    end
end
end
guidata(hObject, handles);
function pboneampl_Callback(hObject, eventdata, handles)%done
if ~handles.IsBusy
n=numel(handles.antenna.klaster);
if n~=0
    for i=1:n
        handles.antenna.klaster(i).ampl=1;
        dataampl{i}=handles.antenna.klaster(i).ampl;
    end
    set(handles.uitampl,'Data',[dataampl']);
end
end
guidata(hObject, handles);
function uitampl_CellEditCallback(hObject, eventdata, handles)%done
data=get(handles.uitampl,'Data');
if ~handles.IsBusy
n=numel(handles.antenna.klaster);
if n~=0
    if ~isnan(eventdata.NewData)
        handles.antenna.klaster(eventdata.Indices(1,1)).ampl=eventdata.NewData;
    else
        errordlg('�� �������� ������','������');
        for i=1:n
            dataampl{i}=handles.antenna.klaster(i).ampl;
        end
        set(handles.uitampl,'Data',dataampl');
    end
end
    set(handles.uitampl,'Data',data);
end
guidata(hObject, handles);
%----------------------RASCHET_DN--------------------------------
function edfider_Callback(hObject, eventdata, handles)%zablokirovanno
if 0
temp=str2double(get(handles.edfider,'String'));
if ~isnan(temp)
    if temp>=0&&temp<=1
        handles.antenna.System.nf=temp;
    else
        errordlg('����������� �������� ������ ����������� [0;1]','������');
    end
else
    errordlg('�� �������� ������','������');
end
end
guidata(hObject, handles);
function uipParrasch_SelectionChangeFcn(hObject, eventdata, handles)%done
temp=eventdata.NewValue;
temp1=eventdata.OldValue;
if ~handles.IsBusy
    if temp==handles.rbraschall
        handles.antenna.CountType=1;
    elseif temp==handles.rbraschcurr
        handles.antenna.CountType=0;
    end
else
    set(temp1,'Value',1);
end
guidata(hObject, handles);
function pbstartrasch_Callback(hObject, eventdata, handles)%done
if ~handles.IsBusy
try
    if 1
        handles.antenna.initflags(4)=1;
        tstart=tic;
        handles=DiagStart(handles);
        tres=toc(tstart);
        handles.antenna.System.navparam.Level=NaN;
        if handles.Tabs.visible.flags(4)
            handles=ClearDN(handles);
        end
        if handles.antenna.initflags(4)
            timestring=strcat('������. ���������: ',num2str(tres),' ������');
            dlg=dialog('WindowStyle', 'normal', 'Name', '������ �������','Units','normalized','Position',[0.4 0.5 0.2 0.1]);
            dlgstart(dlg,timestring);
        end
        handles.Tabs.KLconfigChanged=0;
        handles.Tabs.KLconfigChangedPrint=0;
        handles.Tabs.drawedflags(4)=0;
        if handles.Tabs.visible.flags(4)
            DNplot(hObject, eventdata,handles);
        end
        handles=guidata(hObject);
    end 
catch
    string=lasterr;
    dlg=dialog('WindowStyle', 'normal', 'Name', '������','Units','normalized','Position',[0.4 0.5 0.2 0.1]);
    dlgstart(dlg,string);
    handles.antenna.initflags(4)=0;
end
end
guidata(hObject, handles);
function pbShowdec_Callback(hObject, eventdata, handles)%done
if ~handles.IsBusy
handles.Tabs.tipDN=mod(handles.Tabs.tipDN+1,2);
if handles.Tabs.tipDN
    set(handles.pbShowdec,'String','�������������');
else
    set(handles.pbShowdec,'String','��');
end
handles=APDNotobragenie(handles);
end
guidata(hObject, handles);
function pbShowL_Callback(hObject, eventdata, handles)%done
if ~handles.IsBusy
handles.Tabs.tipLT=0;
handles=APDNotobragenie(handles);
end
guidata(hObject, handles);
function pbShowT_Callback(hObject, eventdata, handles)%done
if ~handles.IsBusy
handles.Tabs.tipLT=1;
handles=APDNotobragenie(handles);
end
guidata(hObject, handles);
function pbShowdefault_Callback(hObject, eventdata, handles)%done
if ~handles.IsBusy
n=numel(handles.antenna.klaster);
for i=1:n
    handles.antenna.System.DNotobr(i).activ=1;
end
handles=APDNplot(handles);
handles=APDNotobragenie(handles);
end
guidata(hObject, handles);
function pb3DDNobl_Callback(hObject, eventdata, handles)%done
if ~handles.IsBusy
if handles.antenna.initflags(1)&&handles.antenna.initflags(2)&&handles.antenna.initflags(4)
    ProstrDiagram(handles.antenna,handles.preferences);
end
end
guidata(hObject, handles);
%----------------------KARTA-------------------------------------
function pbMod_Callback(hObject, eventdata, handles)%done
if ~handles.IsBusy
    handles.Tabs.Zadacha=0;
    handles=ChZadacha(handles);
end
guidata(hObject, handles);
function pbIngAn_Callback(hObject, eventdata, handles)%done
if ~handles.IsBusy
    handles.Tabs.Zadacha=1;
    handles=ChZadacha(handles);
end
guidata(hObject, handles);
function pbkrtonall_Callback(hObject, eventdata, handles)%done
if ~handles.IsBusy
    n=numel(handles.antenna.klaster);
    handles.Tabs.toredrawed(1)=1;
    if n~=0
        for i=1:n
            handles.antenna.klaster(i).beactiv='on';
        end
        set(handles.Tabs.Klaster.pRupr6,'FaceColor',handles.preferences.color.beactiv(1,:));
    end
    if handles.antenna.initflags(6)&&numel(handles.Tabs.KartaObj.Luch)>0
        for i=1:n
        	set(handles.Tabs.KartaObj.Luch(i),'Visible','on');
        end
    end
end
guidata(hObject, handles);
function pbkrtoffall_Callback(hObject, eventdata, handles)%done
if ~handles.IsBusy
    n=numel(handles.antenna.klaster);
    handles.Tabs.toredrawed(1)=1;
    if n~=0
        for i=1:n
            handles.antenna.klaster(i).beactiv='off';
        end
        set(handles.Tabs.Klaster.pRupr6,'FaceColor',handles.preferences.color.beactiv(2,:));
    end
    if handles.antenna.initflags(6)&&numel(handles.Tabs.KartaObj.Luch)>0
        for i=1:n
        	set(handles.Tabs.KartaObj.Luch(i),'Visible','off');
        end
    end
end
guidata(hObject, handles);
function edLevel_Callback(hObject, eventdata, handles)%done
if ~handles.IsBusy
    handles.antenna.System.navparam.Level=str2double(get(hObject,'String'));
    try
        if ~isnan(handles.antenna.System.navparam.Level)
            if handles.antenna.System.navparam.Level<0
                handles.antenna.System.navflags(1)=1;
                if ~handles.Tabs.Zadacha
                    if handles.antenna.System.navflags
                        if handles.antenna.System.Karta.otobrflag(2)&&handles.antenna.initflags(4)
                            handles=GetContourData(handles);
                            handles=PutContourOnTheMap(handles);
                        end
                    end
                end
            else
                dlg=dialog('WindowStyle', 'normal', 'Name', '������','Units','normalized','Position',[0.4 0.5 0.2 0.1]);
                string='������� ������� ������ ���� ������ ����.';
                dlgstart(dlg,string);
            end
        else
            handles.antenna.System.navflags(1)=0;
        end
    catch
        handles=guidata(hObject);
        handles.IsBusy=0;
        handles.antenna.initflags(6)=0;
        handles.antenna.System.navflags(1)=0;
        string=lasterr;
        dlg=dialog('WindowStyle', 'normal', 'Name', '������','Units','normalized','Position',[0.4 0.5 0.2 0.1]);
        dlgstart(dlg,string);
    end
else
    if ~isnan(handles.antenna.System.navparam.Level)
        set(handles.edLevel,'String',num2str(handles.antenna.System.navparam.Level));
    end
end
guidata(hObject, handles);%
function edmuka_Callback(hObject, eventdata, handles)%done
if ~handles.IsBusy
    handles.antenna.System.navparam.muka=str2double(get(hObject,'String'));
    try
        if ~isnan(handles.antenna.System.navparam.muka)
            if handles.antenna.System.navparam.muka<=180&&handles.antenna.System.navparam.muka>=-180
                handles.antenna.System.navflags(2)=1;
                if ~handles.IsBusy
                    delete(handles.Tabs.KartaObj.BaseContour);
                    handles.Tabs.KartaObj.BaseContour=[];
                    handles.antenna.System.BaseContour=[];
                    delete(handles.Tabs.KartaObj.VisibleZone);
                    handles.Tabs.KartaObj.VisibleZone=[];
                    handles=VisibleZone(handles);
                    handles.Tabs.KartaObj.VisibleZone=PutLevelOnTheMap(handles,handles.antenna.System.VisibleZone.Contour,0,0,0,handles.preferences.color.VisibleZone,0,0,0,0);
                    if handles.antenna.System.Karta.otobrflag(1)
                        set(handles.Tabs.KartaObj.VisibleZone,'Visible','on');
                    else
                        set(handles.Tabs.KartaObj.VisibleZone,'Visible','off');
                    end
                    if ~handles.Tabs.Zadacha
                        if handles.antenna.System.navflags
                            if handles.antenna.System.Karta.otobrflag(2)&&handles.antenna.initflags(4)
                                handles=GetContourData(handles);
                                handles=PutContourOnTheMap(handles);
                            end
                        end
                    end
                end
            else
                dlg=dialog('WindowStyle', 'normal', 'Name', '������','Units','normalized','Position',[0.4 0.5 0.2 0.1]);
                string='�������������� ����� ����������� [-180;180].';
                dlgstart(dlg,string);
            end
        else
            handles.antenna.System.navflags(2)=0;
        end
    catch
        handles=guidata(hObject);
        handles.IsBusy=0;
        handles.antenna.initflags(6)=0;
        handles.antenna.System.navflags(2)=0;
        string=lasterr;
        dlg=dialog('WindowStyle', 'normal', 'Name', '������','Units','normalized','Position',[0.4 0.5 0.2 0.1]);
        dlgstart(dlg,string);
    end
else
    if ~isnan(handles.antenna.System.navparam.muka)
        set(handles.edmuka,'String',num2str(handles.antenna.System.navparam.muka));
    end
end
guidata(hObject, handles);
function edmupr_Callback(hObject, eventdata, handles)%done
if ~handles.IsBusy
    handles.antenna.System.navparam.mupr=str2double(get(hObject,'String'));
    try
        if ~isnan(handles.antenna.System.navparam.mupr)
            if handles.antenna.System.navparam.mupr<=180&&handles.antenna.System.navparam.mupr>=-180
                handles.antenna.System.navflags(3)=1;
                if ~handles.Tabs.Zadacha
                    if handles.antenna.System.navflags
                        if handles.antenna.System.Karta.otobrflag(2)&&handles.antenna.initflags(4)
                            handles=GetContourData(handles);
                            handles=PutContourOnTheMap(handles);
                        end
                    end
                end
            else
                dlg=dialog('WindowStyle', 'normal', 'Name', '������','Units','normalized','Position',[0.4 0.5 0.2 0.1]);
                string='������� ����� ������������ ����������� [-180;180].';
                dlgstart(dlg,string);
            end
        else
            handles.antenna.System.navflags(3)=0;
        end
    catch
        handles=guidata(hObject);
        handles.IsBusy=0;
        handles.antenna.initflags(6)=0;
        handles.antenna.System.navflags(3)=0;
        string=lasterr;
        dlg=dialog('WindowStyle', 'normal', 'Name', '������','Units','normalized','Position',[0.4 0.5 0.2 0.1]);
        dlgstart(dlg,string);
    end
else
    if ~isnan(handles.antenna.System.navparam.mupr)
    	set(handles.edmupr,'String',num2str(handles.antenna.System.navparam.mupr));
    end
end
guidata(hObject, handles);
function edthpr_Callback(hObject, eventdata, handles)%done
if ~handles.IsBusy
    handles.antenna.System.navparam.thpr=str2double(get(hObject,'String'));
    try
        if ~isnan(handles.antenna.System.navparam.thpr)
            if handles.antenna.System.navparam.thpr<=90&&handles.antenna.System.navparam.thpr>=-90
                handles.antenna.System.navflags(4)=1;
                if ~handles.Tabs.Zadacha
                    if handles.antenna.System.navflags
                        if handles.antenna.System.Karta.otobrflag(2)&&handles.antenna.initflags(4)
                            handles=GetContourData(handles);
                            handles=PutContourOnTheMap(handles);
                        end
                    end
                end
            else
                dlg=dialog('WindowStyle', 'normal', 'Name', '������','Units','normalized','Position',[0.4 0.5 0.2 0.1]);
                string='������ ����� ������������ ����������� [-90;90].';
                dlgstart(dlg,string);
            end
        else
            handles.antenna.System.navflags(4)=0;
        end
    catch
        handles=guidata(hObject);
        handles.IsBusy=0;
        handles.antenna.initflags(6)=0;
        handles.antenna.System.navflags(4)=0;
        string=lasterr;
        dlg=dialog('WindowStyle', 'normal', 'Name', '������','Units','normalized','Position',[0.4 0.5 0.2 0.1]);
        dlgstart(dlg,string);
    end
else
    if ~isnan(handles.antenna.System.navparam.thpr)
        set(handles.edthpr,'String',num2str(handles.antenna.System.navparam.thpr));
    end
end
guidata(hObject, handles);
function edsigma_Callback(hObject, eventdata, handles)%done
if ~handles.IsBusy
    handles.antenna.System.navparam.sigma=str2double(get(hObject,'String'));
    try
        if ~isnan(handles.antenna.System.navparam.sigma)
            if handles.antenna.System.navparam.sigma<=360&&handles.antenna.System.navparam.sigma>=0
                handles.antenna.System.navflags(5)=1;
                if ~handles.Tabs.Zadacha
                    if handles.antenna.System.navflags
                        if handles.antenna.System.Karta.otobrflag(2)&&handles.antenna.initflags(4)&&~handles.IsBusy
                            handles=GetContourData(handles);
                            handles=PutContourOnTheMap(handles);
                        end
                    end
                end
            else
                dlg=dialog('WindowStyle', 'normal', 'Name', '������','Units','normalized','Position',[0.4 0.5 0.2 0.1]);
                string='���� �������� ������� ����������� [0;360].';
                dlgstart(dlg,string);
            end
        else
            handles.antenna.System.navflags(5)=0;
        end
    catch
        handles=guidata(hObject);
        handles.IsBusy=0;
        handles.antenna.initflags(6)=0;
        handles.antenna.System.navflags(5)=0;
        string=lasterr;
        dlg=dialog('WindowStyle', 'normal', 'Name', '������','Units','normalized','Position',[0.4 0.5 0.2 0.1]);
        dlgstart(dlg,string);
    end
else
    if ~isnan(handles.antenna.System.navparam.sigma)
    	set(handles.edsigma,'String',num2str(handles.antenna.System.navparam.sigma));
    end
end
guidata(hObject, handles);
function uipkrtcelfcn_SelectionChangeFcn(hObject, eventdata, handles)%done
temp=eventdata.NewValue;
temp1=eventdata.OldValue;
if ~handles.IsBusy
    switch temp
        case handles.rbconturSKO
            handles.Tabs.CelFcn=1;
        case handles.rbmaxPP
            handles.Tabs.CelFcn=2;
        case handles.rbmaxPS
            handles.Tabs.CelFcn=3;
        otherwise
    end
else
    set(temp1,'Value',1);
end
guidata(hObject, handles);
function uipkrtalgfcn_SelectionChangeFcn(hObject, eventdata, handles)%done
temp=eventdata.NewValue;
temp1=eventdata.OldValue;
if ~handles.IsBusy
    switch temp
        case handles.rbpik
            handles.Tabs.AlgFcn=1;
        case handles.rbgrad
            handles.Tabs.AlgFcn=2;
        case handles.rbpikgrad
            handles.Tabs.AlgFcn=3;
        otherwise
    end
else
    set(temp1,'Value',1);
end
guidata(hObject, handles);
function chbZone_Callback(hObject, eventdata, handles)%done
if ~handles.IsBusy
    handles.antenna.System.Karta.otobrflag(1)=get(hObject,'Value');
    try
        if handles.antenna.System.VisibleZone.Init
            if handles.antenna.System.Karta.otobrflag(1)
                set(handles.Tabs.KartaObj.VisibleZone,'Visible','on');
            else
                set(handles.Tabs.KartaObj.VisibleZone,'Visible','off');
            end
        end
    catch
        handles=guidata(hObject);
        string=lasterr;
        dlg=dialog('WindowStyle', 'normal', 'Name', '������','Units','normalized','Position',[0.4 0.5 0.2 0.1]);
        dlgstart(dlg,string);
    end
else
    set(handles.chbZone,'Value',handles.antenna.System.Karta.otobrflag(1));
end
guidata(hObject, handles);
function chbAuto_Callback(hObject, eventdata, handles)%done
if ~handles.IsBusy
    handles.antenna.System.Karta.otobrflag(2)=get(hObject,'Value');
else
    set(handles.chbAuto,'Value',handles.antenna.System.Karta.otobrflag(2));
end
guidata(hObject, handles);
function chbNum_Callback(hObject, eventdata, handles)%done
if ~handles.IsBusy
    handles.antenna.System.Karta.otobrflag(3)=get(hObject,'Value');
    try
        if handles.antenna.initflags(6)
            handles.Tabs.DrawedZone=0;
            handles=PutContourOnTheMap(handles);
        end
    catch
        handles=guidata(hObject);
        handles.IsBusy=0;
        string=lasterr;
        dlg=dialog('WindowStyle', 'normal', 'Name', '������','Units','normalized','Position',[0.4 0.5 0.2 0.1]);
        dlgstart(dlg,string);
    end
else
    set(handles.chbNum,'Value',handles.antenna.System.Karta.otobrflag(3));
end
guidata(hObject, handles);
function chbGa_Callback(hObject, eventdata, handles)%zablokirovanno
if 0
    handles.antenna.System.Karta.otobrflag(4)=get(hObject,'Value'); %#ok<UNRCH>
    try
        if handles.antenna.initflags(6)&&~handles.IsBusy
            handles.Tabs.DrawedZone=0;
            handles=PutContourOnTheMap(handles);
        end
    catch
        handles=guidata(hObject);
        handles.IsBusy=0;
        string=lasterr;
        errordlg(string,'������');
    end
end
guidata(hObject, handles);
function chbfill_Callback(hObject, eventdata, handles)%done
if ~handles.IsBusy
    handles.antenna.System.Karta.otobrflag(5)=get(hObject,'Value');
    try
        if handles.antenna.initflags(6)
            handles.Tabs.DrawedZone=0;
            handles=PutContourOnTheMap(handles);
        end
    catch
        handles=guidata(hObject);
        handles.IsBusy=0;
        string=lasterr;
        dlg=dialog('WindowStyle', 'normal', 'Name', '������','Units','normalized','Position',[0.4 0.5 0.2 0.1]);
        dlgstart(dlg,string);
    end
else
    set(handles.chbfill,'Value',handles.antenna.System.Karta.otobrflag(5));
end
guidata(hObject, handles);
function chblabel_Callback(hObject, eventdata, handles)%zablokirovanno
if 0
    handles.antenna.System.Karta.otobrflag(6)=get(hObject,'Value'); %#ok<UNRCH>
    try
        if handles.antenna.initflags(6)&&~handles.IsBusy

            handles=PutContourOnTheMap(handles);
        end
    catch
        string=lasterr;
        dlg=dialog('WindowStyle', 'normal', 'Name', '������','Units','normalized','Position',[0.4 0.5 0.2 0.1]);
        dlgstart(dlg,string);
    end
end
guidata(hObject, handles);
function chbTrace_Callback(hObject, eventdata, handles)%done
if ~handles.IsBusy
    handles.antenna.System.Karta.otobrflag(7)=get(hObject,'Value');
    try
        if ~handles.Tabs.Zadacha
            if handles.antenna.System.navflags
                if handles.antenna.System.Karta.otobrflag(2)&&handles.antenna.initflags(4)
                    handles=GetContourData(handles);
                    handles=PutContourOnTheMap(handles);
                end
            end
        end
    catch
        handles=guidata(hObject);
        handles.IsBusy=0;
        string=lasterr;
        dlg=dialog('WindowStyle', 'normal', 'Name', '������','Units','normalized','Position',[0.4 0.5 0.2 0.1]);
        dlgstart(dlg,string);
        handles.antenna.initflags(6)=0;
    end
else
    set(handles.chbTrace,'Value',handles.antenna.System.Karta.otobrflag(7));
end
guidata(hObject, handles);
function chbAutoLevel_Callback(hObject, eventdata, handles)%done
if ~handles.IsBusy
    handles.antenna.System.Karta.otobrflag(8)=get(hObject,'Value');
    try
        if handles.antenna.System.Karta.otobrflag(8)
            level=GetAutoLevel(handles);
            handles=guidata(hObject);
            handles.antenna.System.navparam.Level=level;
            if ~isnan(handles.antenna.System.navparam.Level)
                handles.antenna.System.navflags(1)=1;
                set(handles.edLevel,'String',num2str(level));
            end
            if ~handles.Tabs.Zadacha
                if handles.antenna.System.navflags
                    if handles.antenna.System.Karta.otobrflag(2)&&handles.antenna.initflags(4)
                        handles=GetContourData(handles);
                        handles=PutContourOnTheMap(handles);
                    end
                end
            end
        else
            handles.antenna.System.navparam.Level=NaN;
            handles.antenna.System.navflags(1)=0;
            set(handles.edLevel,'String','');
        end
    catch
        handles=guidata(hObject);
        handles.IsBusy=0;
        string=lasterr;
        dlg=dialog('WindowStyle', 'normal', 'Name', '������','Units','normalized','Position',[0.4 0.5 0.2 0.1]);
        dlgstart(dlg,string);
        handles.antenna.initflags(6)=0;
    end
else
    set(handles.chbAutoLevel,'Value',handles.antenna.System.Karta.otobrflag(8));
end
guidata(hObject, handles);
function pbkrtstart_Callback(hObject, eventdata, handles)
if ~handles.IsBusy
    if ~handles.Tabs.Zadacha
        if handles.antenna.System.navflags
            handles=GetContourData(handles);
            handles=PutContourOnTheMap(handles);
        end
    elseif handles.Tabs.Zadacha&&numel(handles.antenna.System.BaseContour)>0&&handles.antenna.System.navflags(1)&&handles.antenna.System.navflags(2)
        handles=GetContourData(handles);
        handles=PutContourOnTheMap(handles);
    else
        dlg=dialog('WindowStyle', 'normal', 'Name', '������','Units','normalized','Position',[0.4 0.5 0.2 0.1]);
        string='������ �� ��� ���������.';
        dlgstart(dlg,string);
    end
end
guidata(hObject, handles);
function pbkrtSSS_Callback(hObject, eventdata, handles)%zablokirovanno
function pbkrtkontur_Callback(hObject, eventdata, handles)%done
if ~handles.IsBusy&&handles.antenna.System.navflags(2)
    delete(handles.Tabs.KartaObj.BaseContour);
    handles.Tabs.KartaObj.BaseContour=[];
    handles.antenna.System.BaseContour=[];
    [X,Y]=getline(handles.axkrt);
        
    muka=handles.antenna.System.navparam.muka;
    LevelZone=handles.preferences.Karta.VisibleZoneLevel;
    BETAx_y=handles.antenna.System.VisibleZone.BETA;

    muka1=sign(muka)*floor(abs(muka));
    BetaEarthZone=circshift(BETAx_y,[0 -muka1])*180/pi;
    MX=linspace(-180,180,360)+muka1;
    MY=linspace(-90,90,180);

    EarthZone=contourc(MX,MY,BetaEarthZone,[LevelZone LevelZone]);
    EarthZone(:,1)=[];
    
    IN=inpolygon(X',Y',EarthZone(1,:),EarthZone(2,:));
    X=X(IN)';
    Y=Y(IN)';
    X=[X,X(1)];
    Y=[Y,Y(1)];
    
    handles.antenna.System.BaseContour=[X;Y];
    handles.Tabs.KartaObj.BaseContour=line(X,Y);
    set(handles.Tabs.KartaObj.BaseContour,'Color','black','LineWidth',handles.preferences.Karta.ContourWidth);
    set(handles.axkrt,'XLim',[-180,180],'YLim',[-90,90]);
end
guidata(hObject, handles);
function pbkrtclear_Callback(hObject, eventdata, handles)%done
if ~handles.IsBusy
    set(handles.Tabs.KartaObj.Luch,'Visible','off');
    if handles.antenna.System.Karta.otobrflag(1)
    	set(handles.Tabs.KartaObj.VisibleZone,'Visible','on');
    else
    	set(handles.Tabs.KartaObj.VisibleZone,'Visible','off');
    end
    delete(handles.Tabs.KartaObj.BaseContour);
    handles.Tabs.KartaObj.BaseContour=[];
    handles.antenna.System.BaseContour=[];
end
guidata(hObject, handles);
function pbkrtProstr_Callback(hObject, eventdata, handles)%done
if ~handles.IsBusy
    if ~handles.IsBusy&&handles.antenna.initflags(6)&&handles.antenna.initflags(4)
        Globe(handles.antenna,handles.preferences);
    end
end
guidata(hObject, handles);
%--------------------CREATE_FUNCTIONS-------------------------------------
function popupmpolar_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function edD_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function edC_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function edF_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function edalfa0_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function edR0_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function edF1_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function edF2_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function eddeloblN_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function edortoNet_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function edortodx_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function edortoNoblet_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function edortody_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function edgeksNet_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function edgeksdx_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function edgeksNcentr_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function edgeksdy_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function edaddX_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function edaddY_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function edfider_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function edmuka_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function edLevel_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function edmupr_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function edthpr_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function edsigma_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
%--------------------USER_DEFINED_FUNCTIONS-------------------------------
function GeomRaschet(hObject, eventdata,handles)%done
if ~handles.IsBusy
try
    handles.IsBusy=1;
    guidata(handles.figure1, handles);
    handles.antenna.initflags(1)=1;
    handles.antenna.initflags(4)=0;
    handles.antenna.initflags(6)=0;
    handles.Tabs.drawedflags(4)=0;
    handles.Tabs.drawedflags(6)=0;
    handles.antenna.allparam=GetAllParam(handles.antenna.baseparam);
    
    handles.antenna.F1.pole=feval(handles.preferences.functions.pole, ...
    handles.antenna.allparam,handles.antenna.allparam.lambdaF1,handles.preferences.tol.pole);
    handles.antenna.F2.pole=feval(handles.preferences.functions.pole, ...
    handles.antenna.allparam,handles.antenna.allparam.lambdaF2,handles.preferences.tol.pole);
    handles.antenna.allparam.n=(handles.antenna.F1.pole.n+handles.antenna.F2.pole.n)/2;
    handles.antenna.allparam.v=(handles.antenna.F1.pole.v+handles.antenna.F2.pole.v)/2;
    handles.antenna.allparam.kip=(handles.antenna.F1.pole.kip+handles.antenna.F2.pole.kip)/2;
    handles.IsBusy=0;
    guidata(handles.figure1, handles);
    Geomplot(hObject, eventdata,handles);
    handles=guidata(hObject);
catch
    handles.IsBusy=0;
    string=lasterr;
    dlg=dialog('WindowStyle', 'normal', 'Name', '������','Units','normalized','Position',[0.4 0.5 0.2 0.1]);
    dlgstart(dlg,string);
    handles.antenna.initflags(1)=0;
    handles.antenna.initflags(4)=0;
    handles.antenna.initflags(6)=0;
    %------------------
end
end
guidata(hObject, handles);
function Geomplot(hObject, eventdata,handles)%done
if ~handles.IsBusy
try
    handles.IsBusy=1;
    guidata(handles.figure1, handles);
    handles=GZAplot(handles,handles.preferences.tol.ax3Dant);
    temp=struct2cell(handles.antenna.allparam);
    n=size(temp);
    n=n(1);
    temp{4,:}=temp{4,:}*180/pi;
    temp{5,:}=temp{5,:}*180/pi;
    temp{6,:}=temp{6,:}*180/pi;
    temp{7,:}=temp{7,:}*180/pi;
    for i=1:n 
        if ~ischar(temp{i,:}) 
            temp{i,:}=num2str(temp{i,:}) ;
        end
    end
    set(handles.tallparam,'String',strcat(fieldnames(handles.antenna.allparam),' : ',temp));
    handles=RaspredPlot(handles,handles.Tabs.chosepolar);
    
    set(handles.edD,'String',num2str(handles.antenna.baseparam.D));
    set(handles.edC,'String',num2str(handles.antenna.baseparam.C));
    set(handles.edF,'String',num2str(handles.antenna.baseparam.F));
    set(handles.edalfa0,'String',num2str(handles.antenna.baseparam.alfa0));
    set(handles.edR0,'String',num2str(handles.antenna.baseparam.R0));
    set(handles.edF1,'String',num2str(handles.antenna.baseparam.F1));
    set(handles.edF2,'String',num2str(handles.antenna.baseparam.F2));
    handles.Tabs.drawedflags(1)=1;
    handles.IsBusy=0;
    guidata(handles.figure1, handles);
catch
    handles.IsBusy=0;
    string=lasterr;
    dlg=dialog('WindowStyle', 'normal', 'Name', '������','Units','normalized','Position',[0.4 0.5 0.2 0.1]);
    dlgstart(dlg,string);
    handles.Tabs.drawedflags(1)=0;
end
end
guidata(hObject, handles);
function Klasterplot(hObject, eventdata,handles)%done
if ~handles.IsBusy
try 
    handles.IsBusy=1;
    guidata(handles.figure1, handles);
    n=numel(handles.antenna.klaster);
    if n~=0
        [prupr,ptext]=KLplot(handles.axklaster,handles.antenna.klaster);
        axes(handles.axklaster); %#ok<*MAXES>
        ytick=ylabel('Y');
        set(ytick,'Rotation',0);
        xtick=xlabel('X');
        handles.Tabs.Klaster.pRupr1=prupr;
        handles.Tabs.Klaster.pText1=ptext;
        set(ptext,'FontSize',handles.preferences.fontsize.pruprtext1,'Clipping','on');

        set(handles.tNobl,'String',strcat('����� �����������:',num2str(numel(handles.antenna.klaster))));

        for i=1:n
            datax{i}=handles.antenna.klaster(i).X;
            datay{i}=handles.antenna.klaster(i).Y;
            datadel{i}=logical(0);
        end
        set(handles.uitkledit,'Data',[datax' datay' datadel']);
        handles.Tabs.drawedflags(2)=1;
    end
    handles.IsBusy=0;
    guidata(handles.figure1, handles);
catch
    handles.IsBusy=0;
    string=lasterr;
    dlg=dialog('WindowStyle', 'normal', 'Name', '������','Units','normalized','Position',[0.4 0.5 0.2 0.1]);
    dlgstart(dlg,string);
    handles.Tabs.drawedflags(2)=0;
end
end
guidata(hObject, handles);
function Polarplot(hObject, eventdata,handles)%done
if ~handles.IsBusy
try
    handles.IsBusy=1;
    guidata(handles.figure1, handles);
    n=numel(handles.antenna.klaster);
    if n~=0
        [prupr,ptext]=KLplot(handles.axklactiv1,handles.antenna.klaster);
        set(prupr,'ButtonDownFcn','handles=guidata(gcf);handles=ChActivIZL(handles);guidata(handles.figure1,handles);');
        handles.Tabs.Klaster.pRupr2=prupr;
        handles.Tabs.Klaster.pText2=ptext;
        set(ptext,'FontSize',handles.preferences.fontsize.pruprtext2,'Clipping','on');
        [prupr,ptext]=KLplot(handles.axklactivpolar,handles.antenna.klaster);
        set(prupr,'ButtonDownFcn','handles=guidata(gcf);handles=ChPolarIZL(handles);guidata(handles.figure1,handles);');
        handles.Tabs.Klaster.pRupr3=prupr;
        handles.Tabs.Klaster.pText3=ptext;
        set(ptext,'FontSize',handles.preferences.fontsize.pruprtext3,'Clipping','on');
        handles=APPOplot(handles);
        for i=1:n
            if strcmp(handles.antenna.klaster(i).beactiv,'on')
                dataactiv{i}=logical(1);
                
            elseif strcmp(handles.antenna.klaster(i).beactiv,'off')
                dataactiv{i}=logical(0);
            end
            dataampl{i}=handles.antenna.klaster(i).ampl;
            dataphase{i}=handles.antenna.klaster(i).phase;
        end
        set(handles.uiton_off,'Data',[dataactiv']);
        set(handles.uitampl,'Data',[dataampl']);
        set(handles.uitphase,'Data',[dataphase']);
        handles.Tabs.drawedflags(3)=1;
        if handles.antenna.System.polardevision~=0
            if handles.antenna.System.polardevision==1
                set(handles.rbT,'Value',1);
            elseif handles.antenna.System.polardevision==2
                set(handles.rbL,'Value',1);
            elseif handles.antenna.System.polardevision==3
                set(handles.rbTF,'Value',1);
            elseif handles.antenna.System.polardevision==4
                set(handles.rbTL,'Value',1);    
            elseif handles.antenna.System.polardevision==5
                set(handles.rbF1F2TL,'Value',1);
            elseif handles.antenna.System.polardevision==6
                set(handles.rbF1F2LT,'Value',1);
            end
        elseif handles.antenna.System.polardevision==0
            set(handles.rbT,'Value',1);
        end
    end
    handles.IsBusy=0;
    guidata(handles.figure1, handles);
catch
    handles.IsBusy=0;
    string=lasterr;
    dlg=dialog('WindowStyle', 'normal', 'Name', '������','Units','normalized','Position',[0.4 0.5 0.2 0.1]);
    dlgstart(dlg,string);
    handles.Tabs.drawedflags(3)=0;
    
end
end
guidata(hObject, handles);
function DNplot(hObject, eventdata,handles)%done
if ~handles.IsBusy
try
    handles.IsBusy=1;
    guidata(handles.figure1, handles);
    set(handles.rbraschall,'Value',handles.antenna.CountType);
    set(handles.rbraschcurr,'Value',mod(handles.antenna.CountType+1,2));
    if handles.antenna.initflags(1)&&handles.antenna.initflags(2)&&handles.antenna.initflags(4)
        
        n=numel(handles.antenna.klaster);
        if n~=0
            handles=ClearDN(handles);
            [prupr,ptext]=KLplot(handles.axdnklpol,handles.antenna.klaster);
            handles.Tabs.Klaster.pRupr4=prupr;
            handles.Tabs.Klaster.pText4=ptext;
            set(ptext,'FontSize',handles.preferences.fontsize.pruprtext4,'Clipping','on');
            set(prupr,'ButtonDownFcn','handles=guidata(gcf);handles=ChPolarDN(handles);guidata(handles.figure1,handles);');
            [prupr,ptext]=KLplot(handles.axdnklon,handles.antenna.klaster);
            handles.Tabs.Klaster.pRupr5=prupr;
            handles.Tabs.Klaster.pText5=ptext;
            set(ptext,'FontSize',handles.preferences.fontsize.pruprtext5,'Clipping','on');
            set(prupr,'ButtonDownFcn','handles=guidata(gcf);handles=ChActivDN(handles);guidata(handles.figure1,handles);');
            handles=APDNplot(handles);
            data=[];

            schet=1;
            for i=1:n
                for j=1:4
                    if handles.antenna.DN(i).DNinit(j)
                        data{1,schet}=i;
                        data{2,schet}=handles.antenna.DN(i).Y;
                        data{3,schet}=handles.antenna.DN(i).X;
                        data{4,schet}=handles.antenna.DN(i).Diagram(j).parametrs.Psi0L*180/pi;
                        data{5,schet}=handles.antenna.DN(i).Diagram(j).parametrs.Psi0T*180/pi;
                        data{6,schet}=handles.antenna.DN(i).Diagram(j).parametrs.GaFull;
                        data{7,schet}=handles.antenna.DN(i).Diagram(j).parametrs.TH05LMain*180/pi;
                        data{8,schet}=handles.antenna.DN(i).Diagram(j).parametrs.TH05TMain*180/pi;
                        data{9,schet}=handles.antenna.DN(i).Diagram(j).parametrs.TH05L*180/pi;
                        data{10,schet}=handles.antenna.DN(i).Diagram(j).parametrs.TH05T*180/pi;
                        data{11,schet}=20*log10(handles.antenna.DN(i).Diagram(j).parametrs.UBLLleft);
                        data{12,schet}=20*log10(handles.antenna.DN(i).Diagram(j).parametrs.UBLLright);
                        data{13,schet}=20*log10(handles.antenna.DN(i).Diagram(j).parametrs.UBLTleft);
                        data{14,schet}=20*log10(handles.antenna.DN(i).Diagram(j).parametrs.UBLTright);
                        data{15,schet}=handles.antenna.DN(i).Diagram(j).parametrs.Frequency;
                        data{16,schet}=handles.antenna.DN(i).Diagram(j).parametrs.Polar;
                        schet=schet+1;
                    end
                end
            end
            set(handles.uitpartional,'Data',data);
            handles=APDNotobragenie(handles);
            handles.Tabs.drawedflags(4)=1;
        end
    elseif handles.antenna.initflags(1)&&handles.antenna.initflags(2)
        n=numel(handles.antenna.klaster);
        handles.Tabs.drawedflags(4)=1;
        if n~=0
            [prupr,ptext]=KLplot(handles.axdnklpol,handles.antenna.klaster);
            handles.Tabs.Klaster.pRupr4=prupr;
            handles.Tabs.Klaster.pText4=ptext;
            set(prupr,'FaceColor',handles.preferences.color.inaccessible);
            set(ptext,'FontSize',handles.preferences.fontsize.pruprtext4,'Clipping','on');
            [prupr,ptext]=KLplot(handles.axdnklon,handles.antenna.klaster);
            handles.Tabs.Klaster.pRupr5=prupr;
            handles.Tabs.Klaster.pText5=ptext;
            set(prupr,'FaceColor',handles.preferences.color.inaccessible);
            set(ptext,'FontSize',handles.preferences.fontsize.pruprtext5,'Clipping','on');
        end
    end
    handles.IsBusy=0;
    guidata(handles.figure1, handles);
catch
    handles.IsBusy=0;
    string=lasterr;
    dlg=dialog('WindowStyle', 'normal', 'Name', '������','Units','normalized','Position',[0.4 0.5 0.2 0.1]);
    dlgstart(dlg,string);
    handles.Tabs.drawedflags(4)=0;
end
end
guidata(hObject, handles);
function Kartaplot(hObject, eventdata,handles)%done
if ~handles.IsBusy
try
    handles.IsBusy=1;
    guidata(handles.figure1, handles);
    try %#ok<*TRYNC>
        if handles.antenna.System.Karta.otobrflag(8)&&isnan(handles.antenna.System.navparam.Level)
            level=GetAutoLevel(handles);
            handles=guidata(hObject);
            handles.antenna.System.navparam.Level=level;
            if ~isnan(handles.antenna.System.navparam.Level)
                handles.antenna.System.navflags(1)=1;
            end
        end
    end
    if handles.antenna.System.VisibleZone.Init
        delete(handles.Tabs.KartaObj.VisibleZone);
        handles.Tabs.KartaObj.VisibleZone=[];
        handles.Tabs.KartaObj.VisibleZone=PutLevelOnTheMap(handles,handles.antenna.System.VisibleZone.Contour,0,0,0,handles.preferences.color.VisibleZone,0,0,0,0);
        if handles.antenna.System.Karta.otobrflag(1)
            set(handles.Tabs.KartaObj.VisibleZone,'Visible','on');
        else
            set(handles.Tabs.KartaObj.VisibleZone,'Visible','off');
        end
    end
    %--------------------grafika_polej------------------------------------
    set(handles.chbZone,'Value',handles.antenna.System.Karta.otobrflag(1));
    set(handles.chbAuto,'Value',handles.antenna.System.Karta.otobrflag(2));
    set(handles.chbNum,'Value',handles.antenna.System.Karta.otobrflag(3));
    set(handles.chbGa,'Value',handles.antenna.System.Karta.otobrflag(4));
    set(handles.chbfill,'Value',handles.antenna.System.Karta.otobrflag(5));
    set(handles.chblabel,'Value',handles.antenna.System.Karta.otobrflag(6));
    set(handles.chbTrace,'Value',handles.antenna.System.Karta.otobrflag(7));
    set(handles.chbAutoLevel,'Value',handles.antenna.System.Karta.otobrflag(8));

    if ~isnan(handles.antenna.System.navparam.Level)
        set(handles.edLevel,'String',num2str(handles.antenna.System.navparam.Level));
    end
    if ~isnan(handles.antenna.System.navparam.muka)
        set(handles.edmuka,'String',num2str(handles.antenna.System.navparam.muka));
    end
    if ~handles.Tabs.Zadacha
        if ~isnan(handles.antenna.System.navparam.mupr)
            set(handles.edmupr,'String',num2str(handles.antenna.System.navparam.mupr));
        end
        if ~isnan(handles.antenna.System.navparam.thpr)
            set(handles.edthpr,'String',num2str(handles.antenna.System.navparam.thpr));
        end
        if ~isnan(handles.antenna.System.navparam.sigma)
            set(handles.edsigma,'String',num2str(handles.antenna.System.navparam.sigma));
        end
    else
        if handles.Tabs.CelFcn==1
            set(handles.rbconturSKO,'Value',1);
        elseif handles.Tabs.CelFcn==2
            set(handles.rbmaxPP,'Value',1);
        elseif handles.Tabs.CelFcn==3
            set(handles.rbmaxPS,'Value',1);
        end
        if handles.Tabs.AlgFcn==1
            set(handles.rbpik,'Value',1);
        elseif handles.Tabs.AlgFcn==2
            set(handles.rbgrad,'Value',1);
        elseif handles.Tabs.AlgFcn==3
            set(handles.rbpikgrad,'Value',1);
        elseif handles.Tabs.AlgFcn==4
            set(handles.rbsolve,'Value',1);
        end
    end
    %------------------------------------------------------------------
    n=numel(handles.antenna.klaster);
    if handles.antenna.initflags(1)&&handles.antenna.initflags(2)&&handles.antenna.initflags(4)
        if n~=0
            [prupr,ptext]=KLplot(handles.axkrtklon,handles.antenna.klaster);
            handles.Tabs.Klaster.pRupr6=prupr;
            handles.Tabs.Klaster.pText6=ptext;
            set(ptext,'FontSize',handles.preferences.fontsize.pruprtext6,'Clipping','on');
            set(prupr,'ButtonDownFcn','handles=guidata(gcf);handles=ChActivKarta(handles);guidata(handles.figure1,handles);');
            [prupr,ptext]=KLplot(handles.axkrtklpol,handles.antenna.klaster);
            handles.Tabs.Klaster.pRupr7=prupr;
            handles.Tabs.Klaster.pText7=ptext;
            set(ptext,'FontSize',handles.preferences.fontsize.pruprtext7,'Clipping','on');
            set(prupr,'ButtonDownFcn','handles=guidata(gcf);handles=ChPolarKarta(handles);guidata(handles.figure1,handles);');
            handles=APKartaOplot(handles);
        end
        if handles.antenna.initflags(6)
            handles.Tabs.DrawedZone=0;
            handles=PutContourOnTheMap(handles);
        end
        handles.Tabs.drawedflags(6)=1;
    elseif handles.antenna.initflags(1)&&handles.antenna.initflags(2)
        if n~=0
            [prupr,ptext]=KLplot(handles.axkrtklon,handles.antenna.klaster);
            handles.Tabs.Klaster.pRupr6=prupr;
            handles.Tabs.Klaster.pText6=ptext;
            set(prupr,'FaceColor',handles.preferences.color.inaccessible,'Clipping','on');
            set(ptext,'FontSize',handles.preferences.fontsize.pruprtext6);
            [prupr,ptext]=KLplot(handles.axkrtklpol,handles.antenna.klaster);
            handles.Tabs.Klaster.pRupr7=prupr;
            handles.Tabs.Klaster.pText7=ptext;
            set(prupr,'FaceColor',handles.preferences.color.inaccessible,'Clipping','on');
            set(ptext,'FontSize',handles.preferences.fontsize.pruprtext7);
        end
        handles.Tabs.drawedflags(6)=1;
    end
    handles.IsBusy=0;
    guidata(handles.figure1, handles);
catch %#ok<*CTCH>
    handles.IsBusy=0;
    string=lasterr; %#ok<*LERR>
    dlg=dialog('WindowStyle', 'normal', 'Name', '������','Units','normalized','Position',[0.4 0.5 0.2 0.1]);
    dlgstart(dlg,string);
    handles.Tabs.drawedflags(6)=0;
end
end
guidata(hObject, handles);

% --------------------------------------------------------------------
function mesetpref_Callback(hObject, eventdata, handles)
handles.preferences=Preferences(handles.preferences);
guidata(hObject, handles);
%handles.antenna.System.P=40;%Vatt
%handles.antenna.System.nf=0.93;

% --------------------------------------------------------------------
function mesave_Callback(hObject, eventdata, handles)
if ~handles.IsBusy
pbsaveant_Callback(hObject, eventdata, handles);
end
guidata(hObject, handles);
% --------------------------------------------------------------------
function meexit_Callback(hObject, eventdata, handles)
pos=get(handles.figure1,'Position');
handles.preferences.Pos.MainWin=pos;
s=handles.preferences;
if ~handles.IsBusy
	save('pref.sp','-struct','s');
end
close(handles.figure1);
% --------------------------------------------------------------------
function medoc_Callback(hObject, eventdata, handles)
! start help.doc & exit &
% --------------------------------------------------------------------
function medata_Callback(hObject, eventdata, handles)
string=('SatAR (Satellite Academy Research) ver 2.12. �����������: ������ �.�. ����: ����� �.�.');
dlg=dialog('WindowStyle', 'normal', 'Name', '����������','Units','normalized','Position',[0.4 0.5 0.2 0.1]);
dlgstart(dlg,string);
% --------------------------------------------------------------------
function meisbusy_Callback(hObject, eventdata, handles)
handles.IsBusy=0;
guidata(hObject, handles);
% --------------------------------------------------------------------
function mesetdefault_Callback(hObject, eventdata, handles)
handles=setpref(handles);
handles.IsBusy=0;
guidata(hObject, handles);

% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
pos=get(handles.figure1,'Position');
handles.preferences.Pos.MainWin=pos;
s=handles.preferences;
if ~handles.IsBusy
	save('pref.sp','-struct','s');
end
delete(hObject);
