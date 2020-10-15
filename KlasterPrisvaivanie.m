function handles=KlasterPrisvaivanie(handles,klaster)
handles.antenna.klaster=klaster;
n=numel(klaster);
handles.antenna.DN=[];
handles.antenna.System.DNotobr=[];
handles.antenna.System.polardevision=0;
handles.antenna.initflags(2)=1;
handles.antenna.initflags(3)=1;
handles.antenna.initflags(4)=0;
handles.antenna.initflags(6)=0;
handles.Tabs.drawedflags(3)=0;
handles.Tabs.drawedflags(4)=0;
handles.Tabs.drawedflags(6)=0;
handles.antenna.CountType=1;
if handles.antenna.initflags(1)
    %------------------inicializaciya-------------------------------------    
        OtobrStruct=myinit3();
        for i=1:n
            DNstruct=myinit1(handles,i);
            if i==1
                handles.antenna.DN=DNstruct;
                handles.antenna.System.DNotobr=OtobrStruct;
            else
                handles.antenna.DN(i,1)=DNstruct;
                handles.antenna.System.DNotobr(i,1)=OtobrStruct;
            end
        end
end
end
function Struct=myinit1(handles,i)
    Struct.X=handles.antenna.klaster(i).X;
    Struct.Y=handles.antenna.klaster(i).Y;
    Struct.DNinit=[0 0 0 0];
    Struct.Diagram(1)=myinit2();
    Struct.Diagram(2)=myinit2();
    Struct.Diagram(3)=myinit2();
    Struct.Diagram(4)=myinit2();
end
function Struct=myinit2()
    Struct.L=NaN;
    Struct.T=NaN;
    Struct.Prostr=NaN;
    Struct.DiagramSTK.L=NaN;
    Struct.DiagramSTK.T=NaN;
    Struct.DiagramSTK.ProstrX=NaN;
    Struct.DiagramSTK.ProstrY=NaN;
    Struct.parametrs=struct('Psi0L',NaN,'Psi0T',NaN,'GaFull',NaN,'TH05LMain',NaN,'TH05TMain',NaN,...
    'TH05L',NaN,'TH05T',NaN,'UBLLleft',NaN,'UBLLright',NaN,'UBLTleft',NaN,'UBLTright',NaN,...
        'Frequency',NaN,'Polar',NaN,'Ga',NaN);
end
function Struct=myinit3()
    Struct.DNinit=[0 0 0 0];
    Struct.choisepolar=0;
    Struct.activ=1;%1 - net ; 0 - da
end