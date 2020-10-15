function handles=StartUpFcn(handles)
h=waitbar(0,'Идет загрузка программы...');
%--------------------------------------------------------------------
try
    handles.preferences=load('pref.sp','-mat');
catch
    string=('Ошибка открытия файла настроек, файл поврежден');
	dlg=dialog('WindowStyle', 'normal', 'Name', 'Ошибка','Units','normalized','Position',[0.4 0.5 0.2 0.1]);
	dlgstart(dlg,string);
    handles=setpref(handles);
end
%-------------------------------------------------------------------
handles.antenna.paramflags=[0 0 0 0 0 0 0];
handles.antenna.initflags=[0 0 0 0 0 0];
handles.antenna.baseparam=struct('D',NaN,'C',NaN,'F',NaN,'alfa0',NaN,'R0',NaN,'F1',NaN,'F2',NaN);
handles.antenna.allparam=struct('D',NaN,'C',NaN,'F',NaN,'alfa0',NaN,'alfa1',NaN,'alfa2',NaN,'alfas',NaN,...
'R0',NaN,'F1',NaN,'F2',NaN,'lambdaF1',NaN,'lambdaF2',NaN);
handles.antenna.klaster=[];
%handles.Tabs.visible.oldflags=[1 1 1 1 1 1];
handles.Tabs.visible.oldflags=[0 0 0 0 0 0];
%handles.Tabs.visible.flags=[0 0 0 0 0 0];
handles.Tabs.drawedflags=[0 0 0 0 0 0];

handles.Tabs.toredrawed=[0 0];
handles.Tabs.DrawedZone=0;
handles.Tabs.chosepolar=1;
handles.Tabs.KLconfigChanged=0; %izmenenie dannih klastera posle rascheta
handles.Tabs.KLconfigChangedPrint=0;
handles.Tabs.tipDN=0;%0 - normal; 1 - dec
handles.Tabs.tipLT=0;%0 - L ploskost', 1 - T ploskost'
handles.Tabs.Zadacha=0;%0 - Modelirovanie; 1 - ing analiz
handles.Tabs.CelFcn=2;% 1 - sko; 2 - max PP; 3 - max PS
handles.Tabs.AlgFcn=1;% 1 - pik; 2 - grad; 3 - pikgrad; 4 - VKM
handles.Tabs.tipKart=0;% 0 - orto; 1 - globe
handles.Tabs.Klaster.pRupr1=[];
handles.Tabs.Klaster.pText1=[];
handles.Tabs.Klaster.pRupr2=[];
handles.Tabs.Klaster.pText2=[];
handles.Tabs.Klaster.pRupr3=[];
handles.Tabs.Klaster.pText3=[];
handles.Tabs.Klaster.pRupr4=[];
handles.Tabs.Klaster.pText4=[];
handles.Tabs.Klaster.pRupr5=[];
handles.Tabs.Klaster.pText5=[];
handles.Tabs.Klaster.pRupr6=[];
handles.Tabs.Klaster.pText6=[];
handles.Tabs.Klaster.pRupr7=[];
handles.Tabs.Klaster.pText7=[];
handles.Tabs.procwait=[];
handles.Tabs.procwaitstat=0;
handles.Tabs.klowibka=[];
handles.IsBusy=0;
handles.Optim.D=[];
handles.Optim.C=[];
handles.Optim.F=[];
handles.Optim.alfa0=[];
handles.Optim.R0=[];
handles.Optim.n=[];
handles.Optim.v=[];
handles.Optim.kip=[];
handles.Optim.flags=[1 1 1];
handles.legend1=[];
handles.legend2=[];
handles.legend3=[];
handles.antenna.System.P=40;%Vatt
handles.antenna.System.nf=0.93;
handles.antenna.System.polardevision=0; % 0 - net; 1 - vse T; 2 - vse L; 3 - F1F2LT
handles.antenna.CountType=1;% 1 - polnij rashet; 0 - tekuwaya konfiguraciya
ThEarth=0.1*pi;
handles.antenna.System.DNdiapazon=2*ThEarth;
handles.antenna.System.navflags=[0 0 0 0 0];
handles.antenna.System.navparam=struct('Level',NaN,'muka',NaN,'mupr',NaN,'thpr',NaN,'sigma',NaN);
handles.antenna.System.Karta.otobrflag=[1 1 1 0 0 0 0 1];%1 - Zona vidimosti; 2 - AutoRachet; 3 - Numbers
%4 - Ga; 5 - Fill contour; 6 - Level label; 7 - uchet traasi; 8 - AutoLevel
try
    thisdir=cd;
    cd('MapData');
    load topo1;
    cd(thisdir);
    handles.Tabs.topoflag=1;
    handles.Tabs.TOPO=circshift(topo,[0 180])*10^-3;
catch
    cd(thisdir);
    handles.Tabs.topoflag=0;
    handles.Tabs.TOPO=NaN;
    string=lasterr;
    dlg=dialog('WindowStyle', 'normal', 'Name', 'Ошибка','Units','normalized','Position',[0.4 0.5 0.2 0.1]);
    dlgstart(dlg,string);
end
handles.antenna.System.VisibleZone.Init=0;
handles.antenna.System.VisibleZone.BETA=NaN;
handles.antenna.System.VisibleZone.DAL=NaN;
handles.antenna.System.VisibleZone.DataSTK.Long=NaN;
handles.antenna.System.VisibleZone.DataSTK.Lat=NaN;
handles.antenna.System.VisibleZone.Contour=NaN;%1 stroka long; 2 - lat
handles.Tabs.KartaObj.VisibleZone=[];

handles.antenna.System.Contour.DN=[];
handles.antenna.System.Contour.DNSTK.Long=NaN;
handles.antenna.System.Contour.DNSTK.Lat=NaN;
handles.Tabs.KartaObj.Luch=[];
handles.antenna.System.BaseContour=[];
handles.Tabs.KartaObj.BaseContour=[];
%|-----------------------figure1-------------------------------------
set(handles.figure1,'Units','normalized','Name','SatAR 2.23 Universe');
set(handles.figure1,'Position',handles.preferences.Pos.MainWin,'Color',handles.preferences.color.MainWinC);
%set(handles.figure1,'Renderer','painters');
set(handles.figure1,'Renderer','zbuffer');
%set(handles.figure1,'Renderer','OpenGL');
%set(handles.figure1,'Renderer','None');
set(handles.figure1,'Visible','off');
%||-----------------------uipgeometr-------------------------------------
handles=StartUpFcnGeometr(handles);
set(handles.uipgeometr,'Visible','off');
waitbar(1/9,h,'Идет загрузка программы...');
%||-----------------------uipklaster-------------------------------------
handles=StartUpFcnKlaster(handles);
set(handles.uipklaster,'Visible','off');
waitbar(2/9,h,'Идет загрузка программы...');
%||-----------------------uippolar-------------------------------------
handles=StartUpFcnPolar(handles);
set(handles.uippolar,'Visible','off');
waitbar(3/9,h,'Идет загрузка программы...');
%||-----------------------uipdn-------------------------------------
handles=StartUpFcnDN(handles);
set(handles.uipdn,'Visible','off');
waitbar(4/9,h,'Идет загрузка программы...');
%||-----------------------uiptrace-------------------------------------
handles=StartUpFcnTrace(handles);
set(handles.uiptrace,'Visible','off');
%||-----------------------uipkarta-------------------------------------
handles=StartUpFcnKarta(handles);
waitbar(5/9,h,'Идет загрузка программы...');
handles=MapCreate(handles,h);
set(handles.uipkarta,'Visible','off');
%--------------------------------------------------------------------
%--------------------------------------------------------------------
waitbar(9/9,h,'Идет загрузка программы...');
set(handles.figure1,'Visible','on');
%handles=ChangeTab(handles);
%--------------------------------------------------------------------
close(h);
end