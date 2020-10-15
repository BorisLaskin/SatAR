function handles=DiagStart(handles)
n=numel(handles.antenna.klaster);
list2={'F1T','F1L','F2T','F2L'};
Val='NotCancel';

if handles.antenna.initflags(1)&&handles.antenna.initflags(2)
    if handles.antenna.CountType
        Val=questdlg('Да, выполнить. Нет, выполнить на текущей конфигурации. Отмена, прервать расчет','Полный рассчет займет длительное время.');
    end
    if ~strcmp(Val,'Cancel')
        if strcmp(Val,'No')
            handles.antenna.CountType=0;
        end
    %------------------inicializaciya-------------------------------------
        handles.antenna.DN=[];
        handles.antenna.System.DNotobr=[];
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
        for i=1:n
            string=strcat(handles.antenna.klaster(i).frequency,handles.antenna.klaster(i).polarization);
            ind2=find(strcmp(list2,string));
            switch ind2
                case 1
                    handles.antenna.DN(i).DNinit=[1 0 0 0];
                    handles.antenna.System.DNotobr(i).choisepolar=1;
                case 2
                    handles.antenna.DN(i).DNinit=[0 1 0 0];
                    handles.antenna.System.DNotobr(i).choisepolar=2;
                case 3
                    handles.antenna.DN(i).DNinit=[0 0 1 0];
                    handles.antenna.System.DNotobr(i).choisepolar=3;
                case 4
                    handles.antenna.DN(i).DNinit=[0 0 0 1];
                    handles.antenna.System.DNotobr(i).choisepolar=4;
                otherwise
            end
        end
        if handles.antenna.CountType
            for i=1:n
                handles.antenna.DN(i).DNinit=[1 1 1 1];
            end
        end
        for i=1:n
            handles.antenna.System.DNotobr(i).DNinit=handles.antenna.DN(i).DNinit;
        end
    %------------------raschet-------------------------------------
    handles=feval(handles.preferences.functions.Diagram,handles);
    else
        handles.antenna.initflags(4)=0;
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