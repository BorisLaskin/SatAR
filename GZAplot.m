function handles=GZAplot(handles,tol)
axes(handles.ax3Dant);
D=handles.antenna.baseparam.D;
C=handles.antenna.baseparam.C;
F=handles.antenna.baseparam.F;
alfa0=handles.antenna.allparam.alfa0;
alfa1=handles.antenna.allparam.alfa1;
alfa2=handles.antenna.allparam.alfa2;
ro1=2*F/(1+cos(alfa1));
ro2=2*F/(1+cos(alfa2));

R0=handles.antenna.baseparam.R0;
nto4hek=tol;
if C<0
    Zmax=max([F-ro2*cos(alfa2),F-ro1*cos(alfa1)]);
    z1=linspace(Zmax,0,nto4hek);
    z2=linspace(0,Zmax,nto4hek);
    z=[z1,z2];
    y=linspace(-D/2,D/2,nto4hek);
    [Z1,Y]=meshgrid(z1,y);
    [Z2,Y]=meshgrid(z2,y);
    X1=-sqrt(4*F*Z1-Y.^2);
    X2=sqrt(4*F*Z2-Y.^2);
    X=[X1,zeros(size(X1(:,1))),X2];
    Z0=(Y(:,1).^2)/4/F;
    Z=[Z1,Z0,Z2];
    Y=[Y,Y(:,1),Y];
else
    z=linspace(F-ro2*cos(alfa2),F-ro1*cos(alfa1),nto4hek);
    y=linspace(-D/2,D/2,nto4hek);
    [Z,Y]=meshgrid(z,y);
    X=sqrt(4*F*Z-Y.^2);
end
n=size(X);
for i1=1:n(1)
    for i2=1:n(2)
        if imag(X(i1,i2))||((real(X(i1,i2))-D/2-C)^2+Y(i1,i2)^2)>D^2/4
            X(i1,i2)=NaN;
        end
    end
end
mesh(Z,Y,real(X),ones(size(X)));
xlabel('Z');ylabel('Y');zlabel('X');


[ZC,YC,XC]=cylinder(R0,10);
XC=XC*R0*8;
n1=size(XC);
XZ=XC+1i*ZC;
XZ=XZ*exp(-1i*(pi/2-alfa0));
XC=real(XZ);
ZC=imag(XZ);
hold on;
mesh(ZC+F,YC,real(XC),ones(size(XC)));
z0=linspace(0,F,100);
[Z0,Y0]=meshgrid(z0,[0 0]);
X0=zeros(size(Z0));
mesh(Z0,Y0,X0);
set(handles.ax3Dant,'CameraPosition',[21.4642 -26.2834 5.32445]);
axis tight;
axis equal;

hold off;

end