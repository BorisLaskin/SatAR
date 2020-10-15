function handles=ClearKarta(handles)
    handles.Tabs.drawedflags(6)=0;
    if numel(handles.Tabs.Klaster.pRupr6)~=0
        delete(handles.Tabs.Klaster.pRupr6);
    end
    if numel(handles.Tabs.Klaster.pRupr7)~=0
        delete(handles.Tabs.Klaster.pRupr7);
    end
    if numel(handles.Tabs.Klaster.pText6)~=0
        delete(handles.Tabs.Klaster.pText6);
    end
    if numel(handles.Tabs.Klaster.pText7)~=0
        delete(handles.Tabs.Klaster.pText7);
    end
    handles.Tabs.Klaster.pRupr6=[];
    handles.Tabs.Klaster.pText6=[];
    handles.Tabs.Klaster.pRupr7=[];
    handles.Tabs.Klaster.pText7=[];
    if numel(handles.Tabs.KartaObj.Luch)~=0
        delete(handles.Tabs.KartaObj.Luch);
    end
    handles.Tabs.KartaObj.Luch=[];
    delete(handles.Tabs.KartaObj.VisibleZone);
    handles.Tabs.KartaObj.VisibleZone=[];
    delete(handles.Tabs.KartaObj.BaseContour);
    handles.Tabs.KartaObj.BaseContour=[];
    handles.antenna.System.BaseContour=[];
end