function handles=ChActivDN(handles)
if ~handles.IsBusy
    prupr=handles.Tabs.Klaster.pRupr5;
    ind=0;
    n=numel(handles.antenna.klaster);
    for i=1:n
        if gco==prupr(i)
            ind=i;
        end
    end
    handles.antenna.System.DNotobr(ind).activ=mod(handles.antenna.System.DNotobr(ind).activ+1,2);
    set(handles.Tabs.Klaster.pRupr5(ind),'FaceColor',...
        handles.preferences.color.beactiv((handles.antenna.System.DNotobr(ind).activ+1),:));
    handles=APDNotobragenie(handles);
end
end