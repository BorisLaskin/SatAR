function handles=APKartaOplot(handles)
list1={'on','off'};
    list2={'F1T','F1L','F2T','F2L','F1C+','F1C-','F2C+','F2C-'};
    
    for i=1:numel(handles.antenna.klaster)
            ind=find(strcmp(list1,handles.antenna.klaster(i).beactiv));
            set(handles.Tabs.Klaster.pRupr6(i),'FaceColor',handles.preferences.color.beactiv(ind,:));
    end
    
    for i=1:numel(handles.antenna.klaster)
        string=strcat(handles.antenna.klaster(i).frequency,handles.antenna.klaster(i).polarization);
        ind=find(strcmp(list2,string));
        set(handles.Tabs.Klaster.pRupr7(i),'FaceColor',handles.preferences.color.polar(ind,:));
    end
end