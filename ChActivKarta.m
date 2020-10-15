function handles=ChActivKarta(handles)
if ~handles.IsBusy
    prupr=handles.Tabs.Klaster.pRupr6;
    ind=0;
    n=numel(handles.antenna.klaster);
    handles.Tabs.toredrawed(1)=1;
    for i=1:n
        if gco==prupr(i)
            ind=i;
        end
    end
    if strcmp(handles.antenna.klaster(ind).beactiv,'on')
        handles.antenna.klaster(ind).beactiv='off';
        set(prupr(ind),'FaceColor',handles.preferences.color.beactiv(2,:));
    elseif strcmp(handles.antenna.klaster(ind).beactiv,'off')
        handles.antenna.klaster(ind).beactiv='on';
        set(prupr(ind),'FaceColor',handles.preferences.color.beactiv(1,:));
    end
    if handles.antenna.initflags(6)
        if ~strcmp(handles.antenna.klaster(ind).beactiv,'on')
            set(handles.Tabs.KartaObj.Luch(ind),'Visible','off');
        else
            set(handles.Tabs.KartaObj.Luch(ind),'Visible','on');
        end
    end
end
end