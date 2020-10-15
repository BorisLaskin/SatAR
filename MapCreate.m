function handles=MapCreate(handles,wait)
try
    thisdir=cd;
    cd('MapData');
    %-------------inicialize-----------------------------------------
    load coast1;
    load worldlo1;
    country = shaperead('country','UseGeoCoords',true);
    landfaceColors = makesymbolspec('Polygon',{'INDEX', [1 numel(country)],...
        'FaceColor',polcmap(numel(country))});
    citiesfaceColors = makesymbolspec('Point',{'Default','Color',handles.preferences.color.cities,'Marker','o',...
        'MarkerFaceColor',handles.preferences.color.cities,'MarkerEdgeColor',[0 0 0]});
    riversfaceColors = makesymbolspec('Line',{'Default','Color',handles.preferences.color.rivers});
    lakesfaceColors = makesymbolspec('Polygon',{'Default', 'FaceColor',handles.preferences.color.lakes});
    worldcities = shaperead('worldcities','UseGeoCoords',true);
    worldlakes = shaperead('worldlakes','UseGeoCoords',true);
    worldrivers = shaperead('worldrivers','UseGeoCoords',true);
    %-------------inicialize_end-----------------------------------------
    
    cd(thisdir);
    axes(handles.axkrt);
    set(handles.figure1,'Visible','off');
    %-------------land-----------------------------------------
    if handles.preferences.Karta.MapConfig(1)
        hshp=geoshow(country,'DisplayType','polygon','SymbolSpec',landfaceColors);
        landchildren=get(hshp,'Children');
        landmenu=zeros(1,numel(landchildren));
        for i=1:numel(country)
            landmenu(i)=uicontextmenu;
            item = uimenu(landmenu(i), 'Label',country(i).CNTRY_NAME); %#ok<NASGU>
            set(landchildren(i),'UIContextMenu',landmenu(i));
        end
    else
        h=geoshow(handles.axkrt,lat,long);
        set(h,'Color','black');
        h=geoshow(handles.axkrt,POline(1).lat,POline(1).long);
        set(h,'Color','black');
    end
    h=line(long1,lat1);
    set(h,'Color','black');
    h=line(long-360,lat);
    set(h,'Color','black');
    h=line(POline(1).long-360,POline(1).lat);
    set(h,'Color','black');
    h=line(long+360,lat);
    set(h,'Color','black');
    h=line(POline(1).long+360,POline(1).lat);
    set(h,'Color','black');
    %------------cities---------------------------------------
    waitbar(6/9,wait,'Идет загрузка программы...');
    axes(handles.axkrt);
    set(handles.figure1,'Visible','off');
    if handles.preferences.Karta.MapConfig(2)
        hshp=[];
        hshp=geoshow(worldcities,'DisplayType','point','SymbolSpec',citiesfaceColors);
        citieschildren=get(hshp,'Children');
        citiesmenu=zeros(1,numel(citieschildren));
        for i=1:numel(worldcities)
            citiesmenu(i)=uicontextmenu;
            item = uimenu(citiesmenu(i), 'Label',worldcities(i).Name); %#ok<NASGU>
            set(citieschildren(i),'UIContextMenu',citiesmenu(i));
        end
    end
    %-------------rivers-------------------------------------
    waitbar(7/9,wait,'Идет загрузка программы...');
    axes(handles.axkrt);
    set(handles.figure1,'Visible','off');
    if handles.preferences.Karta.MapConfig(3)
        hshp=[];
        hshp=geoshow(worldrivers,'DisplayType','line','SymbolSpec',riversfaceColors);
        riverschildren=get(hshp,'Children');
        riversmenu=zeros(1,numel(riverschildren));
        for i=1:numel(worldrivers)
            riversmenu(i)=uicontextmenu;
            item = uimenu(riversmenu(i), 'Label',worldrivers(i).Name); %#ok<NASGU>
            set(riverschildren(i),'UIContextMenu',riversmenu(i));
        end
    end
    %-------------lakes-------------------------------------
    waitbar(8/9,wait,'Идет загрузка программы...');
    axes(handles.axkrt);
    set(handles.figure1,'Visible','off');
    if handles.preferences.Karta.MapConfig(4)
        hshp=[];
        hshp=geoshow(worldlakes,'DisplayType','polygon','SymbolSpec',lakesfaceColors);
        lakeschildren=get(hshp,'Children');
        lakessmenu=zeros(1,numel(lakeschildren));
        for i=1:numel(worldlakes)
            lakessmenu(i)=uicontextmenu;
            item = uimenu(lakessmenu(i), 'Label',worldlakes(i).Name); %#ok<NASGU>
            set(lakeschildren(i),'UIContextMenu',lakessmenu(i));
        end
    end
    set(handles.axkrt,'XLim',[-180,180],'YLim',[-90,90]);
catch
    cd(thisdir);
    string=lasterr;
    dlg=dialog('WindowStyle', 'normal', 'Name', 'Ошибка','Units','normalized','Position',[0.4 0.5 0.2 0.1]);
    dlgstart(dlg,string);
end
end