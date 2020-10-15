function handles=ChZadacha(handles)
if handles.Tabs.Zadacha
    set(handles.pbIngAn,'BackgroundColor',handles.preferences.color.tabs(2,:));
    set(handles.pbMod,'BackgroundColor',handles.preferences.color.tabs(1,:));
    set(handles.tmupr,'Visible','off');
    set(handles.tthpr,'Visible','off');
    set(handles.tsigma,'Visible','off');
    set(handles.edmupr,'Visible','off');
    set(handles.edthpr,'Visible','off');
    set(handles.edsigma,'Visible','off');
    set(handles.pbkrtkontur,'Visible','on');
    set(handles.uipkrtcelfcn,'Visible','on');
    set(handles.uipkrtalgfcn,'Visible','on');
    if handles.Tabs.CelFcn==1
        set(handles.rbconturSKO,'Value',1);
    elseif handles.Tabs.CelFcn==2
        set(handles.rbmaxPP,'Value',1);
    elseif handles.Tabs.CelFcn==3
        set(handles.rbmaxPS,'Value',1);
    end
    if handles.Tabs.AlgFcn==1
        set(handles.rbpik,'Value',1);
    elseif handles.Tabs.AlgFcn==2
        set(handles.rbgrad,'Value',1);
    elseif handles.Tabs.AlgFcn==3
        set(handles.rbpikgrad,'Value',1);
    elseif handles.Tabs.AlgFcn==4
        set(handles.rbsolve,'Value',1);
    end
else
    set(handles.pbMod,'BackgroundColor',handles.preferences.color.tabs(2,:));
    set(handles.pbIngAn,'BackgroundColor',handles.preferences.color.tabs(1,:));
    set(handles.tmupr,'Visible','on');
    set(handles.tthpr,'Visible','on');
    set(handles.tsigma,'Visible','on');
    set(handles.edmupr,'Visible','on');
    set(handles.edthpr,'Visible','on');
    set(handles.edsigma,'Visible','on');
    set(handles.pbkrtkontur,'Visible','off');
    set(handles.uipkrtcelfcn,'Visible','off');
    set(handles.uipkrtalgfcn,'Visible','off');
    if ~isnan(handles.antenna.System.navparam.mupr)
        set(handles.edmupr,'String',num2str(handles.antenna.System.navparam.mupr));
    end
    if ~isnan(handles.antenna.System.navparam.thpr)
        set(handles.edthpr,'String',num2str(handles.antenna.System.navparam.thpr));
    end
    if ~isnan(handles.antenna.System.navparam.sigma)
        set(handles.edsigma,'String',num2str(handles.antenna.System.navparam.sigma));
    end
end
if ~isnan(handles.antenna.System.navparam.Level)
    set(handles.edLevel,'String',num2str(handles.antenna.System.navparam.Level));
end
if ~isnan(handles.antenna.System.navparam.muka)
    set(handles.edmuka,'String',num2str(handles.antenna.System.navparam.muka));
end
end