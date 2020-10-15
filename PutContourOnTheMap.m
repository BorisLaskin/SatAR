function handles=PutContourOnTheMap(handles)
%pervoe dejstvie ochistka ob'ectov 
if ~handles.Tabs.KLconfigChanged&&handles.Tabs.topoflag
    handles.IsBusy=1;
    guidata(handles.figure1, handles);
    n=numel(handles.antenna.klaster);
    list2={'F1T','F1L','F2T','F2L'};

    if handles.antenna.initflags(6)&&~handles.Tabs.DrawedZone
        if numel(handles.Tabs.KartaObj.Luch)~=0
            delete(handles.Tabs.KartaObj.Luch);
        end
        handles.Tabs.KartaObj.Luch=[];
        guidata(handles.figure1, handles);
        for i=1:n
            string=strcat(handles.antenna.klaster(i).frequency,handles.antenna.klaster(i).polarization);
            ind2=find(strcmp(list2,string));
            handles.Tabs.KartaObj.Luch(i)=PutLevelOnTheMap(handles,handles.antenna.System.Contour.DN(i).Contour,...
                handles.antenna.System.Karta.otobrflag(5),handles.antenna.System.Karta.otobrflag(3),handles.antenna.System.Karta.otobrflag(3),...
                handles.preferences.color.polar(ind2,:),handles.antenna.System.Contour.DN(i).MaxData,...
                handles.antenna.System.Contour.DN(i).MaxDataX,handles.antenna.System.Contour.DN(i).MaxDataY,i); %#ok<FNDSB>
            set(handles.Tabs.KartaObj.Luch(i),'Visible','off');

        end
        for i=1:n
            if ~strcmp(handles.antenna.klaster(i).beactiv,'on')
                set(handles.Tabs.KartaObj.Luch(i),'Visible','off');
            else
                set(handles.Tabs.KartaObj.Luch(i),'Visible','on');
            end
        end
        handles.Tabs.DrawedZone=1;
    end

    handles.IsBusy=0;
end
end