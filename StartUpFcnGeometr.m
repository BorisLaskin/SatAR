function handles=StartUpFcnGeometr(handles)
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
fontsize.buttons=handles.preferences.fontsize.buttons;
fontsize.subpanel=handles.preferences.fontsize.subpanel;
fontsize.axes=handles.preferences.fontsize.axes;
fontsize.text=handles.preferences.fontsize.text;
%||-----------------------uipgeometr-------------------------------------
set(handles.uipgeometr,'Units','normalized','Position',[uipanelx,uipanely,uipanelwidth,uipanelheight]);
set(handles.uipgeometr,'BackgroundColor',handles.preferences.color.panel);
set(handles.uipgeometr,'Title','Геометрия и распределения полей','TitlePosition','righttop');
set(handles.uipgeometr,'FontName',fonttype.subpanel,'FontSize',fontsize.subpanel);
%|||----------------------tbgeometr--------------------------------
set(handles.tbgeometr,'BackgroundColor',handles.preferences.color.tabs(1,:));
set(handles.tbgeometr,'Units','normalized','Position',[0.01,0.95,togglebwidth,togglebheight]);
set(handles.tbgeometr,'String','Геометрия');
set(handles.tbgeometr,'FontName',fonttype.buttons,'FontSize',fontsize.buttons);
%|||----------------------uipbaseparam----------------------------------
set(handles.uipbaseparam,'Units','normalized','Position',[0.01,0.5,0.33,0.49]);
set(handles.uipbaseparam,'BackgroundColor',handles.preferences.color.subpanel);
set(handles.uipbaseparam,'Title','Конструктивные параметры ГЗА');
set(handles.uipbaseparam,'FontName',fonttype.subpanel,'FontSize',fontsize.subpanel);
%||||---------------------buttons---------------------------------------
set(handles.pbopenant,'Units','normalized','Position',[0.03,0.05,0.453,0.1077]);
set(handles.pbopenant,'String','Открыть');
set(handles.pbopenant,'FontName',fonttype.buttons,'FontSize',fontsize.buttons);
set(handles.pbsaveant,'Units','normalized','Position',[0.517,0.05,0.453,0.1077]);
set(handles.pbsaveant,'String','Сохранить');
set(handles.pbsaveant,'FontName',fonttype.buttons,'FontSize',fontsize.buttons);
set(handles.pbantoptim,'Units','normalized','Position',[0.65,0.05,0.3,0.1]);
set(handles.pbantoptim,'String','Оптимизация');
set(handles.pbantoptim,'FontName',fonttype.buttons,'FontSize',fontsize.buttons);
set(handles.pbantoptim,'Visible','off');
%||||---------------------edits&statictexts-------------------------------
set(handles.edD,'Units','normalized','Position',[0.75,0.85,0.2,0.1],'String','');
set(handles.edD,'FontName',fonttype.text,'FontSize',fontsize.text);
set(handles.edC,'Units','normalized','Position',[0.75,0.75,0.2,0.1],'String','');
set(handles.edC,'FontName',fonttype.text,'FontSize',fontsize.text);
set(handles.edF,'Units','normalized','Position',[0.75,0.65,0.2,0.1],'String','');
set(handles.edF,'FontName',fonttype.text,'FontSize',fontsize.text);
set(handles.edalfa0,'Units','normalized','Position',[0.75,0.55,0.2,0.1],'String','');
set(handles.edalfa0,'FontName',fonttype.text,'FontSize',fontsize.text);
set(handles.edR0,'Units','normalized','Position',[0.75,0.45,0.2,0.1],'String','');
set(handles.edR0,'FontName',fonttype.text,'FontSize',fontsize.text);
set(handles.edF1,'Units','normalized','Position',[0.75,0.35,0.2,0.1],'String','');
set(handles.edF1,'FontName',fonttype.text,'FontSize',fontsize.text);
set(handles.edF2,'Units','normalized','Position',[0.75,0.25,0.2,0.1],'String','');
set(handles.edF2,'FontName',fonttype.text,'FontSize',fontsize.text);
set(handles.tD,'Units','normalized','Position',[0.05,0.85,0.7,0.1]);
set(handles.tD,'String','Диаметр раскрыва зеркала (D), м','HorizontalAlignment','left');
set(handles.tD,'FontName',fonttype.text,'FontSize',fontsize.text);
set(handles.tC,'Units','normalized','Position',[0.05,0.75,0.7,0.1]);
set(handles.tC,'String','Клиренс зеркала (C), м','HorizontalAlignment','left');
set(handles.tC,'FontName',fonttype.text,'FontSize',fontsize.text);
set(handles.tF,'Units','normalized','Position',[0.05,0.65,0.7,0.1]);
set(handles.tF,'String','Фокусное расстояние (F), м','HorizontalAlignment','left');
set(handles.tF,'FontName',fonttype.text,'FontSize',fontsize.text);
set(handles.talfa0,'Units','normalized','Position',[0.05,0.55,0.7,0.1]);
set(handles.talfa0,'String','Угол наклона плоскости облучателей (alfa0), град','HorizontalAlignment','left');
set(handles.talfa0,'FontName',fonttype.text,'FontSize',fontsize.text);
set(handles.tR0,'Units','normalized','Position',[0.05,0.45,0.7,0.1]);
set(handles.tR0,'String','Радиус конического рупора(R0), м','HorizontalAlignment','left');
set(handles.tR0,'FontName',fonttype.text,'FontSize',fontsize.text);
set(handles.tF1,'Units','normalized','Position',[0.05,0.35,0.7,0.1]);
set(handles.tF1,'String','Частота РПДУ1(F1), ГГц','HorizontalAlignment','left');
set(handles.tF1,'FontName',fonttype.text,'FontSize',fontsize.text);
set(handles.tF2,'Units','normalized','Position',[0.05,0.25,0.7,0.1]);
set(handles.tF2,'String','Частота РПДУ2(F2), ГГц','HorizontalAlignment','left');
set(handles.tF2,'FontName',fonttype.text,'FontSize',fontsize.text);
%|||----------------------uipallparam-----------------------------------
set(handles.uipallparam,'Units','normalized','Position',[0.35,0.5,0.14,0.49]);
set(handles.uipallparam,'BackgroundColor',handles.preferences.color.subpanel);
set(handles.uipallparam,'Title','Список параметров');
set(handles.uipallparam,'FontName',fonttype.subpanel,'FontSize',fontsize.subpanel);
set(handles.pbparhelp,'Units','normalized','Position',[0.1,0.05,0.8,0.1]);
set(handles.pbparhelp,'String','Помощь');
set(handles.pbparhelp,'FontName',fonttype.buttons,'FontSize',fontsize.buttons,'Visible','off');
set(handles.tallparam,'Units','normalized','Position',[0.05,0.18,0.8,0.8],'HorizontalAlignment','left');
set(handles.tallparam,'String',strcat(fieldnames(handles.antenna.allparam),' : '),'FontSize',6.5);
set(handles.tallparam,'FontName',fonttype.text);
%|||----------------------uipraspred-----------------------------------
set(handles.uipraspred,'Units','normalized','Position',[0.5,0.01,0.49,0.92]);
set(handles.uipraspred,'BackgroundColor',handles.preferences.color.subpanel);
set(handles.uipraspred,'Title','ДН Рупора и распределения полей в раскрыве');
set(handles.uipraspred,'FontName',fonttype.subpanel,'FontSize',fontsize.subpanel);
%||||-----------------------axes---------------------------------------
axX1=0.05;axX2=0.55;axY1=0.05;axY2=0.4;axY3=0.75;axDX=0.4;axDY=0.25;
set(handles.axparpolt,'Units','normalized','Position',[axX1,axY1,axDX,axDY]);
set(handles.axparpolt,'FontName',fonttype.axes,'FontSize',fontsize.axes);
set(handles.axparpoll,'Units','normalized','Position',[axX2,axY1,axDX,axDY]);
set(handles.axparpoll,'FontName',fonttype.axes,'FontSize',fontsize.axes);
set(handles.axglpolt,'Units','normalized','Position',[axX1,axY2,axDX,axDY]);
set(handles.axglpolt,'FontName',fonttype.axes,'FontSize',fontsize.axes);
set(handles.axglpoll,'Units','normalized','Position',[axX2,axY2,axDX,axDY]);
set(handles.axglpoll,'FontName',fonttype.axes,'FontSize',fontsize.axes);
set(handles.axdnruport,'Units','normalized','Position',[axX1,axY3,axDX,0.2]);
set(handles.axdnruport,'XGrid','on','YGrid','on');
set(handles.axdnruport,'FontName',fonttype.axes,'FontSize',fontsize.axes);
set(handles.axdnruporl,'Units','normalized','Position',[axX2,axY3,axDX,0.2]);
set(handles.axdnruporl,'XGrid','on','YGrid','on');
set(handles.axdnruporl,'FontName',fonttype.axes,'FontSize',fontsize.axes);
%||||-----------------------texts--------------------------------------
tY1=0.3;tY2=0.65;tY3=0.95;tDY=0.05;
set(handles.text13,'Units','normalized','Position',[axX1,tY1,axDX,tDY]);
set(handles.text13,'String','Ампл. распределение поля в раскрыве кросс поляризации');
set(handles.text13,'FontName',fonttype.text,'FontSize',fontsize.text);
set(handles.text14,'Units','normalized','Position',[axX2,tY1,axDX,tDY]);
set(handles.text14,'String','Ампл. распределение поля в секущих плоскостях кросс поляризации');
set(handles.text14,'FontName',fonttype.text,'FontSize',fontsize.text);
set(handles.text11,'Units','normalized','Position',[axX1,tY2,axDX,tDY]);
set(handles.text11,'String','Ампл. распределение поля в раскрыве главной поляризации');
set(handles.text11,'FontName',fonttype.text,'FontSize',fontsize.text);
set(handles.text12,'Units','normalized','Position',[axX2,tY2,axDX,tDY]);
set(handles.text12,'String','Ампл. распределение поля в секущих плоскостях главной поляризации');
set(handles.text12,'FontName',fonttype.text,'FontSize',fontsize.text);
set(handles.text9,'Units','normalized','Position',[axX1,tY3,axDX,tDY]);
set(handles.text9,'String','ДН рупора в поперечной пл-ти');
set(handles.text9,'FontName',fonttype.text,'FontSize',fontsize.text);
set(handles.text10,'Units','normalized','Position',[axX2,tY3,axDX,tDY]);
set(handles.text10,'String','ДН рупора в продольной пл-ти');
set(handles.text10,'FontName',fonttype.text,'FontSize',fontsize.text);
%|||----------------------popupmpolar----------------------------------
set(handles.popupmpolar,'Units','normalized','Position',[0.5,0.89,0.25,0.09]);
set(handles.popupmpolar,'String',{'Горизонтальная поляризация F1';'Вертикальная поляризация F1';...
    'Горизонтальная поляризация F2';'Вертикальная поляризация F2'});
set(handles.popupmpolar,'FontName',fonttype.text,'FontSize',fontsize.text);
%|||----------------------uipvidant-------------------------------------
set(handles.uipvidant,'Units','normalized','Position',[0.01,0.01,0.48,0.48]);
set(handles.uipvidant,'BackgroundColor',handles.preferences.color.subpanel);
set(handles.uipvidant,'Title','Внешний вид антенны');
set(handles.uipvidant,'FontName',fonttype.subpanel,'FontSize',fontsize.subpanel);
set(handles.ax3Dant,'Units','normalized','Position',[0.05,0.05,0.9,0.9]);
set(handles.ax3Dant,'FontName',fonttype.axes,'FontSize',fontsize.axes);
%set(handles.ax3Dant,'ActivePositionProperty','outerposition');
end