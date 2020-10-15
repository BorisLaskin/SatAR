function h=PutLevelOnTheMap(handles,Matrix,filled,numberflag,Gaflag,color,MaxData,X,Y,number)
axes(handles.axkrt);
limit = size(Matrix, 2);
i = 1;
h = [];
h1 = [];
h2 = [];
hg=hggroup;
set(hg,'Parent',handles.axkrt);
if limit~=0
    Matrix1=zeros(size(Matrix));
    Matrix2=zeros(size(Matrix));
    while (i < limit)
        Matrix1(:,i)=Matrix(:,i);
        Matrix2(:,i)=Matrix(:,i);
        npoints = Matrix(2, i);
        nexti = i + npoints + 1;
        xdata = Matrix(1, i + 1 : i + npoints);
        ydata = Matrix(2, i + 1 : i + npoints);
        Matrix1(1,i + 1 : i + npoints)=Matrix(1, i + 1 : i + npoints)-360;
        Matrix1(2,i + 1 : i + npoints)=Matrix(2, i + 1 : i + npoints);
        Matrix2(1,i + 1 : i + npoints)=Matrix(1, i + 1 : i + npoints)+360;
        Matrix2(2,i + 1 : i + npoints)=Matrix(2, i + 1 : i + npoints);
        % Create the patches or lines
        if filled
            cu = patch('XData', [xdata], 'YData', [ydata],'FaceColor', color,...
                'EdgeColor', color, 'Parent', hg);
            cu1 = patch('XData', [xdata-360], 'YData', [ydata],'FaceColor', color,...
                'EdgeColor', color, 'Parent', hg);
            cu2 = patch('XData', [xdata+360], 'YData', [ydata],'FaceColor', color,...
                'EdgeColor', color, 'Parent', hg);
            set(cu,'EraseMode','xor');
            set(cu1,'EraseMode','xor');
            set(cu2,'EraseMode','xor');
        else
            cu = line('XData', xdata, 'YData', ydata, 'Parent', hg,'Color',color,'LineWidth',handles.preferences.Karta.ContourWidth);
            cu1 = line('XData', xdata-360, 'YData', ydata, 'Parent', hg,'Color',color,'LineWidth',handles.preferences.Karta.ContourWidth);
            cu2 = line('XData', xdata+360, 'YData', ydata, 'Parent', hg,'Color',color,'LineWidth',handles.preferences.Karta.ContourWidth);
        end
        i = nexti;
        h = [h; cu(:)];
        h1 = [h1; cu1(:)];
        h2 = [h2; cu2(:)];
    end
    if numberflag||Gaflag
        strnumber=[];
        strGa=[];
        if numberflag
            
            strnumber=strcat('¹',num2str(number),';');
        end
        if Gaflag
            lng=length(num2str(floor(MaxData)));
            if MaxData<0
                lng=lng-1;
            end
            strGa=strcat(num2str(MaxData,lng+1),'dB;');
        end
        str=strcat(strnumber,strGa);
        cu3=text(X,Y,str);
        cu31=text(X-360,Y,str);
        cu32=text(X+360,Y,str);
        set(cu3,'Parent',hg,'FontName',handles.preferences.fonttype.text,...
            'FontSize',handles.preferences.fontsize.GrahpLabel,'Clipping','on');
        set(cu31,'Parent',hg,'FontName',handles.preferences.fonttype.text,...
            'FontSize',handles.preferences.fontsize.GrahpLabel,'Clipping','on');
        set(cu32,'Parent',hg,'FontName',handles.preferences.fonttype.text,...
            'FontSize',handles.preferences.fontsize.GrahpLabel,'Clipping','on');
    end
end
h=hg;
end