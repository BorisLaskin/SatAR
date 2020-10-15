function handles=RaspredPlot(handles,value)
F1=handles.antenna.F1;
F2=handles.antenna.F2;
D=handles.antenna.allparam.D;
axX2=0.55;axY1=0.05;axY2=0.4;axDX=0.4;axDY=0.25;
switch(value)
    case {1}
        axes(handles.axdnruport);
        delete(allchild(gca));
        plot(F1.pole.stkDNT,F1.pole.G.DNT);
        set(handles.axdnruport,'XGrid','on','YGrid','on');
        
        axes(handles.axdnruporl);
        delete(allchild(gca));
        plot(F1.pole.stkDNL,F1.pole.G.DNL);
        set(handles.axdnruporl,'XGrid','on','YGrid','on');
        
        axes(handles.axglpolt);
        delete(allchild(gca));
        h=mesh(F1.pole.stkX,F1.pole.stkY,Rechange(F1.pole.stkX,F1.pole.stkY,F1.pole.G.AmplPoleGL,D));
        set(h,'Clipping','on');
        xlabel('X');ylabel('Y');
        
        axes(handles.axglpoll);
        delete(handles.legend1);
        delete(allchild(gca));
        fun=@(x,y)interp2(F1.pole.stkX,F1.pole.stkY,F1.pole.G.AmplPoleGL,x,y);
        plot(F1.pole.stkpole,feval(fun,F1.pole.stkpole,0),F1.pole.stkpole,feval(fun,F1.pole.G.Xmax,F1.pole.stkpole));
        set(handles.axglpoll,'XGrid','on','YGrid','on');
        handles.legend1=legend('L','T');
        
        axes(handles.axparpolt);
        delete(allchild(gca));
        h=mesh(F1.pole.stkX,F1.pole.stkY,Rechange(F1.pole.stkX,F1.pole.stkY,F1.pole.G.AmplPolePR,D));
        set(h,'Clipping','on');
        xlabel('X');ylabel('Y');

        axes(handles.axparpoll);
        delete(handles.legend2);
        delete(allchild(gca));
        fun=@(x,y)interp2(F1.pole.stkX,F1.pole.stkY,F1.pole.G.AmplPolePR,x,y);
        plot(F1.pole.stkpole,feval(fun,F1.pole.stkpole,0),F1.pole.stkpole,feval(fun,F1.pole.G.Xmax,F1.pole.stkpole));
        set(handles.axparpoll,'XGrid','on','YGrid','on');
        handles.legend2=legend('L','T');

    case {2}
        
        axes(handles.axdnruport);
        delete(allchild(gca));
        plot(F1.pole.stkDNT,F1.pole.V.DNT);
        set(handles.axdnruport,'XGrid','on','YGrid','on');
        
        axes(handles.axdnruporl);
        delete(allchild(gca));
        plot(F1.pole.stkDNL,F1.pole.V.DNL);
        set(handles.axdnruporl,'XGrid','on','YGrid','on');
        
        axes(handles.axglpolt);
        delete(allchild(gca));
        mesh(F1.pole.stkX,F1.pole.stkY,Rechange(F1.pole.stkX,F1.pole.stkY,F1.pole.V.AmplPoleGL,D));
        xlabel('X');ylabel('Y');
        
        axes(handles.axglpoll);
        delete(handles.legend1);
        delete(allchild(gca));
        fun=@(x,y)interp2(F1.pole.stkX,F1.pole.stkY,F1.pole.V.AmplPoleGL,x,y);
        plot(F1.pole.stkpole,feval(fun,F1.pole.stkpole,0),F1.pole.stkpole,feval(fun,F1.pole.V.Xmax,F1.pole.stkpole));
        set(handles.axglpoll,'XGrid','on','YGrid','on');
        handles.legend1=legend('L','T');
        
        axes(handles.axparpolt);
        delete(allchild(gca));
        mesh(F1.pole.stkX,F1.pole.stkY,Rechange(F1.pole.stkX,F1.pole.stkY,F1.pole.V.AmplPolePR,D));
        xlabel('X');ylabel('Y');

        axes(handles.axparpoll);
        delete(handles.legend2);
        delete(allchild(gca));
        fun=@(x,y)interp2(F1.pole.stkX,F1.pole.stkY,F1.pole.V.AmplPolePR,x,y);
        plot(F1.pole.stkpole,feval(fun,F1.pole.stkpole,0),F1.pole.stkpole,feval(fun,F1.pole.V.Xmax,F1.pole.stkpole));
        set(handles.axparpoll,'XGrid','on','YGrid','on');
        handles.legend2=legend('L','T');

    case {3}
        axes(handles.axdnruport);
        delete(allchild(gca));
        plot(F2.pole.stkDNT,F2.pole.G.DNT);
        set(handles.axdnruport,'XGrid','on','YGrid','on');
        
        axes(handles.axdnruporl);
        delete(allchild(gca));
        plot(F2.pole.stkDNL,F2.pole.G.DNL);
        set(handles.axdnruporl,'XGrid','on','YGrid','on');
        
        axes(handles.axglpolt);
        delete(allchild(gca));
        mesh(F2.pole.stkX,F2.pole.stkY,Rechange(F2.pole.stkX,F2.pole.stkY,F2.pole.G.AmplPoleGL,D));
        xlabel('X');ylabel('Y');
        
        axes(handles.axglpoll);
        delete(handles.legend1);
        delete(allchild(gca));
        fun=@(x,y)interp2(F2.pole.stkX,F2.pole.stkY,F2.pole.G.AmplPoleGL,x,y);
        plot(F2.pole.stkpole,feval(fun,F2.pole.stkpole,0),F2.pole.stkpole,feval(fun,F2.pole.G.Xmax,F2.pole.stkpole));
        set(handles.axglpoll,'XGrid','on','YGrid','on');
        handles.legend1=legend('L','T');
        
        axes(handles.axparpolt);
        delete(allchild(gca));
        mesh(F2.pole.stkX,F2.pole.stkY,Rechange(F2.pole.stkX,F2.pole.stkY,F2.pole.G.AmplPolePR,D));
        xlabel('X');ylabel('Y');

        axes(handles.axparpoll);
        delete(handles.legend2);
        delete(allchild(gca));
        fun=@(x,y)interp2(F2.pole.stkX,F2.pole.stkY,F2.pole.G.AmplPolePR,x,y);
        plot(F2.pole.stkpole,feval(fun,F2.pole.stkpole,0),F2.pole.stkpole,feval(fun,F2.pole.G.Xmax,F2.pole.stkpole));
        set(handles.axparpoll,'XGrid','on','YGrid','on');
        handles.legend2=legend('L','T');
        
    case {4}
        axes(handles.axdnruport);
        delete(allchild(gca));
        plot(F2.pole.stkDNT,F2.pole.V.DNT);
        set(handles.axdnruport,'XGrid','on','YGrid','on');
        
        axes(handles.axdnruporl);
        delete(allchild(gca));
        plot(F2.pole.stkDNL,F2.pole.V.DNL);
        set(handles.axdnruporl,'XGrid','on','YGrid','on');
        
        axes(handles.axglpolt);
        delete(allchild(gca));
        mesh(F2.pole.stkX,F2.pole.stkY,Rechange(F2.pole.stkX,F2.pole.stkY,F2.pole.V.AmplPoleGL,D));
        xlabel('X');ylabel('Y');
        
        axes(handles.axglpoll);
        delete(handles.legend1);
        delete(allchild(gca));
        fun=@(x,y)interp2(F2.pole.stkX,F2.pole.stkY,F2.pole.V.AmplPoleGL,x,y);
        plot(F2.pole.stkpole,feval(fun,F2.pole.stkpole,0),F2.pole.stkpole,feval(fun,F2.pole.V.Xmax,F2.pole.stkpole));
        set(handles.axglpoll,'XGrid','on','YGrid','on');
        handles.legend1=legend('L','T');
        
        axes(handles.axparpolt);
        delete(allchild(gca));
        mesh(F2.pole.stkX,F2.pole.stkY,Rechange(F2.pole.stkX,F2.pole.stkY,F2.pole.V.AmplPolePR,D));
        xlabel('X');ylabel('Y');

        axes(handles.axparpoll);
        delete(handles.legend2);
        delete(allchild(gca));
        fun=@(x,y)interp2(F2.pole.stkX,F2.pole.stkY,F2.pole.V.AmplPolePR,x,y);
        plot(F2.pole.stkpole,feval(fun,F2.pole.stkpole,0),F2.pole.stkpole,feval(fun,F2.pole.V.Xmax,F2.pole.stkpole));
        set(handles.axparpoll,'XGrid','on','YGrid','on');
        handles.legend2=legend('L','T');

    otherwise
end
end
function res=Rechange(X,Y,Z,D)
A=X.^2+Y.^2-(D/2)^2;
res=Z;
res(find(A>0))= NaN;
%res(find(A>0))=min(min(Z));
end