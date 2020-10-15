function handles=KLConfigError(handles)
    if ~handles.Tabs.KLconfigChangedPrint
        dlg=dialog('WindowStyle', 'normal', 'Name', 'Предупреждение','Units','normalized','Position',[0.4 0.5 0.2 0.1]);
        string='Внимание! ДН облучателей кластера, рассчитанна на "текущей конфигурации"! Отображение ДН не возможно.';
        dlgstart(dlg,string);
        handles.Tabs.KLconfigChangedPrint=1;
    else
        list2={'F1T','F1L','F2T','F2L'};
        n=numel(handles.antenna.klaster);
        flagright=1;
        for i=1:n
            string=strcat(handles.antenna.klaster(i).frequency,handles.antenna.klaster(i).polarization);
            ind2=find(strcmp(list2,string));
            if ~handles.antenna.System.DNotobr(i).DNinit(ind2)
                flagright=0;
            end
        end
        if flagright
            dlg=dialog('WindowStyle', 'normal', 'Name', 'Помощь','Units','normalized','Position',[0.4 0.5 0.2 0.1]);
            string='Конфигурация кластера восстановлена';
            dlgstart(dlg,string);
            handles.Tabs.KLconfigChanged=0;
            handles.Tabs.KLconfigChangedPrint=0;
        end
    end
    
end