function handles=GetAllDiagram(handles)
handles.IsBusy=1;
guidata(handles.figure1, handles);
%-------------define_functions-------------------------------------
stkX=handles.antenna.F1.pole.stkX;
stkY=handles.antenna.F1.pole.stkY;
D=handles.antenna.allparam.D;
F=handles.antenna.allparam.F;
C=handles.antenna.allparam.C;
R0=handles.antenna.allparam.R0;
alfa0=handles.antenna.allparam.alfa0;
KF1=2*pi/handles.antenna.allparam.lambdaF1;
KF2=2*pi/handles.antenna.allparam.lambdaF2;

GAmplGLF1=handles.antenna.F1.pole.G.AmplPoleGL;
GAmplGLF2=handles.antenna.F2.pole.G.AmplPoleGL;
VAmplGLF1=handles.antenna.F1.pole.V.AmplPoleGL;
VAmplGLF2=handles.antenna.F2.pole.V.AmplPoleGL;

Pole.FuncGF1=@(x,y)interp2(stkX,stkY,GAmplGLF1,x,y);
Pole.FuncVF1=@(x,y)interp2(stkX,stkY,VAmplGLF1,x,y);
Pole.FuncGF2=@(x,y)interp2(stkX,stkY,GAmplGLF2,x,y);
Pole.FuncVF2=@(x,y)interp2(stkX,stkY,VAmplGLF2,x,y);

%-----------------algoritm-----------------------------------------
h=waitbar(0,'Выполняется рассчет...','Units','normalized',...
    'Position',[ 0.3682 0.4518 0.2635 0.0977]);
n=numel(handles.antenna.DN);
N=4*n+4;
[dThLF1,dThTF1,Mval.GF1L,Mval.GF1T]=AproxMain(@(th1)FL(th1,0,C,D,F,alfa0,KF1,R0,Pole.FuncGF1,1,0),...
    @(th2)FT(th2,0,0,D,F,alfa0,KF1,R0,Pole.FuncGF1,1,0),handles.preferences);
waitbar(1/N,h);
[dThLF2,dThTF2,Mval.GF2L,Mval.GF2T]=AproxMain(@(th1)FL(th1,0,C,D,F,alfa0,KF2,R0,Pole.FuncGF2,1,0),...
    @(th2)FT(th2,0,0,D,F,alfa0,KF2,R0,Pole.FuncGF2,1,0),handles.preferences);
waitbar(2/N,h);
Mval.VF1L=FL(0,0,C,D,F,alfa0,KF1,R0,Pole.FuncVF1,1,0);
Mval.VF1T=FT(0,0,0,D,F,alfa0,KF1,R0,Pole.FuncVF1,1,0);
waitbar(3/N,h);
Mval.VF2L=FL(0,0,C,D,F,alfa0,KF2,R0,Pole.FuncVF2,1,0);
Mval.VF2T=FT(0,0,0,D,F,alfa0,KF2,R0,Pole.FuncVF2,1,0);
waitbar(4/N,h);
handles.antenna.DNMval=Mval;
handles=KlasterDN(handles,dThLF1,dThTF1,dThLF2,dThTF2,Pole,h,Mval);
handles.IsBusy=0;
end
%-----------------diagram_functions--------------------------------
function res=FL(Thetha,roX,C,D,F,alfa0,k,R0,Pole,ampl,phase)
    function res=integ(Th,b,x,y,C,D,F,alfa0,k,R0,Pole,ampl,phase)
        A=Pole(x,y);
        B1=k*x.*sin(Th);
        B2=(C+x+D/2)/F;
        B3=R0*b*k*sin(alfa0)*(((B2/2).^2-1)./(1+(B2/2).^2));
        B4=k*b*R0*cos(alfa0)*(B2./(1+(B2/2).^2));
        B=exp(1i*(B1+B3+B4+phase));
        res=A.*B*ampl;
    end
    xmax=@(y)sqrt((D/2)^2-y.^2);
    xmin=@(y)-sqrt((D/2)^2-y.^2);
    h=waitbar(0,'Вертикальная плоскость','Units','normalized',...
    'Position',[ 0.3682 0.5495 0.2635 0.0977]);
    for i=1:numel(Thetha)
        res(i)=quad2d(@(y,x)integ(Thetha(i),roX,x,y,C,D,F,alfa0,k,R0,Pole,ampl,phase),-D/2,D/2,xmin,xmax);
        waitbar(i/numel(Thetha),h);
    end
    close(h);
end
function res=FT(Thetha,roY,roX,D,F,alfa0,k,R0,Pole,ampl,phase)
    function res=integ(Th,b,c,x,y,F,alfa0,k,R0,Pole,ampl,phase)
        A=Pole(x,y);
        B1=k*y.*sin(Th);
        B2=y/F;
        B3=k*R0*c*sin(alfa0)*(((B2/2).^2-1)./(1+(B2/2).^2));
        B4=k*b*R0*((B2)./(1+(B2/2).^2));
        B=exp(1i*(B1+B3+B4+phase));
        res=A.*B*ampl;
    end
    ymax=@(x)sqrt((D/2)^2-x.^2);
    ymin=@(x)-sqrt((D/2)^2-x.^2);
    h=waitbar(0,'Горизонтальная плоскость','Units','normalized',...
    'Position',[ 0.3682 0.5495 0.2635 0.0977]);
    for i=1:numel(Thetha)
        res(i)=quad2d(@(x,y)integ(Thetha(i),roY,roX,x,y,F,alfa0,k,R0,Pole,ampl,phase),-D/2,D/2,ymin,ymax);
        waitbar(i/numel(Thetha),h);
    end
    close(h);
end
function handles=KlasterDN(handles,dThLF1,dThTF1,dThLF2,dThTF2,Pole,hwaitbar,Mval)
    ThEarth=0.1*pi;
    diapazon=2.9*ThEarth;
    D=handles.antenna.allparam.D;
    F=handles.antenna.allparam.F;
    C=handles.antenna.allparam.C;
    R0=handles.antenna.allparam.R0;
    alfa0=handles.antenna.allparam.alfa0;
    KF1=2*pi/handles.antenna.allparam.lambdaF1;
    KF2=2*pi/handles.antenna.allparam.lambdaF2;
    GaMainGF1=10*log10((((D^2)/4)*KF1^2)*handles.antenna.F1.pole.G.kip);
    GaMainGF2=10*log10((((D^2)/4)*KF2^2)*handles.antenna.F2.pole.G.kip);
    GaMainVF1=10*log10((((D^2)/4)*KF1^2)*handles.antenna.F1.pole.V.kip);
    GaMainVF2=10*log10((((D^2)/4)*KF2^2)*handles.antenna.F1.pole.V.kip);
    
    CountL1=diapazon/dThLF1;
    CountT1=diapazon/dThTF1;
    CountL2=diapazon/dThLF2;
    CountT2=diapazon/dThTF2;
    stkL1=linspace(-diapazon/2,diapazon/2,CountL1);
    stkT1=linspace(-diapazon/2,diapazon/2,CountT1);
    [stkX1,stkY1]=meshgrid(stkL1,stkT1);
    stkL2=linspace(-diapazon/2,diapazon/2,CountL2);
    stkT2=linspace(-diapazon/2,diapazon/2,CountT2);
    [stkX2,stkY2]=meshgrid(stkL2,stkT2);
    
    n=numel(handles.antenna.DN);
    N=4*n+4;
    
    for i=1:n
        if handles.antenna.DN(i).DNinit(1)
            str=strcat('Выполняется рассчет...',num2str(i),' облучатель F1 Gor');
            waitbar((4*i)/N,hwaitbar,str);
            if isnan(handles.antenna.DN(i).Diagram(1).L)
                resL=abs(FL(stkL1,handles.antenna.klaster(i).Y,C,D,F,alfa0,KF1,R0,...
                    Pole.FuncGF1,handles.antenna.klaster(i).ampl,0));
                handles.antenna.DN(i).Diagram(1).L=resL;
                for j=1:n
                    if handles.antenna.klaster(i).Y==handles.antenna.klaster(j).Y
                        handles.antenna.DN(j).Diagram(1).L=resL;
                    end
                end
            end
            resT=abs(FT(stkT1,handles.antenna.klaster(i).X,handles.antenna.klaster(i).Y,...
                D,F,alfa0,KF1,R0,Pole.FuncGF1,handles.antenna.klaster(i).ampl,0));
            resL=handles.antenna.DN(i).Diagram(1).L;
            handles.antenna.DN(i).Diagram(1).T=resT;
                        
            Struct=DNwatching(resL,resT,stkL1,stkT1,handles.preferences);
            tol=handles.preferences.tol.findPSI.level;
            MvalL=Struct.MvalL;
            MvalT=Struct.MvalT;
            res3D=AmplDN3D(resL,resT,stkL1,stkT1,stkX1,stkY1,Struct.Psi0L,Struct.Psi0T,MvalL,MvalT);
            
            GaL=20*log10(MvalL/Mval.GF1L);
            GaT=20*log10(MvalT/Mval.GF1T);
            %---changed---
            resL=(resL/MvalL)*10^(GaT/20);
            resT=(resT/MvalT)*10^(GaL/20);
            Struct.UBLLleft=(Struct.UBLLleft/MvalL);
            Struct.UBLLright=(Struct.UBLLright/MvalL);
            Struct.UBLTleft=(Struct.UBLTleft/MvalT);
            Struct.UBLTright=(Struct.UBLTright/MvalT);
            fun1=@(th)interp1(stkL1,resL,th,'spline');
            fun2=@(th)interp1(stkT1,resT,th,'spline');
            
            boundleft=Findlevel2(fun1,Struct.Psi0L,-3,-1,tol);
            boundright=Findlevel2(fun1,Struct.Psi0L,-3,1,tol);
            TH05Lmain=abs(boundleft-boundright);
            
            boundleft=Findlevel2(fun2,Struct.Psi0T,-3,-1,tol);
            boundright=Findlevel2(fun2,Struct.Psi0T,-3,1,tol);
            TH05Tmain=abs(boundleft-boundright);
            %---changed---
            %------------------prisvaivanie---------------------------
            handles.antenna.DN(i).Diagram(1).Prostr=res3D;
            handles.antenna.DN(i).Diagram(1).L=resL;
            handles.antenna.DN(i).Diagram(1).T=resT;
            
            handles.antenna.DN(i).Diagram(1).DiagramSTK.L=stkL1;
            handles.antenna.DN(i).Diagram(1).DiagramSTK.T=stkT1;
            handles.antenna.DN(i).Diagram(1).DiagramSTK.ProstrX=stkX1;
            handles.antenna.DN(i).Diagram(1).DiagramSTK.ProstrY=stkY1;
            
            handles.antenna.DN(i).Diagram(1).parametrs.Psi0L=Struct.Psi0L;
            handles.antenna.DN(i).Diagram(1).parametrs.Psi0T=Struct.Psi0T;
            handles.antenna.DN(i).Diagram(1).parametrs.GaFull=GaL+GaT+GaMainGF1;
            handles.antenna.DN(i).Diagram(1).parametrs.TH05LMain=TH05Lmain;
            handles.antenna.DN(i).Diagram(1).parametrs.TH05TMain=TH05Tmain;
            handles.antenna.DN(i).Diagram(1).parametrs.TH05L=Struct.TH05L;
            handles.antenna.DN(i).Diagram(1).parametrs.TH05T=Struct.TH05T;
            handles.antenna.DN(i).Diagram(1).parametrs.UBLLleft=Struct.UBLLleft;
            handles.antenna.DN(i).Diagram(1).parametrs.UBLLright=Struct.UBLLright;
            handles.antenna.DN(i).Diagram(1).parametrs.UBLTleft=Struct.UBLTleft;
            handles.antenna.DN(i).Diagram(1).parametrs.UBLTright=Struct.UBLTright;
            handles.antenna.DN(i).Diagram(1).parametrs.Polar='Gor';
            handles.antenna.DN(i).Diagram(1).parametrs.Frequency=handles.antenna.allparam.F1;
            handles.antenna.DN(i).Diagram(1).parametrs.Ga=GaL+GaT;
        end
        if handles.antenna.DN(i).DNinit(2)
            str=strcat('Выполняется рассчет...',num2str(i),' облучатель F1 Ver');
            waitbar((4*i+1)/N,hwaitbar,str);
            if isnan(handles.antenna.DN(i).Diagram(2).L)
                resL=abs(FL(stkL1,handles.antenna.klaster(i).Y,C,D,F,alfa0,KF1,R0,...
                    Pole.FuncVF1,handles.antenna.klaster(i).ampl,0));
                handles.antenna.DN(i).Diagram(2).L=resL;
                for j=1:n
                    if handles.antenna.klaster(i).Y==handles.antenna.klaster(j).Y
                        handles.antenna.DN(j).Diagram(2).L=resL;
                    end
                end
            end
            resT=abs(FT(stkT1,handles.antenna.klaster(i).X,handles.antenna.klaster(i).Y,...
                D,F,alfa0,KF1,R0,Pole.FuncVF1,handles.antenna.klaster(i).ampl,0));
            resL=handles.antenna.DN(i).Diagram(2).L;
            handles.antenna.DN(i).Diagram(2).T=resT;
            
            Struct=DNwatching(resL,resT,stkL1,stkT1,handles.preferences);
            tol=handles.preferences.tol.findPSI.level;
            MvalL=Struct.MvalL;
            MvalT=Struct.MvalT;
            res3D=AmplDN3D(resL,resT,stkL1,stkT1,stkX1,stkY1,Struct.Psi0L,Struct.Psi0T,MvalL,MvalT);
            
            GaL=20*log10(MvalL/Mval.VF1L);
            GaT=20*log10(MvalT/Mval.VF1T);
            
            resL=(resL/MvalL)*10^(GaT/20);
            resT=(resT/MvalT)*10^(GaL/20);
            Struct.UBLLleft=(Struct.UBLLleft/MvalL);
            Struct.UBLLright=(Struct.UBLLright/MvalL);
            Struct.UBLTleft=(Struct.UBLTleft/MvalT);
            Struct.UBLTright=(Struct.UBLTright/MvalT);
            fun1=@(th)interp1(stkL1,resL,th,'spline');
            fun2=@(th)interp1(stkT1,resT,th,'spline');
            
            boundleft=Findlevel2(fun1,Struct.Psi0L,-3,-1,tol);
            boundright=Findlevel2(fun1,Struct.Psi0L,-3,1,tol);
            TH05Lmain=abs(boundleft-boundright);
            
            boundleft=Findlevel2(fun2,Struct.Psi0T,-3,-1,tol);
            boundright=Findlevel2(fun2,Struct.Psi0T,-3,1,tol);
            TH05Tmain=abs(boundleft-boundright);
            %------------------prisvaivanie---------------------------
            handles.antenna.DN(i).Diagram(2).Prostr=res3D;
            handles.antenna.DN(i).Diagram(2).L=resL;
            handles.antenna.DN(i).Diagram(2).T=resT;
            
            handles.antenna.DN(i).Diagram(2).DiagramSTK.L=stkL1;
            handles.antenna.DN(i).Diagram(2).DiagramSTK.T=stkT1;
            handles.antenna.DN(i).Diagram(2).DiagramSTK.ProstrX=stkX1;
            handles.antenna.DN(i).Diagram(2).DiagramSTK.ProstrY=stkY1;
            
            handles.antenna.DN(i).Diagram(2).parametrs.Psi0L=Struct.Psi0L;
            handles.antenna.DN(i).Diagram(2).parametrs.Psi0T=Struct.Psi0T;
            handles.antenna.DN(i).Diagram(2).parametrs.GaFull=GaL+GaT+GaMainVF1;
            handles.antenna.DN(i).Diagram(2).parametrs.TH05LMain=TH05Lmain;
            handles.antenna.DN(i).Diagram(2).parametrs.TH05TMain=TH05Tmain;
            handles.antenna.DN(i).Diagram(2).parametrs.TH05L=Struct.TH05L;
            handles.antenna.DN(i).Diagram(2).parametrs.TH05T=Struct.TH05T;
            handles.antenna.DN(i).Diagram(2).parametrs.UBLLleft=Struct.UBLLleft;
            handles.antenna.DN(i).Diagram(2).parametrs.UBLLright=Struct.UBLLright;
            handles.antenna.DN(i).Diagram(2).parametrs.UBLTleft=Struct.UBLTleft;
            handles.antenna.DN(i).Diagram(2).parametrs.UBLTright=Struct.UBLTright;
            handles.antenna.DN(i).Diagram(2).parametrs.Polar='Ver';
            handles.antenna.DN(i).Diagram(2).parametrs.Frequency=handles.antenna.allparam.F1;
            handles.antenna.DN(i).Diagram(2).parametrs.Ga=GaL+GaT;
            
        end
        if handles.antenna.DN(i).DNinit(3)
            str=strcat('Выполняется рассчет...',num2str(i),' облучатель F2 Gor');
            waitbar((4*i+2)/N,hwaitbar,str);
            if isnan(handles.antenna.DN(i).Diagram(3).L)
                resL=abs(FL(stkL2,handles.antenna.klaster(i).Y,C,D,F,alfa0,KF2,R0,...
                    Pole.FuncGF2,handles.antenna.klaster(i).ampl,0));
                handles.antenna.DN(i).Diagram(3).L=resL;
                for j=1:n
                    if handles.antenna.klaster(i).Y==handles.antenna.klaster(j).Y
                        handles.antenna.DN(j).Diagram(3).L=resL;
                    end
                end
            end
            resT=abs(FT(stkT2,handles.antenna.klaster(i).X,handles.antenna.klaster(i).Y,...
                D,F,alfa0,KF2,R0,Pole.FuncGF2,handles.antenna.klaster(i).ampl,0));
            resL=handles.antenna.DN(i).Diagram(3).L;
            handles.antenna.DN(i).Diagram(3).T=resT;
            
            Struct=DNwatching(resL,resT,stkL2,stkT2,handles.preferences);
            tol=handles.preferences.tol.findPSI.level;
            MvalL=Struct.MvalL;
            MvalT=Struct.MvalT;
            res3D=AmplDN3D(resL,resT,stkL2,stkT2,stkX2,stkY2,Struct.Psi0L,Struct.Psi0T,MvalL,MvalT);
            
            GaL=20*log10(MvalL/Mval.GF2L);
            GaT=20*log10(MvalT/Mval.GF2T);
            
            resL=(resL/MvalL)*10^(GaT/20);
            resT=(resT/MvalT)*10^(GaL/20);
            Struct.UBLLleft=(Struct.UBLLleft/MvalL);
            Struct.UBLLright=(Struct.UBLLright/MvalL);
            Struct.UBLTleft=(Struct.UBLTleft/MvalT);
            Struct.UBLTright=(Struct.UBLTright/MvalT);
            fun1=@(th)interp1(stkL2,resL,th,'spline');
            fun2=@(th)interp1(stkT2,resT,th,'spline');
            
            boundleft=Findlevel2(fun1,Struct.Psi0L,-3,-1,tol);
            boundright=Findlevel2(fun1,Struct.Psi0L,-3,1,tol);
            TH05Lmain=abs(boundleft-boundright);
            
            boundleft=Findlevel2(fun2,Struct.Psi0T,-3,-1,tol);
            boundright=Findlevel2(fun2,Struct.Psi0T,-3,1,tol);
            TH05Tmain=abs(boundleft-boundright);
            %------------------prisvaivanie---------------------------
            handles.antenna.DN(i).Diagram(3).Prostr=res3D;
            handles.antenna.DN(i).Diagram(3).L=resL;
            handles.antenna.DN(i).Diagram(3).T=resT;
            
            handles.antenna.DN(i).Diagram(3).DiagramSTK.L=stkL2;
            handles.antenna.DN(i).Diagram(3).DiagramSTK.T=stkT2;
            handles.antenna.DN(i).Diagram(3).DiagramSTK.ProstrX=stkX2;
            handles.antenna.DN(i).Diagram(3).DiagramSTK.ProstrY=stkY2;
            
            handles.antenna.DN(i).Diagram(3).parametrs.Psi0L=Struct.Psi0L;
            handles.antenna.DN(i).Diagram(3).parametrs.Psi0T=Struct.Psi0T;
            handles.antenna.DN(i).Diagram(3).parametrs.GaFull=GaL+GaT+GaMainGF2;
            handles.antenna.DN(i).Diagram(3).parametrs.TH05LMain=TH05Lmain;
            handles.antenna.DN(i).Diagram(3).parametrs.TH05TMain=TH05Tmain;
            handles.antenna.DN(i).Diagram(3).parametrs.TH05L=Struct.TH05L;
            handles.antenna.DN(i).Diagram(3).parametrs.TH05T=Struct.TH05T;
            handles.antenna.DN(i).Diagram(3).parametrs.UBLLleft=Struct.UBLLleft;
            handles.antenna.DN(i).Diagram(3).parametrs.UBLLright=Struct.UBLLright;
            handles.antenna.DN(i).Diagram(3).parametrs.UBLTleft=Struct.UBLTleft;
            handles.antenna.DN(i).Diagram(3).parametrs.UBLTright=Struct.UBLTright;
            handles.antenna.DN(i).Diagram(3).parametrs.Polar='Gor';
            handles.antenna.DN(i).Diagram(3).parametrs.Frequency=handles.antenna.allparam.F2;
            handles.antenna.DN(i).Diagram(3).parametrs.Ga=GaL+GaT;
        end
        if handles.antenna.DN(i).DNinit(4)
            str=strcat('Выполняется рассчет...',num2str(i),' облучатель F2 Ver');
            waitbar((4*i+3)/N,hwaitbar,str);
            if isnan(handles.antenna.DN(i).Diagram(4).L)
                resL=abs(FL(stkL2,handles.antenna.klaster(i).Y,C,D,F,alfa0,KF2,R0,...
                    Pole.FuncVF2,handles.antenna.klaster(i).ampl,0));
                handles.antenna.DN(i).Diagram(4).L=resL;
                for j=1:n
                    if handles.antenna.klaster(i).Y==handles.antenna.klaster(j).Y
                        handles.antenna.DN(j).Diagram(4).L=resL;
                    end
                end
            end
            resT=abs(FT(stkT2,handles.antenna.klaster(i).X,handles.antenna.klaster(i).Y,...
                D,F,alfa0,KF2,R0,Pole.FuncVF2,handles.antenna.klaster(i).ampl,0));
            resL=handles.antenna.DN(i).Diagram(4).L;
            handles.antenna.DN(i).Diagram(4).T=resT;
            
            Struct=DNwatching(resL,resT,stkL2,stkT2,handles.preferences);
            tol=handles.preferences.tol.findPSI.level;
            MvalL=Struct.MvalL;
            MvalT=Struct.MvalT;
            res3D=AmplDN3D(resL,resT,stkL2,stkT2,stkX2,stkY2,Struct.Psi0L,Struct.Psi0T,MvalL,MvalT);
            
            GaL=20*log10(MvalL/Mval.VF2L);
            GaT=20*log10(MvalT/Mval.VF2T);
            
            resL=(resL/MvalL)*10^(GaT/20);
            resT=(resT/MvalT)*10^(GaL/20);
            Struct.UBLLleft=(Struct.UBLLleft/MvalL);
            Struct.UBLLright=(Struct.UBLLright/MvalL);
            Struct.UBLTleft=(Struct.UBLTleft/MvalT);
            Struct.UBLTright=(Struct.UBLTright/MvalT);
            fun1=@(th)interp1(stkL2,resL,th,'spline');
            fun2=@(th)interp1(stkT2,resT,th,'spline');
            
            boundleft=Findlevel2(fun1,Struct.Psi0L,-3,-1,tol);
            boundright=Findlevel2(fun1,Struct.Psi0L,-3,1,tol);
            TH05Lmain=abs(boundleft-boundright);
            
            boundleft=Findlevel2(fun2,Struct.Psi0T,-3,-1,tol);
            boundright=Findlevel2(fun2,Struct.Psi0T,-3,1,tol);
            TH05Tmain=abs(boundleft-boundright);
            %------------------prisvaivanie---------------------------
            handles.antenna.DN(i).Diagram(4).Prostr=res3D;
            handles.antenna.DN(i).Diagram(4).L=resL;
            handles.antenna.DN(i).Diagram(4).T=resT;
            
            handles.antenna.DN(i).Diagram(4).DiagramSTK.L=stkL2;
            handles.antenna.DN(i).Diagram(4).DiagramSTK.T=stkT2;
            handles.antenna.DN(i).Diagram(4).DiagramSTK.ProstrX=stkX2;
            handles.antenna.DN(i).Diagram(4).DiagramSTK.ProstrY=stkY2;
            
            handles.antenna.DN(i).Diagram(4).parametrs.Psi0L=Struct.Psi0L;
            handles.antenna.DN(i).Diagram(4).parametrs.Psi0T=Struct.Psi0T;
            handles.antenna.DN(i).Diagram(4).parametrs.GaFull=GaL+GaT+GaMainVF2;
            handles.antenna.DN(i).Diagram(4).parametrs.TH05LMain=TH05Lmain;
            handles.antenna.DN(i).Diagram(4).parametrs.TH05TMain=TH05Tmain;
            handles.antenna.DN(i).Diagram(4).parametrs.TH05L=Struct.TH05L;
            handles.antenna.DN(i).Diagram(4).parametrs.TH05T=Struct.TH05T;
            handles.antenna.DN(i).Diagram(4).parametrs.UBLLleft=Struct.UBLLleft;
            handles.antenna.DN(i).Diagram(4).parametrs.UBLLright=Struct.UBLLright;
            handles.antenna.DN(i).Diagram(4).parametrs.UBLTleft=Struct.UBLTleft;
            handles.antenna.DN(i).Diagram(4).parametrs.UBLTright=Struct.UBLTright;
            handles.antenna.DN(i).Diagram(4).parametrs.Polar='Ver';
            handles.antenna.DN(i).Diagram(4).parametrs.Frequency=handles.antenna.allparam.F2;
            handles.antenna.DN(i).Diagram(4).parametrs.Ga=GaL+GaT;
        end
    end
    close(hwaitbar);
    
end
function res=AmplDN3D(resL,resT,stkL,stkT,stkX,stkY,psi0L,psi0T,MvalL,MvalT)
    %funL=@(th)(interp1(stkL,resL,th,'spline'))/MvalL;
    funL=@(th)(interp1(stkL,resL,th))/MvalL;
    %funT=@(th)(interp1(stkT,resT,th,'spline'))/MvalT;
    funT=@(th)(interp1(stkT,resT,th))/MvalT;
    fi=atan(tan(stkY-psi0T)./tan(stkX-psi0L));
    fi(find(stkX-psi0L<0))=fi(find(stkX-psi0L<0))+pi; %#ok<FNDSB>
    ind=isnan(fi);
    [ind_i,ind_j]=find(ind==1);
    n=numel(ind_i);
    if n~=0
        for i=1:n
            fi(ind_i(i),ind_j(i))=0;
        end
    end
    th=atan(tan(stkX-psi0L)./cos(fi));
    th(find(stkX-psi0L==0))=abs(stkY(find(stkX-psi0L==0))-psi0T); %#ok<FNDSB>
    
    FL=abs(feval(funL,th.*sign(cos(fi))+psi0L));
    FT=abs(feval(funT,th.*sign(sin(fi))+psi0T));
    res=sqrt((FL.*cos(fi)).^2+(FT.*sin(fi)).^2);
    
    ind=isnan(res);
    [ind_i,ind_j]=find(ind==1);
    n=numel(ind_i);
    if n~=0
        for i=1:n
            res(ind_i(i),ind_j(i))=0;
        end
    end
end
%-----------------Poiskovie_functions------------------------------
function [dThL,dThT,MvalL,MvalT]=AproxMain(funL,funT,preferences)
    THEarth=0.1*pi;
    MvalL=feval(funL,0);
    MvalT=feval(funT,0);
    CEnter=0;
    thetha=linspace(-THEarth/2,THEarth/2,25);
    resL=abs(feval(funL,thetha));
    resT=abs(feval(funT,thetha));
    
    fun1=@(th)interp1(thetha,resL,th,'spline');
    fun2=@(th)interp1(thetha,resT,th,'spline');
    tol=preferences.tol.findPSI.Nglotsch;

    
    boundleft=Findlevel(fun1,CEnter,-3,-1,preferences.tol.findPSI.level);
    boundright=Findlevel(fun1,CEnter,-3,1,preferences.tol.findPSI.level);
    dThL=abs(boundright-boundleft)/tol;
            
    boundleft=Findlevel(fun2,CEnter,-3,-1,preferences.tol.findPSI.level);
    boundright=Findlevel(fun2,CEnter,-3,1,preferences.tol.findPSI.level);
    dThT=abs(boundright-boundleft)/tol;
end
function Struct=DNwatching(ResL,ResT,stkL,stkT,preferences)
    [MvalL,indL]=max(ResL);
    [MvalT,indT]=max(ResT);
    fun1=@(th)interp1(stkL,ResL,th,'spline');
    fun2=@(th)interp1(stkT,ResT,th,'spline');
    
    tol=preferences.tol.findPSI.Nglotsch;
    tol1=preferences.tol.findPSI.level;
    
    CEnterL=stkL(indL);
    dataL=Proizvodnya(stkL(indL),tol,tol1,fun1);
    flag=0;
    while ~flag
        if dataL.UBLleft<MvalL&&dataL.UBLright<MvalL
            flag=1;
            boundleft=Findlevel(fun1,CEnterL,-3,-1,preferences.tol.findPSI.level);
            boundright=Findlevel(fun1,CEnterL,-3,1,preferences.tol.findPSI.level);
        elseif dataL.UBLleft>dataL.UBLright
            CEnterL=dataL.UBLthleft;
            MvalL=dataL.UBLleft;
            dataL=Proizvodnya(CEnterL,tol,tol1,fun1);
        elseif dataL.UBLleft<dataL.UBLright
            CEnterL=dataL.UBLthright;
            MvalL=dataL.UBLright;
            dataL=Proizvodnya(CEnterL,tol,tol1,fun1);
        elseif dataL.UBLleft==dataL.UBLright
            flag=1;
            CEnterL=(dataL.UBLthleft+dataL.UBLthright)/2;
            MvalL=dataL.UBLright;
            boundleft=Findlevel(fun1,dataL.UBLthleft,-3,-1,preferences.tol.findPSI.level);
            boundright=Findlevel(fun1,dataL.UBLthright,-3,1,preferences.tol.findPSI.level);
        end
    end
    
    Struct.Psi0L=CEnterL;
    Struct.UBLLleft=dataL.UBLleft;
    Struct.UBLLright=dataL.UBLright;
    Struct.TH05L=abs(boundleft-boundright);
    Struct.MvalL=MvalL;
    
    CEnterT=stkT(indT);
    dataT=Proizvodnya(stkT(indT),tol,tol1,fun2);
    flag=0;
    while ~flag
        if dataT.UBLleft<MvalT&&dataT.UBLright<MvalT
            flag=1;
            boundleft=Findlevel(fun2,CEnterT,-3,-1,preferences.tol.findPSI.level);
            boundright=Findlevel(fun2,CEnterT,-3,1,preferences.tol.findPSI.level);
            
        elseif dataT.UBLleft>dataT.UBLright
            CEnterT=dataT.UBLthleft;
            MvalT=dataT.UBLleft;
            dataT=Proizvodnya(CEnterT,tol,tol1,fun2);
        elseif dataT.UBLleft<dataT.UBLright
            CEnterT=dataT.UBLthright;
            MvalT=dataT.UBLright;
            dataT=Proizvodnya(CEnterT,tol,tol1,fun2);
        elseif dataT.UBLleft==dataT.UBLright
            flag=1;
            CEnterT=(dataT.UBLthleft+dataT.UBLthright)/2;
            MvalT=dataT.UBLright;
            boundleft=Findlevel(fun2,dataT.UBLthleft,-3,-1,preferences.tol.findPSI.level);
            boundright=Findlevel(fun2,dataT.UBLthright,-3,1,preferences.tol.findPSI.level);
            
        end
    end
    
    Struct.Psi0T=CEnterT;
    Struct.UBLTleft=dataT.UBLleft;
    Struct.UBLTright=dataT.UBLright;
    Struct.TH05T=abs(boundleft-boundright);
    Struct.MvalT=MvalT;
end
%-----------------Help_functions----------------------------------
function data=Proizvodnya(centrth,tol,tol1,fun)
    MAXval=abs(feval(fun,centrth));
    th=Findlevel(fun,centrth,-3,-1,tol1);
    
    dth=abs(centrth-th)/tol/2;
        
    flaginc=0;
    flagdec=0;
    oldF=MAXval;
    oldth=centrth;
    olddFdth=0;
    while ~flagdec
        newth=oldth+dth;
        newF=feval(fun,newth);
        newF=abs(newF);
        newdFdth=(newF-oldF)/dth;
        if newdFdth>olddFdth&&abs(newdFdth-olddFdth)>10^-4
            flaginc=1;
        end
        if flaginc&&newdFdth<olddFdth&&abs(newdFdth-olddFdth)>10^-4
            flagdec=1;
            data.UBLright=oldF;
            data.UBLthright=oldth;
        end
        oldth=newth;
        oldF=newF;
        olddFdth=newdFdth;
    end

   flaginc=0;
    flagdec=0;
    oldF=MAXval;
    oldth=centrth;
    olddFdth=0;
    while ~flagdec
        newth=oldth-dth;
        newF=feval(fun,newth);
        newF=abs(newF);
        newdFdth=(newF-oldF)/dth;
        if newdFdth>olddFdth&&abs(newdFdth-olddFdth)>10^-4
            flaginc=1;
        end
        if flaginc&&newdFdth<olddFdth&&abs(newdFdth-olddFdth)>10^-4
            flagdec=1;
            data.UBLleft=oldF;
            data.UBLthleft=oldth;
        end
        oldth=newth;
        oldF=newF;
        olddFdth=newdFdth;
    end        

end
function th=Findlevel(fun,startth,level,sign,tol)
    res=[];
    Maxdata=abs(feval(fun,startth));
    lastdata=0;
    h=0.01*pi;
    while numel(res)==0
        newdata=abs(feval(fun,startth+h*sign));
        newdata=20*log10(newdata/Maxdata);
        if tol>abs(level-newdata)
            res=startth+h*sign;
        elseif level<newdata
            startth=startth+h*sign;
            if lastdata<level
                h=h/2;
            elseif lastdata>level
                h=h*2;
            end
        elseif level>newdata
            h=h/2;
        end
        lastdata=newdata;
    end
    th=res;
end
function th=Findlevel2(fun,startth,level,sign,tol)
    res=[];
    lastdata=0;
    h=0.01*pi;
    if 20*log10(abs(feval(fun,startth)))>level
        while numel(res)==0
            newdata=abs(feval(fun,startth+h*sign));
            newdata=20*log10(newdata);
            if tol>abs(level-newdata)
                res=startth+h*sign;
            elseif level<newdata
                startth=startth+h*sign;
                if lastdata<level
                    h=h/2;
                elseif lastdata>level
                    h=h*2;
                end
            elseif level>newdata
                h=h/2;
            end
            lastdata=newdata;
        end
        th=res;
    else
        th=startth;
    end
end