function [prupr,ptext]=KLplot(curaxes,klaster)
axes(curaxes);
prupr=zeros(numel(klaster),1);
ptext=zeros(numel(klaster),1);
for i=1:numel(klaster)
    prupr(i)=rectangle('Curvature',[1 1],'Position',...
        [klaster(i).X-1 klaster(i).Y-1 2 2]);
    ptext(i)=text(klaster(i).X,klaster(i).Y,num2str(i));
end
end