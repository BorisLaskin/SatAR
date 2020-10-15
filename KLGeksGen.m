function kldata=KLGeksGen(Net,Ncobl,dX,dY)
kldata=[];
if Net<=Ncobl*2-1
    m_obl=Ncobl;
    kldata=addetag(dX,0,m_obl,kldata);
    Net=Net-1;
    for k=1:2:Net
        if Net-k>0
            kldata=addetag(dX,(1+(k-1)/2)*dY,m_obl-1-(k-1)/2,kldata);
            kldata=addetag(dX,-(1+(k-1)/2)*dY,m_obl-1-(k-1)/2,kldata);
        else
            kldata=addetag(dX,-(1+(k-1)/2)*dY,m_obl-1-(k-1)/2,kldata);
        end
    end
else
    kldata=[];
    string=('Количество этажей больше допустимого');
    dlg=dialog('WindowStyle', 'normal', 'Name', 'Ошибка','Units','normalized','Position',[0.4 0.5 0.2 0.1]);
    dlgstart(dlg,string);
end
end
function kldata=addetag(dX,dY,m_obl,kldata)
num_obl=numel(kldata);
if mod(m_obl,2)==0
    for i=1:2:m_obl
        kldata(num_obl+1,1).X=i/2*dX;
        kldata(num_obl+1,1).Y=dY;
        num_obl=num_obl+1;
        kldata(num_obl+1,1).X=-i/2*dX;
        kldata(num_obl+1,1).Y=dY;
        num_obl=num_obl+1;
    end
else
    kldata(num_obl+1,1).X=0;
    kldata(num_obl+1,1).Y=dY;
    num_obl=num_obl+1;
    m_obl=m_obl-1;
    for i=1:2:m_obl
        kldata(num_obl+1,1).X=(i+1)/2*dX;
        kldata(num_obl+1,1).Y=dY;
        num_obl=num_obl+1;
        kldata(num_obl+1,1).X=-(i+1)/2*dX;
        kldata(num_obl+1,1).Y=dY;
        num_obl=num_obl+1;
    end
end
end