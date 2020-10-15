function handles=ChActivIZL(handles)
if ~handles.IsBusy
    prupr=handles.Tabs.Klaster.pRupr2;
    ind=0;
    n=numel(handles.antenna.klaster);
    handles.Tabs.toredrawed(2)=1;
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
    for i=1:n
        if strcmp(handles.antenna.klaster(i).beactiv,'on')
            dataactiv{i}=logical(1);
        elseif strcmp(handles.antenna.klaster(i).beactiv,'off')
            dataactiv{i}=logical(0);
        end
    end
    set(handles.uiton_off,'Data',[dataactiv']);
end
end