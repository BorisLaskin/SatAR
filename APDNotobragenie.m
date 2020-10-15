function handles=APDNotobragenie(handles)
if ~handles.IsBusy
    colors=['m','r','g','b','c','k'];
    lines=['-',':','-.','--'];
    count1=1;
    count2=1;
    count3=1;
    delete(handles.legend3);
    handles.legend3=[];
    delete(allchild(handles.axDNready));
    axes(handles.axDNready);
    hold on;
    legendstring={};
    Ymin=0;
    Ymax=1;
    n=numel(handles.antenna.klaster);
    for i=1:n
        if ~handles.antenna.System.DNotobr(i).activ
            if handles.Tabs.tipLT
                dataTH=handles.antenna.DN(i).Diagram(handles.antenna.System.DNotobr(i).choisepolar).DiagramSTK.T;
                resTH=handles.antenna.DN(i).Diagram(handles.antenna.System.DNotobr(i).choisepolar).T;
            else
                dataTH=handles.antenna.DN(i).Diagram(handles.antenna.System.DNotobr(i).choisepolar).DiagramSTK.L;
                resTH=handles.antenna.DN(i).Diagram(handles.antenna.System.DNotobr(i).choisepolar).L;
            end
            if handles.Tabs.tipDN
                resTH=20*log10(abs(resTH));
                Ymintemp=min(resTH);
                if Ymintemp<Ymin
                    Ymin=Ymintemp;
                end
            else
                resTH=abs(resTH);
            end
            TH=linspace(-handles.antenna.System.DNdiapazon/2,handles.antenna.System.DNdiapazon/2,handles.preferences.tol.DNotobr);
            RES=interp1(dataTH,resTH,TH,'line');
            string=strcat(lines(count2),colors(count1));
            count1=mymod(count1+1,6);
            if count1==1
                count2=mymod(count2+1,4);
            end
            plot(TH*180/pi,RES,string,'LineWidth',handles.preferences.GraphWidth);
            legendstring{count3,1}=strcat('IZL ¹',num2str(i),';X:',num2str(handles.antenna.klaster(i).X),';Y:',num2str(handles.antenna.klaster(i).Y));
            count3=count3+1;
        end
    end
    if handles.Tabs.tipDN
        Ymax=0;
        Ymin=-50;
    end
    if count3~=1
        handles.legend3=legend(legendstring);
        set(handles.axDNready,'YLim',[Ymin Ymax],'XLim',[-handles.antenna.System.DNdiapazon*180/4/pi handles.antenna.System.DNdiapazon*180/4/pi]);
    end
    hold off;
end
end
function res=mymod(x,module)
res=mod(x,module);
if res==0
    res=module;
end
end