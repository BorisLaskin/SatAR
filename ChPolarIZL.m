function handles=ChPolarIZL(handles)
if ~handles.IsBusy
    prupr=handles.Tabs.Klaster.pRupr3;
    list2={'F1T','F1L','F2T','F2L'};
    ind1=0;
    n=numel(handles.antenna.klaster);
    handles.Tabs.toredrawed(2)=1;
    for i=1:n
        if gco==prupr(i)
            ind1=i;
        end
    end
    if handles.antenna.initflags(4)&&~handles.antenna.CountType
        handles.Tabs.KLconfigChanged=1;
    end
    string=strcat(handles.antenna.klaster(ind1).frequency,handles.antenna.klaster(ind1).polarization);
    ind2=find(strcmp(list2,string));
    switch ind2
        case 1
            handles.antenna.klaster(ind1).frequency='F1';
            handles.antenna.klaster(ind1).polarization='L';
        case 2
            handles.antenna.klaster(ind1).frequency='F2';
            handles.antenna.klaster(ind1).polarization='T';
        case 3
            handles.antenna.klaster(ind1).frequency='F2';
            handles.antenna.klaster(ind1).polarization='L';
        case 4
            handles.antenna.klaster(ind1).frequency='F1';
            handles.antenna.klaster(ind1).polarization='T';    
        otherwise
    end
    string=strcat(handles.antenna.klaster(ind1).frequency,handles.antenna.klaster(ind1).polarization);
    ind2=find(strcmp(list2,string));
    set(prupr(ind1),'FaceColor',handles.preferences.color.polar(ind2,:)); %#ok<FNDSB>
    if handles.Tabs.KLconfigChanged
        handles=KLConfigError(handles);
    end
end
end