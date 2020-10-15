function poltable=PolinKL(handles)
guidata(handles.figure1, handles);
Modklaster=KLSort(handles.antenna.klaster);
n=numel(handles.antenna.klaster);
%---------------Geks_or_not--------------------------
geks=0;
tempX=Modklaster(1).X;
tempdX=abs(Modklaster(2).X-Modklaster(1).X);
for i=2:n
    if Modklaster(i-1).Y~=Modklaster(i).Y
        if abs(tempX-Modklaster(i).X)==tempdX/2;
            geks=1;
        end
    end
end
if geks
    Net=1;
    Nobl=Net;
    for i=2:n
        if Modklaster(i-1).Y~=Modklaster(i).Y
            if Nobl<Net
                Nobl=Net;
            end
            Net=1;
        else
            Net=Net+1;
        end
    end
end
%----------------------Sort-----------------------------------
stat=zeros(1,n);
for i=1:n
    for j=1:n
        if Modklaster(i).X==handles.antenna.klaster(j).X
            if Modklaster(i).Y==handles.antenna.klaster(j).Y
                stat(1,i)=j;
            end
        end
    end
end
%---------------------take_number_of_polar-----------------------
subpoltable=zeros(1,n);
subpoltable(1,1)=0;
flag=0;
fl1=0;
fl2=0;
Net=1;
if geks
    for i=2:n
        if Modklaster(i-1).Y~=Modklaster(i).Y
            if(Net==Nobl)
                fl1=1;
            end
            if fl1
                if fl2
                    subpoltable(1,i)=0;
                    fl2=0;
                else
                    subpoltable(1,i)=1;
                    fl2=1;
                end
            else
                subpoltable(1,i)=0;
            end
            Net=1;
        else
            subpoltable(1,i)=mod(subpoltable(1,i-1)+1,2);
            Net=Net+1;
        end
    end
else
    for i=2:n
        if Modklaster(i-1).Y~=Modklaster(i).Y
            if fl1
                if fl2
                    subpoltable(1,i)=0;
                    fl2=0;
                else
                    subpoltable(1,i)=1;
                    fl2=1;
                end
                fl1=0;
            else
                if fl2
                    subpoltable(1,i)=1;
                    fl2=1;
                else
                    subpoltable(1,i)=0;
                    fl2=0;
                end
                fl1=1;
            end
        else
            subpoltable(1,i)=mod(subpoltable(1,i-1)+1,2);
        end
    end
end
flag=0;
for i=2:n
    if Modklaster(i-1).Y~=Modklaster(i).Y
        if flag
            flag=0;
        else
            flag=1;
            subpoltable(1,i)=subpoltable(1,i)+2;
        end
    else
        if flag
            subpoltable(1,i)=subpoltable(1,i)+2;
        end
    end
end
poltable=zeros(1,n);
for i=1:n
    poltable(1,stat(1,i))=subpoltable(1,i);
end
end