function Reslevel=GetAutoLevel(handles)
handles.IsBusy=1;
guidata(handles.figure1, handles);
if handles.antenna.initflags(1)&&handles.antenna.initflags(2)&&handles.antenna.initflags(4)&&~handles.Tabs.KLconfigChanged
    list2={'F1T','F1L','F2T','F2L'};
    n=numel(handles.antenna.klaster);
    level=zeros(1,n);
    Reslevel=0;
    if n~=0
        h=waitbar(0,'Расчет автоуровня...');
        for i=1:n
            ind1=i;
            tempX1=handles.antenna.klaster(i).X;
            tempY1=handles.antenna.klaster(i).Y;
            if i~=1
                tempX2=handles.antenna.klaster(1).X;
                tempY2=handles.antenna.klaster(1).Y;
                ind2=1;
            else
                tempX2=handles.antenna.klaster(2).X;
                tempY2=handles.antenna.klaster(2).Y;
                ind2=2;
            end
            for j=1:n
                if sqrt((tempX1-handles.antenna.klaster(j).X)^2+(tempY1-handles.antenna.klaster(j).Y)^2)<sqrt((tempX1-tempX2)^2+(tempY1-tempY2)^2)&&tempX1~=handles.antenna.klaster(j).X
                    tempX2=handles.antenna.klaster(j).X;
                    tempY2=handles.antenna.klaster(j).Y;
                    ind2=j;
                end
            end
            TH=linspace(-handles.antenna.System.DNdiapazon/2,handles.antenna.System.DNdiapazon/2,handles.preferences.tol.DNotobr3D);
            [THL,THT]=meshgrid(TH);
            
            string=strcat(handles.antenna.klaster(ind1).frequency,handles.antenna.klaster(ind1).polarization);
            ind3=find(strcmp(list2,string));

            stkX1=handles.antenna.DN(ind1).Diagram(ind3).DiagramSTK.ProstrX;
            stkY1=handles.antenna.DN(ind1).Diagram(ind3).DiagramSTK.ProstrY;
            data1=handles.antenna.DN(ind1).Diagram(ind3).Prostr;
            Ga1=handles.antenna.DN(ind1).Diagram(ind3).parametrs.Ga;
            data1=20*log10(data1);
            data1=data1+Ga1;
            psi0L1=handles.antenna.DN(ind1).Diagram(ind3).parametrs.Psi0L;
            psi0T1=handles.antenna.DN(ind1).Diagram(ind3).parametrs.Psi0T;
            
            string=strcat(handles.antenna.klaster(ind2).frequency,handles.antenna.klaster(ind2).polarization);
            ind3=find(strcmp(list2,string));
            
            stkX2=handles.antenna.DN(ind2).Diagram(ind3).DiagramSTK.ProstrX;
            stkY2=handles.antenna.DN(ind2).Diagram(ind3).DiagramSTK.ProstrY;
            data2=handles.antenna.DN(ind2).Diagram(ind3).Prostr;
            Ga2=handles.antenna.DN(ind2).Diagram(ind3).parametrs.Ga;
            data2=20*log10(data2);
            data2=data2+Ga2;
            psi0L2=handles.antenna.DN(ind2).Diagram(ind3).parametrs.Psi0L;
            psi0T2=handles.antenna.DN(ind2).Diagram(ind3).parametrs.Psi0T;

            RES1=interp2(stkX1,stkY1,data1,THL,THT);
            RES2=interp2(stkX2,stkY2,data2,THL,THT);

            K=((psi0L1-psi0L2)/(psi0T1-psi0T2));
            B=psi0L1-K*psi0T1;

            tempT=linspace(psi0T1,psi0T2,150);
            tempL=K*tempT+B;

            ReRES1=interp2(THL,THT,RES1,tempL,tempT);
            ReRES2=interp2(THL,THT,RES2,tempL,tempT);
            RES=abs(ReRES1-ReRES2);
            fun=@(th)interp1(tempT,RES,th);
            dth=abs(tempT(1)-tempT(2));
            if psi0T1>psi0T2
                znak=-1;
            else
                znak=1;
            end

            th1=findLevel(fun,psi0T1,znak,dth);
            th2=findLevel(fun,psi0T2,-znak,dth);
            Level1=interp1(tempT,ReRES1,th1);
            Level2=interp1(tempT,ReRES2,th2);
            if Level1>Level2
                minth=fminsearch(fun,th1);
                level(i)=interp1(tempT,ReRES1,minth);
            else
                minth=fminsearch(fun,th2);
                level(i)=interp1(tempT,ReRES2,minth);
            end
            waitbar(i/n,h,'Расчет автоуровня...');
        end
        for i=1:n
            Reslevel=Reslevel+level(i);
        end
        Reslevel=Reslevel/n;
        close(h);
    end
else
    Reslevel=NaN;
end
handles.IsBusy=0;
guidata(handles.figure1, handles);
end
function th=findLevel(fun,start,znak,dth)
flagmin=0;
flaginc=0;
OldData=feval(fun,start);
while ~flaginc
    start=start+znak*dth;
    NewData=feval(fun,start);
    if abs(NewData)<0.5
        flagmin=1;
        OldData=NewData;
    end
    if flagmin&&NewData>OldData
        flaginc=1;
    end
end
th=start-znak*dth;
end