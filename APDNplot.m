function handles=APDNplot(handles)
    for i=1:numel(handles.antenna.klaster)
        set(handles.Tabs.Klaster.pRupr5(i),'FaceColor',...
            handles.preferences.color.beactiv((handles.antenna.System.DNotobr(i).activ+1),:));
    end
    
    for i=1:numel(handles.antenna.klaster)
        set(handles.Tabs.Klaster.pRupr4(i),'FaceColor',...
            handles.preferences.color.polar(handles.antenna.System.DNotobr(i).choisepolar,:));
    end
end