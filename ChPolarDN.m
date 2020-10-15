function handles=ChPolarDN(handles)
if ~handles.IsBusy
    prupr=handles.Tabs.Klaster.pRupr4;
    ind1=0;
    n=numel(handles.antenna.klaster);
    for i=1:n
        if gco==prupr(i)
            ind1=i;
        end
    end
    flag=0;
    currentpolar=handles.antenna.System.DNotobr(ind1).choisepolar;
    while ~flag
        currentpolar=mod(currentpolar+1,4);
        if currentpolar==0
            currentpolar=4;
        end
        if handles.antenna.System.DNotobr(ind1).DNinit(currentpolar)
            flag=1;
        end
    end
    handles.antenna.System.DNotobr(ind1).choisepolar=currentpolar;
    set(handles.Tabs.Klaster.pRupr4(ind1),'FaceColor',handles.preferences.color.polar(currentpolar,:));
    handles=APDNotobragenie(handles);
end
end