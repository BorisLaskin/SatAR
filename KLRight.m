function [stat,list]=KLRight(klaster)
n=numel(klaster);
k=0;
stat=0;
a=2;
list=[];
for i=1:n
    for j=i:n
        if i~=j 
            a=sqrt((klaster(i).X-klaster(j).X)^2+(klaster(i).Y-klaster(j).Y)^2);
        end
        if a<1.99
            k=k+1;
            list{k}=[i j];
            stat=1;
        end
    end
end
end
