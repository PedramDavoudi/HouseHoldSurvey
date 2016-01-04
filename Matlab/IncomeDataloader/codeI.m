function [CC]=codeI(Y,r,Fname)
% Return Cost element. for the year Y in r area,
% r=0 is rural
% r=1 is urban
[M_tp, Rg, tnam]=init1(Y,r,0); % initial Value
disp(['Loading Data from ' num2str(Y) ' in ' Rg]);
CC=dataset({''}); %Data Collector will vanish after the end
CC.Properties.VarNames{1} = 'Address';
%%
for i=1:M_tp
    if Y<83
        nm=num2str(i);
    else
        nm=init2(i);
    end
    
    try
        
        [~, ~, Data] = readacc( Fname,[tnam  nm]);  % Read Access File
        
    catch %#ok<CTCH>
        continue;
    end
    disp(['Load '  tnam  nm ' Done' ]);
    %{
    convert to num
    %}
    
    %Ss=Data.Properties.VarNames{end+Oo};% find the Header of the Golden Col
    % there were many error in original Data come from human mistakes which
    % entered the Unknown charachter among the Data two line below remove such
    % data by 0 but may cuase reduce speed
    Oo=size(Data,2);
    Data.Properties.VarNames{1}='Address';
    for o=2:Oo
        Ss=['Y' tnam(2:end)  nm '_Col' num2str(o)];
        Data.Properties.VarNames{o}=Ss;
        Data.(Ss)=cell2num(Data.(Ss));
    end
    clear Ss
    
    
    %%
    
    Data=grpstats(Data,'Address',@sum); % sum Income for every house hold
    Data.GroupCount=[];%remove useless col
    Data.Properties.ObsNames=[];
    for o=2:Oo % Remove sum_ from the begining of header
        Data.Properties.VarNames{o}=Data.Properties.VarNames{o}(5:end);
    end
    
    
    %------------------------------------------------------
    CC = join(CC,Data,'key','Address','Type','outer','MergeKeys',true); %add to data collector
    clear Data;
    if i==1 % delete the '' from the first row
        CC(1,:)=[];
    end
end
% fill Nan With zeo
Oo=size(CC,2);
for o=2:Oo
    Ss=CC.Properties.VarNames{o};
    Aa=isnan(CC.(Ss));
    CC.(Ss)(Aa)=~Aa(Aa);
    %Data.(Ss)=cell2num(Data.(Ss));
end

%%
% catch th parameter mahe morajee
try
    [~, ~, Data] = readacc( Fname,tnam(1:3));  % Read Access File
catch %#ok<CTCH>
    Data=MRet(CC.Address,Y);
end
disp('Load MaheMoraje Done' );
Oo=RsName(0,M_tp); %Return Distance of Golden Col from last col; ocasinally the last col is the cost but sometimes is not
Ss=Data.Properties.VarNames{size(Data,2)+Oo};% find the Header of the Golden Col
Data.(Ss)=cell2num(Data.(Ss));%Data.(Ss)=str2num(char(Data.(Ss))); %#ok<*ST2NM>Data.(Ss)=str2num(cell2mat2(Data.(Ss))); %#ok<*ST2NM>
Data.Properties.VarNames{1} = 'Address';
Data.Properties.VarNames{2} = 'MahMorajeh';
if Y>86  %convert month to season
    Data.MahMorajeh= ceil(Data.MahMorajeh/3);
end
Data=unique(Data,'Address');
CC = join(CC,Data,'key','Address','Type','outer','MergeKeys',true); %add to data collector
%%

aa=sum(isnan(double(CC(:,2:end))),2); %remove nan
CC(aa>1,:)=[]; % 1 is set to avoid noise
CC.Region=r*ones(size(CC,1),1);

disp('Cost Done');
