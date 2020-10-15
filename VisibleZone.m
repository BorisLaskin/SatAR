function handles=VisibleZone(handles)
try
    handles.IsBusy=1;
    guidata(handles.figure1, handles);
    topo=handles.Tabs.TOPO;
    if ~isnan(topo)    
        handles.antenna.System.VisibleZone.BETA=NaN;
        handles.antenna.System.VisibleZone.DAL=NaN;
        handles.antenna.System.VisibleZone.DataSTK.Long=NaN;
        handles.antenna.System.VisibleZone.DataSTK.Lat=NaN;
        handles.antenna.System.VisibleZone.Contour=NaN;

        muka=handles.antenna.System.navparam.muka*pi/180;
        Rka=handles.preferences.Karta.Rka;
        ellipsoid=handles.preferences.Karta.grs80;
        Level=handles.preferences.Karta.VisibleZoneLevel;
        [Xka,Yka,Zka] = geodetic2ecef(0,muka,Rka-ellipsoid(1),ellipsoid);

        x=linspace(-pi,pi,360);
        y=linspace(-pi/2,pi/2,180);
        [Mx,My]=meshgrid(x,y);
        topo1=zeros(size(topo));
        topo1(find(topo>0))=topo(find(topo>0)); %#ok<FNDSB>
        [MXx_y,MYx_y,MZx_y] = geodetic2ecef(My,Mx,topo1,ellipsoid);
        %---------------------------------
        BETAx_y=acos(-(MXx_y.*(Xka-MXx_y)+MYx_y.*(Yka-MYx_y)+MZx_y.*(Zka-MZx_y))./...
            (sqrt(MXx_y.^2+MYx_y.^2+MZx_y.^2).*sqrt((MXx_y-Xka).^2+(MYx_y-Yka).^2+(MZx_y-Zka).^2)))-pi/2;
        %----------------------------------
        DALx_y=sqrt((MXx_y-Xka).^2+(MYx_y-Yka).^2+(MZx_y-Zka).^2);
        DALx_y(find(BETAx_y*180/pi<Level))=1000*Rka; %#ok<FNDSB>
        %----------------------------------

        handles.antenna.System.VisibleZone.Init=1;
        handles.antenna.System.VisibleZone.BETA=BETAx_y;
        handles.antenna.System.VisibleZone.DataSTK.Long=x*180/pi;
        handles.antenna.System.VisibleZone.DataSTK.Lat=y*180/pi;
        handles.antenna.System.VisibleZone.Contour=contourc(x*180/pi,y*180/pi,BETAx_y*180/pi,[Level Level]);
        handles.antenna.System.VisibleZone.DAL=DALx_y;

        %h=PutLevelOnTheMap(handles,handles.antenna.System.VisibleZone.Contour,0,1,[0 1 0]);
    end
    handles.IsBusy=0;
catch
    handles.antenna.System.VisibleZone.Init=0;
    string=lasterr;
    dlg=dialog('WindowStyle', 'normal', 'Name', 'Ошибка','Units','normalized','Position',[0.4 0.5 0.2 0.1]);
    dlgstart(dlg,string);
    handles.IsBusy=0;
end
end