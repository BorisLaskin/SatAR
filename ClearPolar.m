function handles=ClearPolar(handles)
    handles.Tabs.drawedflags(3)=0;
    if numel(handles.Tabs.Klaster.pRupr2)~=0
        delete(handles.Tabs.Klaster.pRupr2);
    end
    if numel(handles.Tabs.Klaster.pRupr3)~=0
        delete(handles.Tabs.Klaster.pRupr3);
    end
    if numel(handles.Tabs.Klaster.pText2)~=0
        delete(handles.Tabs.Klaster.pText2);
    end
    if numel(handles.Tabs.Klaster.pText3)~=0
        delete(handles.Tabs.Klaster.pText3);
    end
    handles.Tabs.Klaster.pRupr2=[];
    handles.Tabs.Klaster.pText2=[];
    handles.Tabs.Klaster.pRupr3=[];
    handles.Tabs.Klaster.pText3=[];
    dataactiv=[];
    set(handles.uiton_off,'Data',dataactiv');
    dataphase=[];
    set(handles.uitphase,'Data',dataphase');
    dataampl=[];
    set(handles.uitampl,'Data',dataampl');
end