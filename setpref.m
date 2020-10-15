function handles=setpref(handles)
handles.preferences.Pos.MainWin=[0.1 0.1 0.8 0.8];
handles.preferences.Pos.optim=[0.2 0.2 0.52 0.5];
handles.preferences.color.MainWinC=[0.831372549019608,0.815686274509804,0.784313725490196];
handles.preferences.color.panel=[0.831372549019608,0.815686274509804,0.784313725490196];
handles.preferences.color.subpanel=[0.831372549019608,0.815686274509804,0.784313725490196];
handles.preferences.color.tabs=[1 0 0; 0 1 0];
handles.preferences.color.beactiv=[0 1 0; 1 0 0];
handles.preferences.color.inaccessible=[0.502 0.502  0.502];
handles.preferences.color.cities=[0.5 0 0];
handles.preferences.color.rivers=[0 0 0.5];
handles.preferences.color.lakes=[0 0 1];
handles.preferences.color.VisibleZone=[0 0 0];
handles.preferences.fonttype.buttons='MS Sans Serif';
handles.preferences.fonttype.subpanel='MS Sans Serif';
handles.preferences.fonttype.axes='MS Sans Serif';
handles.preferences.fonttype.text='MS Sans Serif';
handles.preferences.fonttype.matrix='MS Sans Serif';
handles.preferences.fontsize.buttons=8;
handles.preferences.fontsize.subpanel=8;
handles.preferences.fontsize.axes=8;
handles.preferences.fontsize.text=8;
handles.preferences.fontsize.matrix=8;
handles.preferences.fontsize.pruprtext1=10;
handles.preferences.fontsize.pruprtext2=10;
handles.preferences.fontsize.pruprtext3=10;
handles.preferences.fontsize.pruprtext4=8;
handles.preferences.fontsize.pruprtext5=8;
handles.preferences.fontsize.pruprtext6=8;
handles.preferences.fontsize.pruprtext7=8;
handles.preferences.fontsize.GrahpLabel=8;
handles.preferences.GraphWidth=3;

handles.preferences.functions.pole=@GetRaspredeleniyaNew;
handles.preferences.functions.Diagram=@GetAllDiagram;
handles.preferences.tol.pole=100;
handles.preferences.tol.ax3Dant=100;
handles.preferences.tol.kipoptim=10^-2;
handles.preferences.tol.findPSI.number=[10 10 10 10];
handles.preferences.tol.findPSI.Nglotsch=6;
handles.preferences.tol.findPSI.level=10^-2;
handles.preferences.tol.DNotobr=100;
handles.preferences.tol.DNotobr3D=100;

handles.preferences.color.polar=[1 0 0; 0 0.5 0; 0.749 0 0.749;...
    0 0.749 0.749; 0.847 0.161 0; 1 0 1; 0.682 0.467 0; 0.871 0.49 0];

handles.preferences.Karta.tip=0;%0 - pryamougol'naya; 1 - globe
handles.preferences.Karta.MapConfig=[0 0 0 0];%cvetnie strani, goroda, reki, ozera
handles.preferences.Karta.DNparam=[1 0 1];%1 - mownost' ;2 - Dal; 3 - Atmosfera
handles.preferences.Karta.grs80 =[1.0e+003*6.378137,0.000081819191043];%radius zemli v km
handles.preferences.Karta.Rka=42164;%orbita v km
handles.preferences.Karta.VisibleZoneLevel=5;
handles.preferences.Karta.ContourWidth=2;
handles.preferences.Karta.Ntochek=10;%na luch pri modelirovanii
handles.preferences.Karta.Ntochek1=5;%na luch pri analize

handles.preferences.Karta.pikmnog=16;
handles.preferences.Karta.sigmascan=10;
handles.preferences.Karta.maxPPporog=0.3;

end