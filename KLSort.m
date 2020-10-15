function Modklaster=KLSort(klaster)
n=numel(klaster);
tempklCopy=klaster(1);
flag=0;
for i=1:n
    tempkl=klaster(i);
    tempI=i;
    for j=i:n
        if tempkl.Y<klaster(j).Y
            tempkl=klaster(j);
            tempI=j;
        elseif tempkl.Y==klaster(j).Y
            if tempkl.X>klaster(j).X
                tempkl=klaster(j);
                tempI=j;
            end
        end
    end
    tempklCopy=klaster(i);
    klaster(i)=klaster(tempI);
    klaster(tempI)=tempklCopy;
end
Modklaster=klaster;
end