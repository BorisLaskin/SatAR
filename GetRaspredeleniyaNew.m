function Spole=GetRaspredeleniyaNew(s,lambda,tol1)
k=2*pi/lambda;
R0=s.R0;
D=s.D;
C=s.C;
F=s.F;
alfa0=s.alfas;
alfa1=s.alfa1;
alfa2=s.alfa2;
fi0=abs(alfa1-alfa2)/2;
%-------------------------------------------------------------
stk1=[-D/2:D/tol1:D/2];
[stkX,stkY]=meshgrid(stk1,stk1);
stk2=linspace(-fi0,fi0,200);
stk3=linspace(alfa2,alfa1,200);
%DN rupora------------------------------------------------------------
Spole.G.DNL=abs(eh(stk3-alfa0,k,R0).*fL(stk3,alfa0));
Spole.G.DNT=abs(ee(stk2,k,R0).*fT(stk2));

Spole.V.DNL=abs(ee(stk3-alfa0,k,R0).*fL(stk3,alfa0));
Spole.V.DNT=abs(eh(stk2,k,R0).*fT(stk2));
%Koefficient peredachi ot obluchatelya k zerkalu-------------
integ1=@(alfa)(abs(sin(alfa)).*(abs(eh(alfa-alfa0,k,R0).*fL(alfa,alfa0))).^2);
integ2=@(alfa)(abs(sin(alfa)).*abs((ee(alfa,k,R0).*fT(alfa))).^2);
integ3=@(alfa)(abs(sin(alfa)).*(abs(ee(alfa-alfa0,k,R0).*fL(alfa,alfa0))).^2);
integ4=@(alfa)(abs(sin(alfa)).*abs((eh(alfa,k,R0).*fT(alfa))).^2);
%------------------------------------------------------------
ngL=quad(integ1,alfa2,alfa1,10^-7)/quad(integ1,-pi,pi,10^-7);
ngT=quad(integ2,0,fi0,10^-7)/quad(integ2,0,pi,10^-7);

nvL=quad(integ3,alfa2,alfa1,10^-7)/quad(integ3,-pi,pi,10^-7);
nvT=quad(integ4,0,fi0,10^-7)/quad(integ4,0,pi,10^-7);
n=(ngL+ngT+nvL+nvT)/4;
%----------------Pole----------------------------------------
XmaxG=fminbnd(@(x)-PoleGorGl(x,0,C,D,F,alfa0,k,R0),-D/2,D/2);
XmaxV=fminbnd(@(x)-PoleVerGl(x,0,C,D,F,alfa0,k,R0),-D/2,D/2);

Spole.G.AmplPoleGL=PoleGorGl(stkX,stkY,C,D,F,alfa0,k,R0)./...
    PoleGorGl(XmaxG,0,C,D,F,alfa0,k,R0);
Spole.G.AmplPolePR=PoleGorPr(stkX,stkY,C,D,F,alfa0,k,R0)./...
    PoleGorGl(XmaxG,0,C,D,F,alfa0,k,R0);

Spole.V.AmplPoleGL=PoleVerGl(stkX,stkY,C,D,F,alfa0,k,R0)./...
    PoleVerGl(XmaxV,0,C,D,F,alfa0,k,R0);
Spole.V.AmplPolePR=PoleVerPar(stkX,stkY,C,D,F,alfa0,k,R0)./...
    PoleVerGl(XmaxV,0,C,D,F,alfa0,k,R0);
%Aperturnij KIP----------------------------------------------
integ5=@(x,y)interp2(stkX,stkY,Spole.G.AmplPoleGL,x,y,'spline');
integ6=@(x,y)interp2(stkX,stkY,Spole.V.AmplPoleGL,x,y,'spline');

vgL=2*(quad(@(x)integ5(x,0),-D/2,D/2)).^2/...
    (2*D*quad(@(x)(integ5(x,0)).^2,-D/2,D/2));
vgT=2*(quad(@(y)integ5(XmaxG,y),-D/2,D/2)).^2/...
    (2*D*quad(@(y)(integ5(XmaxG,y)).^2,-D/2,D/2));

vvL=2*(quad(@(x)integ6(x,0),-D/2,D/2)).^2/...
    (2*D*quad(@(x)(integ6(x,0)).^2,-D/2,D/2));
vvT=2*(quad(@(y)integ6(XmaxV,y),-D/2,D/2)).^2/...
    (2*D*quad(@(y)(integ6(XmaxV,y)).^2,-D/2,D/2));
v=(vgL+vgT+vvL+vvT)/4;

Spole.G.kip=(vgL+vgT)*(ngL+ngT)/4;
Spole.V.kip=(vvL+vvT)*(nvL+nvT)/4;
%------------------------------------------------------------
dE1=abs(interp2(stkX,stkY,Spole.G.AmplPoleGL,D/2,0,'spline')-interp2(stkX,stkY,Spole.G.AmplPoleGL,-D/2,0,'spline'));
dE2=abs(interp2(stkX,stkY,Spole.V.AmplPoleGL,D/2,0,'spline')-interp2(stkX,stkY,Spole.V.AmplPoleGL,-D/2,0,'spline'));
dE=(dE1+dE2)/2;
%------------------------------------------------------------
Spole.G.Xmax=XmaxG;
Spole.V.Xmax=XmaxV;
Spole.n=n;
Spole.v=v;
Spole.kip=n*v;
Spole.dE=dE;

Spole.stkX=stkX;
Spole.stkY=stkY;
Spole.stkDNT=stk2;
Spole.stkDNL=stk3;
Spole.stkpole=stk1;
end
function res=Falfa(x,y,C,D,F,alfa0)
A=x+C+D/2;
B=(A.^2+y.^2-4*F^2)/4/F;
Chisl=sqrt((A*cos(alfa0)+B*sin(alfa0)).^2+y.^2);
Znam=A*sin(alfa0)-B*cos(alfa0);
res=atan(Chisl./Znam);

ind=isnan(res);
[ind_i,ind_j]=find(ind==1);
n=numel(ind_i);
if n~=0
    for i=1:n
            a1=x(ind_i(i),ind_j(i))-1.0000e-010;
            a2=x(ind_i(i),ind_j(i))+1.0000e-010;
            a3=y(ind_i(i),ind_j(i));
            
            A=a1+C+D/2;
            B=(A^2+a3^2-4*F^2)/4/F;
            Chisl=sqrt((A*cos(alfa0)+B*sin(alfa0))^2+a3^2);
            Znam=A*sin(alfa0)-B*cos(alfa0);
            res1=atan(Chisl/Znam);
            
            A=a2+C+D/2;
            B=(A^2+a3^2-4*F^2)/4/F;
            Chisl=sqrt((A*cos(alfa0)+B*sin(alfa0))^2+a3^2);
            Znam=A*sin(alfa0)-B*cos(alfa0);
            res2=atan(Chisl/Znam);
            
            res(ind_i(i),ind_j(i))=(res1+res2)/2;
    end
end

end
function res=fL(alfa,alfa0)
res=(1+cos(alfa-alfa0))/2;
end
function res=fT(alfa)
res=(1+cos(alfa))/2;
end
function res=ee(alfa,k,R0)
A=k*R0*sin(alfa);
B=ones(size(alfa));
res=2*besselj(B,A)./A;

ind=isnan(res);
[ind_i,ind_j]=find(ind==1);
n=numel(ind_i);
if n~=0
    for i=1:n
            a=alfa(ind_i(i),ind_j(i))-1.0000e-010;
            b=alfa(ind_i(i),ind_j(i))+1.0000e-010;
            A=k*R0*sin(a);
            res1=2*besselj(1,A)/A;
            A=k*R0*sin(b);
            res2=2*besselj(1,A)/A;
            res(ind_i(i),ind_j(i))=(res1+res2)/2;
    end
end
res=abs(res);
end
function res=eh(alfa,k,R0)
A=k*R0*sin(alfa);
B=ones(size(alfa));
B=B+1;
res=8*besselj(B,A)./(A.^2);

ind=isnan(res);
[ind_i,ind_j]=find(ind==1);
n=numel(ind_i);
if n~=0
    for i=1:n
            a=alfa(ind_i(i),ind_j(i))-1.0000e-010;
            b=alfa(ind_i(i),ind_j(i))+1.0000e-010;
            A=k*R0*sin(a);
            res1=8*besselj(2,A)/(A^2);
            A=k*R0*sin(b);
            res2=8*besselj(2,A)/(A^2);
            res(ind_i(i),ind_j(i))=(res1+res2)/2;
    end
end
res=abs(res);
end
function res=pmnog(x,y,C,D,F,alfa0)
A=((x+C+D/2).^2+y.^2)/4/F;
B=2*F/(1+cos(alfa0));
flag=isnan(B);
if flag==1
    B1=2*F/(1+cos(alfa0+1.0000e-010));
    B2=2*F/(1+cos(alfa0-1.0000e-010));
    B=(B1+B2)/2;
end
res=B*1./(F+A);
end
function res=Egl(x,y,C,D,F,alfa0)
A1=2*F./(tan(Falfa(x,y,C,D,F,alfa0)));
A2=sqrt(y.^2+(D/2+x+C+A1).^2);
res=(D/2+x+A1)./A2;

ind=isnan(res);
[ind_i,ind_j]=find(ind==1);
n=numel(ind_i);
if n~=0
    for i=1:n
        a1=x(ind_i(i),ind_j(i))-1.0000e-010;
        a2=x(ind_i(i),ind_j(i))+1.0000e-010;
        a3=y(ind_i(i),ind_j(i));
        
        A1=2*F/(tan(Falfa(a1,a3,C,D,F,alfa0)));
        A2=sqrt(a3^2+(D/2+a1+C+A1)^2);
        res1=(D/2+a1+A1)/A2;
        
        A1=2*F/(tan(Falfa(a2,a3,C,D,F,alfa0)));
        A2=sqrt(a3^2+(D/2+a2+C+A1)^2);
        res2=(D/2+a2+A1)/A2;
        
        res(ind_i(i),ind_j(i))=(res1+res2)/2;
    end
end
end
function res=Ekr(x,y,C,D,F,alfa0)
A=sqrt(y.^2+(D/2+C+x+2*F./tan(Falfa(x,y,C,D,F,alfa0))).^2);
res=y./A;

ind=isnan(res);
[ind_i,ind_j]=find(ind==1);
n=numel(ind_i);
if n~=0
    for i=1:n
        a1=x(ind_i(i),ind_j(i))-1.0000e-010;
        a2=x(ind_i(i),ind_j(i))+1.0000e-010;
        a3=y(ind_i(i),ind_j(i));
        
        A=sqrt(a3^2+(D/2+C+a1+2*F/tan(Falfa(a1,a3,C,D,F,alfa0)))^2);
        res1=a3/A;
        
        A=sqrt(a3^2+(D/2+C+a2+2*F/tan(Falfa(a2,a3,C,D,F,alfa0)))^2);
        res2=a3/A;
        
        res(ind_i(i),ind_j(i))=(res1+res2)/2;
    end
end
end
function res=AmplDNRupor3D(x,y,funL,funT,C,D,F,alfa0)
A=(x+C+D/2);
psiL=atan(A./(F-(A.^2+y.^2)/4/F));
ind=isnan(psiL);
[ind_i,ind_j]=find(ind==1);
n=numel(ind_i);
if n~=0
    for i=1:n
        y1=y(ind_i(i),ind_j(i))+1.0000e-010;
        y2=y(ind_i(i),ind_j(i))-1.0000e-010;
        
        res1=atan(A(ind_i(i),ind_j(i))/(F-(A(ind_i(i),ind_j(i))^2+y1.^2)/4/F));
        res2=atan(A(ind_i(i),ind_j(i))/(F-(A(ind_i(i),ind_j(i))^2+y2.^2)/4/F));
        
        psiL(ind_i(i),ind_j(i))=(res1+res2)/2;
    end
end

psiT=atan(y./(F-(A.^2+y.^2)/4/F));
ind=isnan(psiT);
[ind_i,ind_j]=find(ind==1);
n=numel(ind_i);
if n~=0
    for i=1:n
        y1=y(ind_i(i),ind_j(i))+(1.0000e-010);
        y2=y(ind_i(i),ind_j(i))-(1.0000e-010);
        
        res1=atan(y1./(F-(A(ind_i(i),ind_j(i))^2+y1.^2)/4/F));
        res2=atan(y2./(F-(A(ind_i(i),ind_j(i))^2+y2.^2)/4/F));
        
        psiT(ind_i(i),ind_j(i))=(res1+res2)/2;
    end
end

fi=atan(tan(psiT)./tan(psiL-alfa0));
fi(find(psiL-alfa0<0))=fi(find(psiL-alfa0<0))+pi; %#ok<FNDSB>
ind=isnan(fi);
[ind_i,ind_j]=find(ind==1);
n=numel(ind_i);
if n~=0
    for i=1:n
        fi(ind_i(i),ind_j(i))=0;
    end
end
%th=atan(tan(psiL-alfa0)./cos(fi));
th=Falfa(x,y,C,D,F,alfa0);
FL=abs(feval(funL,th.*sign(cos(fi))+alfa0));
FT=abs(feval(funT,th.*sign(sin(fi))));
res=sqrt((FL.*cos(fi)).^2+(FT.*sin(fi)).^2);
end
function res=PoleGorGl(x,y,C,D,F,alfa0,k,R0)
funL=@(alfa)(fL(alfa,alfa0).*eh(alfa-alfa0,k,R0));
funT=@(alfa)(fT(alfa).*ee(alfa,k,R0));
res=pmnog(x,y,C,D,F,alfa0).*Egl(x,y,C,D,F,alfa0).*...
    AmplDNRupor3D(x,y,funL,funT,C,D,F,alfa0);
end
function res=PoleGorPr(x,y,C,D,F,alfa0,k,R0)
funL=@(alfa)(fL(alfa,alfa0).*eh(alfa-alfa0,k,R0));
funT=@(alfa)(fT(alfa).*ee(alfa,k,R0));
res=pmnog(x,y,C,D,F,alfa0).*Ekr(x,y,C,D,F,alfa0).*...
    AmplDNRupor3D(x,y,funL,funT,C,D,F,alfa0);
end
function res=PoleVerGl(x,y,C,D,F,alfa0,k,R0)
funL=@(alfa)(fL(alfa,alfa0).*ee(alfa-alfa0,k,R0));
funT=@(alfa)(fT(alfa).*eh(alfa,k,R0));
res=pmnog(x,y,C,D,F,alfa0).*Egl(x,y,C,D,F,alfa0).*...
    AmplDNRupor3D(x,y,funL,funT,C,D,F,alfa0);
end
function res=PoleVerPar(x,y,C,D,F,alfa0,k,R0)
funL=@(alfa)(fL(alfa,alfa0).*ee(alfa-alfa0,k,R0));
funT=@(alfa)(fT(alfa).*eh(alfa,k,R0));
res=pmnog(x,y,C,D,F,alfa0).*Ekr(x,y,C,D,F,alfa0).*...
    AmplDNRupor3D(x,y,funL,funT,C,D,F,alfa0);
end