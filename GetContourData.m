function handles=GetContourData(handles)
if ~handles.Tabs.KLconfigChanged&&handles.Tabs.topoflag
    if numel(handles.Tabs.KartaObj.Luch)~=0
        delete(handles.Tabs.KartaObj.Luch);
    end
    handles.Tabs.KartaObj.Luch=[];
    handles.IsBusy=1;
    guidata(handles.figure1, handles);
    list1={'F1','F2'};
    list2={'F1T','F1L','F2T','F2L'};
    %----------------------oslablenie-----------------------------------------
    LevelZone=handles.preferences.Karta.VisibleZoneLevel;
    BETAx_y=handles.antenna.System.VisibleZone.BETA;
    LDOPx_yF1=gammaH2O(handles.antenna.baseparam.F1)*lH2O(BETAx_y)+gammaO2(handles.antenna.baseparam.F1)*lO2(BETAx_y);
    LDOPx_yF2=gammaH2O(handles.antenna.baseparam.F2)*lH2O(BETAx_y)+gammaO2(handles.antenna.baseparam.F2)*lO2(BETAx_y);
    LDOPx_yF1(find(BETAx_y*180/pi<LevelZone))=200; %#ok<FNDSB>
    LDOPx_yF2(find(BETAx_y*180/pi<LevelZone))=200; %#ok<FNDSB>
    DAL=handles.antenna.System.VisibleZone.DAL;
    
    %----------------------shag_setki-----------------------------------------
    topo=handles.Tabs.TOPO;
    
    muka=handles.antenna.System.navparam.muka*pi/180;
    mupr=handles.antenna.System.navparam.mupr*pi/180;
    thpr=handles.antenna.System.navparam.thpr*pi/180;
    sigma=handles.antenna.System.navparam.sigma*pi/180;
    
    Rka=handles.preferences.Karta.Rka;
    ellipsoid=handles.preferences.Karta.grs80;
    DataLevel=handles.antenna.System.navparam.Level;
    
    n=numel(handles.antenna.klaster);
    ind=1;
    tempX=handles.antenna.klaster(ind).X;
    tempY=handles.antenna.klaster(ind).Y;
    Dist=sqrt((tempX)^2+(tempY)^2);
    for i=1:n
        tempdist=sqrt((handles.antenna.klaster(i).X)^2+(handles.antenna.klaster(i).Y)^2);
        if tempdist<Dist
            Dist=tempdist;
            ind=i;
        end
    end
    psip=handles.antenna.DN(ind).Diagram(handles.antenna.System.DNotobr(ind).choisepolar).parametrs.TH05LMain/2;
    dTh=atan(tan(psip)*(Rka-ellipsoid(1))/ellipsoid(1))*180/pi;
    dTh=dTh/handles.preferences.Karta.Ntochek;
    if dTh>1
        dTh=1;
    end
    numTh=ceil(180/abs(dTh));
    numMu=numTh*2;
    %----------------------zadinie_setki--------------------------------------
    
    X=linspace(-180,180,numMu);
    Y=linspace(-90,90,numTh);
    [MX,MY]=meshgrid(X,Y);
    topo1=zeros(size(topo));
    topo1(find(topo>0))=topo(find(topo>0)); %#ok<FNDSB>
    [stkX,stkY]=meshgrid(linspace(-180,180,360),linspace(-90,90,180));
    NewTopo=interp2(stkX,stkY,topo1,MX,MY);
    NewDAL=interp2(stkX,stkY,DAL,MX,MY);
    NewBETA=interp2(stkX,stkY,BETAx_y,MX,MY);
    NewLDOPF1=interp2(stkX,stkY,LDOPx_yF1,MX,MY);
    NewLDOPF2=interp2(stkX,stkY,LDOPx_yF2,MX,MY);
    
    
    [MXx_y,MYx_y,MZx_y] = geodetic2ecef(MY*pi/180,MX*pi/180,NewTopo,ellipsoid);
    [Xka,Yka,Zka] = geodetic2ecef(0,muka,Rka-ellipsoid(1),ellipsoid);
    
    MXkax_y=cos(muka)*(MXx_y-Xka)+sin(muka)*(MYx_y-Yka);
    MYkax_y=-sin(muka)*(MXx_y-Xka)+cos(muka)*(MYx_y-Yka);
    MZkax_y=MZx_y-Zka;
    
    PsiPx_y=atan(-MZkax_y./MXkax_y);
    PsiBx_y=atan(-MYkax_y./MXkax_y);
    %--------------ishodnij massiv analiza popadani9--------------------
    if handles.Tabs.Zadacha&&numel(handles.antenna.System.BaseContour)>0&&handles.antenna.System.navflags(1)&&handles.antenna.System.navflags(2)
        %------------kontur->ugli otkoneni9 KA--------------------------
        BaseCLong=handles.antenna.System.BaseContour(1,:);
        BaseCLat=handles.antenna.System.BaseContour(2,:);
        BaseCTopo=interp2(stkX,stkY,topo1,BaseCLong,BaseCLat);
        [MXBC,MYBC,MZBC] = geodetic2ecef(BaseCLat*pi/180,BaseCLong*pi/180,BaseCTopo,ellipsoid);
        MXBCka=cos(muka)*(MXBC-Xka)+sin(muka)*(MYBC-Yka);
        MYBCka=-sin(muka)*(MXBC-Xka)+cos(muka)*(MYBC-Yka);
        MZBCka=MZBC-Zka;
        PsiPBC=atan(-MZBCka./MXBCka);
        PsiBBC=atan(-MYBCka./MXBCka);
        %-----------centr_mass contura---------------------------------
        IN=inpolygon(MX,MY,BaseCLong,BaseCLat);
        if numel(find(IN==1))>0
            M=numel(find(IN==1));
            [n1,n2]=size(IN);
            Xcm=0;
            Ycm=0;
            for i=1:n1
                for j=1:n2
                    if IN(i,j)
                        Xcm=Xcm+MX(i,j)/M;
                        Ycm=Ycm+MY(i,j)/M;
                    end
                end
            end
            %------------------pik_base_param------------------------------
            PikXmax=max(max(MX(IN)));PikXmax=PikXmax(1);
            PikYmax=max(max(MY(IN)));PikYmax=PikYmax(1);
            PikdX=abs(PikXmax-Xcm);
            PikdY=abs(PikYmax-Ycm);
            mnog=handles.preferences.Karta.pikmnog;
            PikXmas=[(Xcm-PikdX)/mnog:1:(Xcm+PikdX)/mnog]; %#ok<*NBRAK>
            PikYmas=[(Ycm-PikdY)/mnog:1:(Ycm+PikdY)/mnog];
            [PikX,PikY,PikSigma]=ndgrid(PikXmas*pi/180,PikYmas*pi/180,[-90:handles.preferences.Karta.sigmascan:90]*pi/180);
            %--------------aprox_diag---------------------------------------
            DN=reinterpDN(handles);
            handles.Tabs.klowibka=[];
            guidata(handles.figure1, handles);
            func11=@(x)MaxPP(ones(1,n),x(1),x(2),x(3),handles.figure1,0,1,PsiPBC,PsiBBC,Xka,Yka,Zka,DN);
            owibka=zeros(size(PikX));
            switch handles.Tabs.AlgFcn
                case 1
                    %-------------------pik-------------------------------
                    wait=waitbar(0,'Расчет параметров наведения...');
                    [n1,n2,n3]=size(PikX);
                    tstart=tic;
                    string='';
                    for i1=1:n1
                        for i2=1:n2
                            for i3=1:n3
                                if handles.Tabs.CelFcn==2
                                    owibka(i1,i2,i3)=MaxPP(ones(1,n),PikX(i1,i2,i3),PikY(i1,i2,i3),PikSigma(i1,i2,i3),handles.figure1,1,1,PsiPBC,PsiBBC,Xka,Yka,Zka,DN);
                                end
                                waitbar((i3+(i2-1)*n3+(i1-1)*n2*n3)/n1/n2/n3,wait,strcat('Расчет параметров наведения...',string));
                            end
                            tellapsed=toc(tstart);
                            endtime=(n1*n2*n3/(i3+(i2-1)*n3+(i1-1)*n2*n3)-1)*tellapsed/3600;
                            if endtime>1
                                string=strcat('Окончание через:',num2str(endtime,3),' ч.');
                            else
                                string=strcat('Окончание через:',num2str(endtime*60,3),' ч.');
                            end
                        end
                    end
                    temp=0;
                    for i1=1:n1
                        for i2=1:n2
                            for i3=1:n3
                                if owibka(i1,i2,i3)>temp
                                    temp=owibka(i1,i2,i3);
                                    mupr=PikX(i1,i2,i3);thpr=PikY(i1,i2,i3);sigma=PikSigma(i1,i2,i3);
                                end
                            end
                        end
                    end
                    close(wait);
                    %-------------------pik_end-------------------------------
                case 2
                    %-------------------grad-------------------------------
                    handles.Tabs.procwait=waitbar(0,'Расчет параметров наведения...');
                    guidata(handles.figure1, handles);
                    if handles.Tabs.CelFcn==2
                        [X,~]=fminsearch(@(x)-func11(x),[Xcm*pi/180,Ycm*pi/180,0]);
                        mupr=X(1);thpr=X(2);sigma=X(3);
                    end
                    close(handles.Tabs.procwait);
                    %-------------------grad_end-------------------------------
                case 3
                    %-------------------pi_grad---------------------------
                    wait=waitbar(0,'Расчет параметров наведения...');
                    [n1,n2,n3]=size(PikX);
                    tstart=tic;
                    string='';
                    for i1=1:n1
                        for i2=1:n2
                            for i3=1:n3
                                if handles.Tabs.CelFcn==2
                                    owibka(i1,i2,i3)=MaxPP(ones(1,n),PikX(i1,i2,i3),PikY(i1,i2,i3),PikSigma(i1,i2,i3),handles.figure1,1,1,PsiPBC,PsiBBC,Xka,Yka,Zka,DN);
                                end
                                waitbar((i3+(i2-1)*n3+(i1-1)*n2*n3)/n1/n2/n3,wait,strcat('Расчет параметров наведения...',string));
                            end
                            tellapsed=toc(tstart);
                            endtime=(n1*n2*n3/(i3+(i2-1)*n3+(i1-1)*n2*n3)-1)*tellapsed/3600;
                            if endtime>1
                                string=strcat('Окончание через:',num2str(endtime,3),' ч.');
                            else
                                string=strcat('Окончание через:',num2str(endtime*60,3),' ч.');
                            end
                        end
                    end
                    temp=0;
                    for i1=1:n1
                        for i2=1:n2
                            for i3=1:n3
                                if owibka(i1,i2,i3)>temp
                                    temp=owibka(i1,i2,i3);
                                    mupr=PikX(i1,i2,i3);thpr=PikY(i1,i2,i3);sigma=PikSigma(i1,i2,i3);
                                end
                            end
                        end
                    end
                    close(wait);
                    handles.Tabs.procwait=waitbar(0,'Расчет параметров наведения...');
                    guidata(handles.figure1, handles);
                    if handles.Tabs.CelFcn==2
                        [X,~]=fminsearch(@(x)-func11(x),[mupr,thpr,sigma]);
                        mupr=X(1);thpr=X(2);sigma=X(3);
                    end
                    close(handles.Tabs.procwait);
                    %-------------------pi_grad_end---------------------------
            end
            if handles.Tabs.CelFcn==2
                MaxPP(ones(1,n),mupr,thpr,sigma,handles.figure1,1,1,PsiPBC,PsiBBC,Xka,Yka,Zka,DN);
            end
            handles=guidata(handles.figure1);
            n=numel(handles.antenna.klaster);
            if handles.Tabs.CelFcn==2
                klowibka=handles.Tabs.klowibka;
                for i=1:n
                    if klowibka(i)<handles.preferences.Karta.maxPPporog
                        handles.antenna.klaster(i).beactiv='off';
                    else
                        handles.antenna.klaster(i).beactiv='on';
                    end
                end
            end
            handles=APKartaOplot(handles);
            handles.antenna.System.navparam.mupr=mupr*180/pi;
            handles.antenna.System.navparam.thpr=thpr*180/pi;
            handles.antenna.System.navparam.sigma=sigma*180/pi;
            if ~isnan(handles.antenna.System.navparam.mupr)
                set(handles.edmupr,'String',num2str(handles.antenna.System.navparam.mupr));
            end
            if ~isnan(handles.antenna.System.navparam.thpr)
                set(handles.edthpr,'String',num2str(handles.antenna.System.navparam.thpr));
            end
            if ~isnan(handles.antenna.System.navparam.sigma)
                set(handles.edsigma,'String',num2str(handles.antenna.System.navparam.sigma));
            end
            %---------------------------------------------------------------
            handles.Tabs.procwait=[];
            handles.Tabs.procwaitstat=0;
        else
            dlg=dialog('WindowStyle', 'normal', 'Name', 'Ошибка','Units','normalized','Position',[0.4 0.5 0.2 0.1]);
            string='Пустой контур.';
            dlgstart(dlg,string); 
        end
    elseif handles.Tabs.Zadacha
        dlg=dialog('WindowStyle', 'normal', 'Name', 'Ошибка','Units','normalized','Position',[0.4 0.5 0.2 0.1]);
        string='Заданы не все параметры.';
        dlgstart(dlg,string);     
    end
    if handles.antenna.System.navflags
        handles.antenna.System.Contour.DN=[];
        handles.antenna.System.Contour.DNSTK.Long=NaN;
        handles.antenna.System.Contour.DNSTK.Lat=NaN;
        X=linspace(-180,180,numMu);
        Y=linspace(-90,90,numTh);

        [Xpr,Ypr,Zpr] = geodetic2ecef(thpr,mupr,interp2(stkX,stkY,topo1,mupr,thpr),ellipsoid);
        Xprka=cos(muka)*(Xpr-Xka)+sin(muka)*(Ypr-Yka);
        Yprka=-sin(muka)*(Xpr-Xka)+cos(muka)*(Ypr-Yka);
        Zprka=Zpr-Zka;
        
        PsiP0=atan(-Zprka/Xprka);
        PsiB0=atan(-Yprka/Xprka);
        n=numel(handles.antenna.klaster);
        
        handles.antenna.System.Contour.DNSTK.Long=X;
        handles.antenna.System.Contour.DNSTK.Lat=Y;
        %---------------
        COSMATR=[cos(PsiP0)*cos(PsiB0),-cos(PsiP0)*sin(PsiB0),-sin(PsiP0);...
            sin(PsiP0)*cos(PsiB0)*sin(sigma)+sin(PsiB0)*cos(sigma),-sin(PsiP0)*sin(PsiB0)*sin(sigma)+cos(PsiB0)*cos(sigma),cos(PsiP0)*sin(sigma);...
            sin(PsiP0)*cos(PsiB0)*cos(sigma)-sin(PsiB0)*sin(sigma),-sin(PsiP0)*sin(PsiB0)*cos(sigma)-cos(PsiB0)*sin(sigma),cos(PsiP0)*cos(sigma)];            
        %---------------
        
        PsiPx_y1=PsiPx_y;
        PsiBx_y1=PsiBx_y;
        %----------------navedenie_v_tochku_pricelivaniya------------
        PsiPx_y=PsiPx_y-PsiP0;
        PsiBx_y=PsiBx_y-PsiB0;
        %----------------povorot_osej--------------------------------
        STK=PsiBx_y+1i*PsiPx_y;
        Ang=angle(STK)+sigma;
        Mod=abs(STK);
        PsiBx_y=Mod.*cos(Ang);
        PsiPx_y=Mod.*sin(Ang);
        %---------------
        PotokP=handles.antenna.System.P*handles.antenna.System.nf/16/pi/pi./(NewDAL*10^3).^2;
        PotokPF1=PotokP*handles.antenna.allparam.lambdaF1^2;
        PotokPF2=PotokP*handles.antenna.allparam.lambdaF2^2;
        PotokPF1=10*log10(PotokPF1)-NewLDOPF1;
        PotokPF2=10*log10(PotokPF2)-NewLDOPF2;
        wait=waitbar(0,'Расчет проекций ДН...');
        for i=1:n
            flagerr=0;
            string=strcat(handles.antenna.klaster(i).frequency,handles.antenna.klaster(i).polarization);
            polarind=find(strcmp(list2,string));
            freqind=find(strcmp(list1,handles.antenna.klaster(i).frequency));
            stkL=handles.antenna.DN(i).Diagram(polarind).DiagramSTK.ProstrX;%L - ploskost'
            stkT=handles.antenna.DN(i).Diagram(polarind).DiagramSTK.ProstrY;%T - ploskost'
            data=handles.antenna.DN(i).Diagram(polarind).Prostr;
            GaFull=handles.antenna.DN(i).Diagram(polarind).parametrs.GaFull;

            %----------------perevod v dB--------------------------------
            data=20*log10(data);
            %data=data+GaFull;
            MaxData=0;
            %------------------------------------------------------------
            NewData=interp2(stkL,stkT,data,PsiPx_y,PsiBx_y);
            NewData(find(NewBETA*180/pi<LevelZone))=-100; %#ok<FNDSB>
            
            if numel(contourc(X,Y,NewData,[DataLevel DataLevel]))<=0
                flagerr=1;
                MaxData=GaFull;
            end
            NewData1=NewData+GaFull;
            
            if handles.antenna.System.Karta.otobrflag(7)
                if freqind==1
                    PotokP1=PotokPF1;
                elseif freqind==2
                    PotokP1=PotokPF2;
                end
                NewData1=NewData1+PotokP1;
            end
            %handles.antenna.System.Contour.DN(i).Data=NewData1;
            handles.antenna.System.Contour.DN(i).Contour=[];
            handles.antenna.System.Contour.DN(i).MaxData=MaxData;
            handles.antenna.System.Contour.DN(i).MaxDataX=0;
            handles.antenna.System.Contour.DN(i).MaxDataY=0;
            if ~flagerr
                MaxData=max(max(NewData1));
                [indi,indj]=find(NewData1==MaxData);
                dGa=NewData(indi(1),indj(1));
                MaxData=MaxData-dGa;
                handles.antenna.System.Contour.DN(i).MaxData=MaxData;
                handles.antenna.System.Contour.DN(i).Contour=contourc(X,Y,...
                    NewData1,[MaxData+DataLevel MaxData+DataLevel]);
                handles.antenna.System.Contour.DN(i).MaxDataX=MX(indi(1),indj(1));
                handles.antenna.System.Contour.DN(i).MaxDataY=MY(indi(1),indj(1));
            end
            wait=waitbar(i/n,wait,'Расчет проекций ДН...');
        end
        close(wait);
    else
        dlg=dialog('WindowStyle', 'normal', 'Name', 'Ошибка','Units','normalized','Position',[0.4 0.5 0.2 0.1]);
        string='Заданы не все параметры.';
        dlgstart(dlg,string);
    end
    handles.IsBusy=0;
    handles.antenna.initflags(6)=1;
    handles.Tabs.DrawedZone=0;
    guidata(handles.figure1, handles);
else
    dlg=dialog('WindowStyle', 'normal', 'Name', 'Ошибка','Units','normalized','Position',[0.4 0.5 0.2 0.1]);
	string='Восстановите конфигурацию кластера.';
	dlgstart(dlg,string);
end
end
function leng=lH2O(beta)
    Re=8500;
    leng=sqrt((Re*sin(beta)).^2+2*Re*2)-Re*sin(beta);
end
function leng=lO2(beta)
    Re=8500;
    leng=sqrt((Re*sin(beta)).^2+2*Re*4)-Re*sin(beta);
end
function gamma=gammaH2O(F)
x=[0 11 14 17.7 21.2 27.5 31.0 35 37 40];
y=[0 0.0099 0.023 0.066 0.2 0.16 0.11 0.06 0.035 0];
gamma=interp1(x,y,F,'spline');
end
function gamma=gammaO2(F)
x=[0 11 14 17.7 21.2 27.5 31.0 40];
y=[0 0.123 0.0142 0.0165 0.02 0.026 0.032 0.04];
gamma=interp1(x,y,F,'spline');
end
function res=MaxContour(Matrix)
limit = size(Matrix, 2);
i=1;
chet=0;
while (i < limit)
    chet=chet+1;
    npoints(chet) = Matrix(2, i);  %#ok<AGROW>
    curi(chet) = i; %#ok<AGROW,NASGU>
    nexti = i + npoints(chet) + 1;
    i = nexti;
end
[~,ind]=max(npoints);
res=Matrix(:,curi(ind)+1:curi(ind)+npoints(ind));
end
function DN=reinterpDN(handles)
n=numel(handles.antenna.klaster);
list2={'F1T','F1L','F2T','F2L'};
wait=waitbar(0,'Реинтерполяция диаграмм...');
for i=1:n
    string=strcat(handles.antenna.klaster(i).frequency,handles.antenna.klaster(i).polarization);
    polarind=find(strcmp(list2,string));
    stkL=handles.antenna.DN(i).Diagram(polarind).DiagramSTK.ProstrX;%L - ploskost'
    stkT=handles.antenna.DN(i).Diagram(polarind).DiagramSTK.ProstrY;%T - ploskost'
    data=handles.antenna.DN(i).Diagram(polarind).Prostr;
    Ga=handles.antenna.DN(i).Diagram(polarind).parametrs.Ga;
    DataLevel=handles.antenna.System.navparam.Level;
    DLevel=10^(DataLevel/20);
    
    L=stkL(1,:);
    T=stkT(:,1);
    Luch=contourc(L,T,data,[DLevel DLevel]);
    Luch = MaxContour(Luch);
    Ldata = Luch(1,:);
    Tdata = Luch(2,:);
    
    Ldiap=[stkL(1,1),stkL(1,end),abs(stkL(1,1)-stkL(1,2))];
    Tdiap=[stkT(1,1),stkT(end,1),abs(stkT(1,1)-stkT(2,1))];
    L=linspace(Ldiap(1),Ldiap(2),floor(abs(Ldiap(1)-Ldiap(2))/Ldiap(3))*handles.preferences.Karta.Ntochek1);
    T=linspace(Tdiap(1),Tdiap(2),floor(abs(Tdiap(1)-Tdiap(2))/Tdiap(3))*handles.preferences.Karta.Ntochek1);
    [X,Y]=meshgrid(L,T);
    X=X(:);Y=Y(:);
    IN1=inpolygon(X,Y,Ldata,Tdata);
    X=X(IN1);Y=Y(IN1);
    
    NewData=interp2(stkL,stkT,data,X,Y);
    DN(i).stkL=X; %#ok<*AGROW>
    DN(i).stkT=Y;
    DN(i).data=NewData;
    DN(i).Ga=Ga;
    
    waitbar(i/n,wait,'Реинтерполяция диаграмм...');
end
close(wait);
end
function owibka=MaxPP(klon,mupr,thpr,sigma,figure1,flagpic,~,PsiPBC,PsiBBC,Xka,Yka,Zka,DN)
handles=guidata(figure1);
owibka=zeros(size(klon));
if ~flagpic
	handles.Tabs.procwaitstat=mod(handles.Tabs.procwaitstat+1/100,1);
	waitbar(handles.Tabs.procwaitstat,handles.Tabs.procwait,'Идет расчет ...');
	guidata(figure1, handles);
end
if thpr<pi/2&&thpr>-pi/2
    topo=handles.Tabs.TOPO;
    ellipsoid=handles.preferences.Karta.grs80;
    muka=handles.antenna.System.navparam.muka*pi/180;

    topo1=zeros(size(topo));
    topo1(find(topo>0))=topo(find(topo>0)); %#ok<FNDSB>
    [stkX,stkY]=meshgrid(linspace(-180,180,360),linspace(-90,90,180));
    [Xpr,Ypr,Zpr] = geodetic2ecef(thpr,mupr,interp2(stkX,stkY,topo1,mupr,thpr),ellipsoid);
    Xprka=cos(muka)*(Xpr-Xka)+sin(muka)*(Ypr-Yka);
    Yprka=-sin(muka)*(Xpr-Xka)+cos(muka)*(Ypr-Yka);
    Zprka=Zpr-Zka;
    PsiP0=atan(-Zprka/Xprka);
    PsiB0=atan(-Yprka/Xprka);

    n=numel(handles.antenna.klaster);
    for i=1:n
        if klon(i)
            stkL=DN(i).stkL;%L - ploskost'
            stkT=DN(i).stkT;%T - ploskost'
            data=DN(i).data;
            
            stkL=stkL(:);
            stkT=stkT(:);
            data=data(:);
            
            idealP=cumsum(data);
            idealP=idealP(end);
            %-----------
            stkL=stkL+PsiP0;
            stkT=stkT+PsiB0;
            STK=stkT+1i*stkL;
            Ang=angle(STK)-sigma;
            Mod=abs(STK);
            stkT=Mod.*cos(Ang);
            stkL=Mod.*sin(Ang);
            %---------------
            IN2=inpolygon(stkL,stkT,PsiPBC,PsiBBC);
            data=data(IN2);
            if numel(find(IN2==1))>0
                realP=cumsum(data);
                realP=realP(end);
            else
                realP=0;
            end
            owibka(i)=realP/idealP;
        end
    end

    schet=0;
    for i=1:n
        %if owibka(i)<handles.preferences.Karta.maxPPporog
        if owibka(i)==0
            schet=schet+1;
        end
    end
    handles.Tabs.klowibka=owibka;
    guidata(figure1, handles);
    owibka=cumsum(owibka);
    owibka=owibka(end);
    owibka=owibka*schet/n;
else
    owibka=0;
end

end