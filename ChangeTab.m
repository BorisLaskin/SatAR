function handles=ChangeTab(handles)
    flags=handles.Tabs.visible.flags;
    oldflags=handles.Tabs.visible.oldflags;
    %-------------------------------------------------------------------
    if oldflags(1)
        if ~flags(1)
        set(handles.uipgeometr,'Visible','off');
        set(handles.tbgeometr,'BackgroundColor',handles.preferences.color.tabs(1,:));
        end
    elseif flags(1)
        set(handles.uipgeometr,'Visible','on');
        set(handles.tbgeometr,'BackgroundColor',handles.preferences.color.tabs(2,:));
    end
    %-------------------------------------------------------------------
    if oldflags(2)
        if ~flags(2)
        set(handles.uipklaster,'Visible','off');
        set(handles.tbklaster,'BackgroundColor',handles.preferences.color.tabs(1,:));
        end
    elseif flags(2)
        set(handles.uipklaster,'Visible','on');
        set(handles.tbklaster,'BackgroundColor',handles.preferences.color.tabs(2,:));
    end
    %-------------------------------------------------------------------
    if oldflags(3)
        if ~flags(3)
        set(handles.uippolar,'Visible','off');
        set(handles.tbpolar,'BackgroundColor',handles.preferences.color.tabs(1,:));
        end
    elseif flags(3)
        set(handles.uippolar,'Visible','on');
        set(handles.tbpolar,'BackgroundColor',handles.preferences.color.tabs(2,:));
    end
    %-------------------------------------------------------------------
    if oldflags(4)
        if ~flags(4)
        set(handles.uipdn,'Visible','off');
        set(handles.tbdn,'BackgroundColor',handles.preferences.color.tabs(1,:));
        end
    elseif flags(4)
        set(handles.uipdn,'Visible','on');
        set(handles.tbdn,'BackgroundColor',handles.preferences.color.tabs(2,:));
    end
    %-------------------------------------------------------------------
    if oldflags(5)
        if ~flags(5)
        set(handles.uiptrace,'Visible','off');
        set(handles.tbtrace,'BackgroundColor',handles.preferences.color.tabs(1,:));
        end
    elseif flags(5)
        set(handles.uiptrace,'Visible','on');
        set(handles.tbtrace,'BackgroundColor',handles.preferences.color.tabs(2,:));
    end
    %-------------------------------------------------------------------
    if oldflags(6)
        if ~flags(6)
        set(handles.uipkarta,'Visible','off');
        set(handles.tbkarta,'BackgroundColor',handles.preferences.color.tabs(1,:));
        set(handles.Tabs.KartaObj.Luch,'Visible','off');
        end
    elseif flags(6)
        set(handles.uipkarta,'Visible','on');
        set(handles.tbkarta,'BackgroundColor',handles.preferences.color.tabs(2,:));
        n=numel(handles.antenna.klaster);
        n1=numel(handles.Tabs.KartaObj.Luch);
        if n>0&&n1>0
            for i=1:n
                set(handles.Tabs.KartaObj.Luch(i),'Visible',handles.antenna.klaster(i).beactiv);
            end
        end
    end
    
    handles.Tabs.visible.oldflags=handles.Tabs.visible.flags;
end