function kldata=KLOrtoGen(Net,Nobl,dX,dY)
kldata=[];
if mod(Net,2)==0
    for k=1:2:Net
        if Net-k>0
            kldata=addetag(dX,(1+(k-1))*dY/2,Nobl,kldata);
            kldata=addetag(dX,-(1+(k-1))*dY/2,Nobl,kldata);
        else
            kldata=addetag(dX,-(1+(k-1))*dY/2,Nobl,kldata);
        end
    end
else
    kldata=addetag(dX,0,Nobl,kldata);
    Net=Net-1;
    for k=1:2:Net
        if Net-k>0
            kldata=addetag(dX,(k+1)*dY/2,Nobl,kldata);
            kldata=addetag(dX,-(k+1)*dY/2,Nobl,kldata);
        else
            kldata=addetag(dX,-(k+1)*dY/2,Nobl,kldata);
        end
    end
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