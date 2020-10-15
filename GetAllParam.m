function allparam=GetAllParam(baseparam)
D=baseparam.D;
C=baseparam.C;
F=baseparam.F;
alfa0=baseparam.alfa0*pi/180;
R0=baseparam.R0;
F1=baseparam.F1*10^9;
F2=baseparam.F2*10^9;
c=2.9979246*10^8;

alfa1=2*atan((C+D)/F/2);
alfa2=2*atan(C/2/F);
alfas=(alfa1+alfa2)/2;

lambdaF1=c/F1;
lambdaF2=c/F2;
lambda=(lambdaF1+lambdaF2)/2;
k=2*pi/lambda;
%-------------------------------
FunAlfa=@(alfa)MinMaxAlfa0(C,D,F,k,R0,alfa);
alfas=fminsearch(FunAlfa,alfas);
%-------------------------------
allparam.D=D;
allparam.C=C;
allparam.F=F;


allparam.alfa0=alfa0;
allparam.alfa1=alfa1;
allparam.alfa2=alfa2;
allparam.alfas=alfas;

allparam.F1=F1;
allparam.F2=F2;
allparam.lambdaF1=lambdaF1;
allparam.lambdaF2=lambdaF2;
allparam.R0=R0;

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
function res=PoleGl(x,y,C,D,F,alfa0,k,R0)
funL=@(alfa)(abs(fL(alfa,alfa0).*(ee(alfa-alfa0,k,R0)+1i.*eh(alfa-alfa0,k,R0))));
funT=@(alfa)(abs(fT(alfa).*(ee(alfa,k,R0)+1i.*eh(alfa,k,R0))));
res=pmnog(x,y,C,D,F,alfa0).*Egl(x,y,C,D,F,alfa0).*...
    AmplDNRupor3D(x,y,funL,funT,C,D,F,alfa0);
end
function res=PolePr(x,y,C,D,F,alfa0,k,R0)
funL=@(alfa)(abs(fL(alfa,alfa0).*(ee(alfa-alfa0,k,R0)+1i.*eh(alfa-alfa0,k,R0))));
funT=@(alfa)(abs(fT(alfa).*(ee(alfa,k,R0)+1i.*eh(alfa,k,R0))));
res=pmnog(x,y,C,D,F,alfa0).*Ekr(x,y,C,D,F,alfa0).*...
    AmplDNRupor3D(x,y,funL,funT,C,D,F,alfa0);
end
function res=XotY(y,C,D,f,alfa)
res= -(2*f - 8*((f^2*tan(alfa).^2)/16 + f^2/16 - (y.^2*tan(alfa).^2)/64).^(1/2))./tan(alfa)-D/2-C;
if alfa==0
    res=0;
end
end
function res=MinMaxAlfa0(C,D,F,k,R0,alfa0)
res=20*log10(abs(PoleGl(-D/2,0,C,D,F,alfa0,k,R0)-PoleGl(D/2,0,C,D,F,alfa0,k,R0)));
end
