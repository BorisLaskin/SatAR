function handles=ClearKlaster(handles)
    handles.Tabs.drawedflags(2)=0;
    if numel(handles.Tabs.Klaster.pRupr1)~=0
        delete(handles.Tabs.Klaster.pRupr1);
    end
    if numel(handles.Tabs.Klaster.pText1)~=0
        delete(handles.Tabs.Klaster.pText1);
    end
    set(handles.tNobl,'String',strcat('Число облучателей:','0'));
    datax=[];
    datay=[];
    datadel=[];
    handles.Tabs.Klaster.pRupr1=[];
    handles.Tabs.Klaster.pText1=[];
    set(handles.uitkledit,'Data',[datax' datay' datadel']);
end