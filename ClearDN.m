function handles=ClearDN(handles)
    handles.Tabs.drawedflags(4)=0;
    if numel(handles.Tabs.Klaster.pRupr4)~=0
        delete(handles.Tabs.Klaster.pRupr4);
    end
    if numel(handles.Tabs.Klaster.pRupr5)~=0
        delete(handles.Tabs.Klaster.pRupr5);
    end
    if numel(handles.Tabs.Klaster.pText4)~=0
        delete(handles.Tabs.Klaster.pText4);
    end
    if numel(handles.Tabs.Klaster.pText5)~=0
        delete(handles.Tabs.Klaster.pText5);
    end
    handles.Tabs.Klaster.pRupr4=[];
    handles.Tabs.Klaster.pText4=[];
    handles.Tabs.Klaster.pRupr5=[];
    handles.Tabs.Klaster.pText5=[];
    datax=[];
    set(handles.uitpartional,'Data',[datax']);
    delete(handles.legend3);
    handles.legend3=[];
    delete(allchild(handles.axDNready));
end