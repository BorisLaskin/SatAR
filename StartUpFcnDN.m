function handles=StartUpFcnDN(handles)
uipanelwidth=0.98;
uipanelheight=0.94;
uipanelx=0.01;
uipanely=0.01;
togglebwidth=0.1;
togglebheight=0.05;
fonttype.buttons=handles.preferences.fonttype.buttons;
fonttype.subpanel=handles.preferences.fonttype.subpanel;
fonttype.axes=handles.preferences.fonttype.axes;
fonttype.text=handles.preferences.fonttype.text;
fonttype.matrix=handles.preferences.fonttype.matrix;
fontsize.buttons=handles.preferences.fontsize.buttons;
fontsize.subpanel=handles.preferences.fontsize.subpanel;
fontsize.axes=handles.preferences.fontsize.axes;
fontsize.text=handles.preferences.fontsize.text;
fontsize.matrix=handles.preferences.fontsize.matrix;
%||-----------------------uipdn-------------------------------------
set(handles.uipdn,'Units','normalized','Position',[uipanelx,uipanely,uipanelwidth,uipanelheight]);
set(handles.uipdn,'BackgroundColor',handles.preferences.color.panel);
set(handles.uipdn,'Title','Расчет ДН','TitlePosition','righttop');
set(handles.uipdn,'FontName',fonttype.subpanel,'FontSize',fontsize.subpanel);
%|||----------------------tbdn--------------------------------
set(handles.tbdn,'BackgroundColor',handles.preferences.color.tabs(1,:));
set(handles.tbdn,'Units','normalized','Position',[0.31,0.95,togglebwidth,togglebheight]);
set(handles.tbdn,'String','Вычисления');
set(handles.tbdn,'FontName',fonttype.buttons,'FontSize',fontsize.buttons);
uipsubpdx=0.48;uipsubpdy1=0.6;uipsubpdy2=0.37;
%|||----------------------uippartional------------------------------
set(handles.uippartional,'Units','normalized','Position',[0.01,uipsubpdy2+0.02,uipsubpdx,uipsubpdy1]);
set(handles.uippartional,'BackgroundColor',handles.preferences.color.subpanel);
set(handles.uippartional,'Title','Результаты расчета');
set(handles.uippartional,'FontName',fonttype.subpanel,'FontSize',fontsize.subpanel);
%||||----------------------uitpartional-----------------------------------
datax=[];
set(handles.uitpartional,'Data',[datax'],'Units','normalized','Position',[0.01 0.01 0.98 0.98]);
set(handles.uitpartional,'FontName',fonttype.matrix,'FontSize',fontsize.matrix);
%|||----------------------uipdnpref-----------------------------------
set(handles.uipdnpref,'Units','normalized','Position',[0.01,0.01,0.19,uipsubpdy2]);
set(handles.uipdnpref,'BackgroundColor',handles.preferences.color.subpanel);
set(handles.uipdnpref,'Title','Параметры расчета');
set(handles.uipdnpref,'FontName',fonttype.subpanel,'FontSize',fontsize.subpanel);
%||||----------------------elements----------------------------------
set(handles.uipParrasch,'Units','normalized','Position',[0.04,0.6,0.92,0.38]);
set(handles.uipParrasch,'BackgroundColor',handles.preferences.color.subpanel);
set(handles.uipParrasch,'Title','Тип расчета');
set(handles.uipParrasch,'FontName',fonttype.subpanel,'FontSize',fontsize.subpanel);
set(handles.edfider,'Units','normalized','Position',[0.04,0.78,0.92,0.1],'String','');
set(handles.edfider,'FontName',fonttype.text,'FontSize',fontsize.text,'Visible','off');
set(handles.tfider,'Units','normalized','Position',[0.04,0.88,0.92,0.1]);
set(handles.tfider,'String','Коэф. передачи фидера','HorizontalAlignment','left');
set(handles.tfider,'FontName',fonttype.text,'FontSize',fontsize.text,'Visible','off');
set(handles.pbstartrasch,'Units','normalized','Position',[0.095,0.04,0.81,0.15]);
set(handles.pbstartrasch,'String','Рассчитать');
set(handles.pbstartrasch,'FontName',fonttype.buttons,'FontSize',fontsize.buttons);
set(handles.rbraschall,'Units','normalized','Position',[0.08,0.55,0.9,0.25]);
set(handles.rbraschall,'String','Полный расчет');
set(handles.rbraschall,'FontName',fonttype.buttons,'FontSize',fontsize.buttons);
set(handles.rbraschcurr,'Units','normalized','Position',[0.08,0.2,0.9,0.25]);
set(handles.rbraschcurr,'String','Текущая конфигурация');
set(handles.rbraschcurr,'FontName',fonttype.buttons,'FontSize',fontsize.buttons);
%|||----------------------uipDNready-----------------------------------
set(handles.uipDNready,'Units','normalized','Position',[uipsubpdx+0.02,uipsubpdy2+0.02,uipsubpdx+0.01,uipsubpdy1]);
set(handles.uipDNready,'BackgroundColor',handles.preferences.color.subpanel);
set(handles.uipDNready,'Title','Направленные свойства');
set(handles.uipDNready,'FontName',fonttype.subpanel,'FontSize',fontsize.subpanel);
%||||----------------------elements------------------------------------
set(handles.axDNready,'Units','normalized','Position',[0.08,0.12,0.84,0.8]);
set(handles.axDNready,'FontName',fonttype.axes,'FontSize',fontsize.axes);
set(handles.axDNready,'XGrid','on','YGrid','on');
%|||----------------------uipdnkl-----------------------------------
set(handles.uipdnkl,'Units','normalized','Position',[0.21,0.01,0.78,uipsubpdy2]);
set(handles.uipdnkl,'BackgroundColor',handles.preferences.color.subpanel);
set(handles.uipdnkl,'Title','Параметры отображения');
set(handles.uipdnkl,'FontName',fonttype.subpanel,'FontSize',fontsize.subpanel);
%||||----------------------elements------------------------------------
dx=0.1905;dy=0.15;
set(handles.pb3DDNobl,'Units','normalized','Position',[0.7995,0.04,dx,dy]);
set(handles.pb3DDNobl,'String','Объемная ДН');
set(handles.pb3DDNobl,'FontName',fonttype.buttons,'FontSize',fontsize.buttons);
set(handles.pbShowdefault,'Units','normalized','Position',[0.7995,2*0.04+dy,dx,dy]);
set(handles.pbShowdefault,'String','Сбросить ДН');
set(handles.pbShowdefault,'FontName',fonttype.buttons,'FontSize',fontsize.buttons);
set(handles.pbShowT,'Units','normalized','Position',[0.7995,3*0.04+2*dy,dx,dy]);
set(handles.pbShowT,'String','ДН T плоскость');
set(handles.pbShowT,'FontName',fonttype.buttons,'FontSize',fontsize.buttons);
set(handles.pbShowL,'Units','normalized','Position',[0.7995,4*0.04+3*dy,dx,dy]);
set(handles.pbShowL,'String','ДН L плоскость');
set(handles.pbShowL,'FontName',fonttype.buttons,'FontSize',fontsize.buttons);
set(handles.pbShowdec,'Units','normalized','Position',[0.7995,5*0.04+4*dy,dx,dy]);
set(handles.pbShowdec,'String','дБ');
set(handles.pbShowdec,'FontName',fonttype.buttons,'FontSize',fontsize.buttons);
dx1=0.336;dy1=0.82;
set(handles.axdnklpol,'Units','normalized','Position',[0.04,0.04,dx1,dy1]);
set(handles.axdnklpol,'FontName',fonttype.axes,'FontSize',fontsize.axes);
set(handles.axdnklpol,'XTickLabel',[],'YTickLabel',[]);
set(handles.axdnklon,'Units','normalized','Position',[dx1+0.08,0.04,dx1,dy1]);
set(handles.axdnklon,'FontName',fonttype.axes,'FontSize',fontsize.axes);
set(handles.axdnklon,'XTickLabel',[],'YTickLabel',[]);
set(handles.tdnklpol,'Units','normalized','Position',[0.04,0.87,dx1,0.1]);
set(handles.tdnklpol,'String','Выбор Поляризации','HorizontalAlignment','left');
set(handles.tdnklpol,'FontName',fonttype.text,'FontSize',fontsize.text);
set(handles.tdnklon,'Units','normalized','Position',[dx1+0.08,0.87,dx1,0.1]);
set(handles.tdnklon,'String','Выбор отображения ДН','HorizontalAlignment','left');
set(handles.tdnklon,'FontName',fonttype.text,'FontSize',fontsize.text);
end