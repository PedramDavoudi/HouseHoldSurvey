function [Res]=une(StartYear,EndYear)
% I will calc unemployment rate 
if nargin==1 
    EndYear=StartYear;
end
tic;
%{
[FileName,PathName,~] = uigetfile('*.*');% get file location 
Fname=[PathName FileName];
Y=str2double(FileName(1:2));
%}
%%{ 
%the below code is ok just in my pc
%Y=90;
clear Res;
for Y=StartYear:EndYear
[~, Fname]=init0(Y,0); % initial Value
%}
%{ 
%for iteration
Y=76;
tic;
if nargin==1 
    EndYear=StartYear;
end
for Y=StartYear:EndYear
%}
   % for r=0:1
        %[Rg, ~]=init0(Y,r); % initial Value
        X=codeUN(Y,Fname,1);
        if ismember('Res',who)
            Res=vertcat(Res,X);
        else
            Res=X;
        end
        clear X;
       % X = Refine(X,Y);
        %C=codep(Y,r,Fname);
%       eval(['T' Rg num2str(Y) '= join(X, C,''key'',''Address'',''Type'',''outer'',''MergeKeys'',true);']);
       % end
 %{
  %  TT=vertcat(TR,TU);
    %clear TR TU;
    %TT.Year(1:size(TT.Address,1))=Y;
    disp('Exporting . . . ');
    export(TT,'XLSfile',['T' num2str(Y)]);
    eval(['T' num2str(Y) '=TT;']);
    clear TT;
%end
       %}
end
Res.Properties.VarNames{3} = 'Employed';
Res.Properties.VarNames{4} = 'Unemployed';
Res.Properties.VarNames{5} = 'Active';
Res.Properties.VarNames{end-1} = 'Unemployment_Rate';
disp('Exporting . . . ');

try
    export(Res,'XLSfile','Unemployment');
catch
    
    Nmn=input('the default name may be in use, enter another name to save xls file: ', 's');
    if Nmn~=''
        export(Res,'XLSfile',Nmn);
    end
end
a=toc;
clc;
disp(['All Done in ' num2str(fix(a/60)) ':' num2str(a-60*fix(a/60))]);
%clear a Fname Rg Y r;
%%
end
function [stats stats1]=codeUN(Y,Fname,Ismonth)

%Y : theyear
%Fname,
%Ismonth,1 means decompose monthly
if nargin==2
   Ismonth=0; 
end
%%
%this code will extract Data
for r=0:1
        [~, Rg ,~]=init1(Y,r); % initial Value
        disp(['Loading ' Rg num2str(Y) 'P1']);
        %%
            [~, ~, Data] = readacc( Fname,[Rg num2str(Y) 'P1']);           % open access file
        Data.Properties.VarNames{1} = 'Address';
        Data.Region=r*ones(1,size(Data,1)).';
        %loading Data of Mahe morajee
        if Ismonth==1
                MData=MRet(Data.Address,Y,Fname,[Rg num2str(Y)]);
        end
        
        %----------------------------------
        %clear Du Dr;
       %  Data.Year(:,1)=Y;
        disp('Load Done'); 
        %{ 
        to ensure about cols' name
        %}
       if Y==92
          Data(:,'DYCOL02') = []; 
       end
        Data.Properties.VarNames (2:7) = {'DYCOL01' ;'DYCOL03' ;'DYCOL04' ;'DYCOL05'; 'DYCOL06'  ; 'DYCOL07'  };
       
        if Y<66
             Data.Properties.VarNames{9} = 'DYCOL056';%is important; 1:shagel 2:joya
             Data.Properties.VarNames{11} = 'DYCOL09';%is important; 1:shagel 2:joya
        else
            
            Data.Properties.VarNames{9} = 'DYCOL09';%is important; 1:shagel 2:joya
        end
        Data.Properties.VarNames{10} = 'DYCOL10';
        %convert to num: Just important cols
        %Data.DYCOL01=str2num(cell2mat(Data.DYCOL01));
        %Data.DYCOL03=str2num(cell2mat(Data.DYCOL03));
        %Data.DYCOL04(strcmp(Data.DYCOL04,{''}))={'0'};
        %Data.DYCOL04=str2num(cell2mat(Data.DYCOL04));
        Data.DYCOL05(strcmp(Data.DYCOL05,{''}))={'00'};
        Data.DYCOL05=cell2num(Data.DYCOL05);
        %Data.DYCOL06=str2num(cell2mat(Data.DYCOL06));
        %Data.DYCOL07=str2num(cell2mat(Data.DYCOL07));
        %Data.DYCOL08(strcmp(Data.DYCOL08,{'-'}))={'0'};
        %Data.DYCOL08(strcmp(Data.DYCOL08,{''}))={'0'};
        %Data.DYCOL08=str2num(cell2mat(Data.DYCOL08)); %#ok<*ST2NM>
        Data.DYCOL09(strcmp(Data.DYCOL09,{''}))={'0'};
        Data.DYCOL09=cell2num(Data.DYCOL09);
        %Data.DYCOL10=str2num(cell2mat(Data.DYCOL10));
        if Ismonth==1
        Data=join(Data,MData,'key','Address','Type','outer','MergeKeys',true);
        %Data.MahMorajeh(strcmp(Data.MahMorajeh,{''}))={'00'};
        
        else
            Data.MahMorajeh=13*ones(size(Data.Address,1),1);
        end
        %create Dataset
        %Data = dataset(Data(2:end,1),[cell2mat(Data(2:end,2:end)) Data(1,2:end)] );
        if ismember('X89',who)
          %  X89 = join(X89,Data,'key','Address','Type','outer','MergeKeys',true);
          X89=vertcat(X89,Data);
        else
            X89=Data;%(Data.DYCOL01==1,:);
        end
        clear Data MData;
end
%%
% remove useless column
nn=size(X89,2);
i=2;
while(i<=nn)
    Ans=X89.Properties.VarNames{i} ;
    if ~strcmp(Ans,'DYCOL05') && ~strcmp(Ans,'DYCOL09')&& ~strcmp(Ans,'Region')&& ~strcmp(Ans,'MahMorajeh')
        X89.(Ans)=[];
       nn=nn-1;
    else
        i=i+1;
    end
end
%        X89.DYCOL03=[];
   if Y<69 % ?????? ????? ????? ??? ???? ?????? ???.
       X89.DYCOL09(X89.DYCOL09>9)=fix(X89.DYCOL09(X89.DYCOL09>9)/10);
   end
   if Y>86 %change month to season
       X89.MahMorajeh=ceil(X89.MahMorajeh/3);
   end
    X89(isnan(X89.DYCOL09),:)=[];
       % disp('count ages between 16-64');
         % count ages 16-64
        X89.W_H= (X89.DYCOL05>15).* (X89.DYCOL05<65);
        X89.em= X89.DYCOL09==1 ;% has job
        if Y<69
            a1=X89.DYCOL09==2;
            a2=X89.DYCOL09==4;
           X89.nem=  a1+a2 ;% look for job
           clear a1 a2;
        else
            X89.nem= X89.DYCOL09==2;% look for job
        end
        X89.emc= X89.em.* X89.W_H;% has job checked by age
        X89.nemc= X89.nem.* X89.W_H;% look for job checked by age
        X89.act=X89.nem+X89.em ;% look for job
        X89.actc= X89.act.* X89.W_H ;% look for job checked by age
        %stats = datasetfun(@sum,X89,'DataVars',{'nem','act'},'UniformOutput',false);
        %stats = grpstats(X89,{'Region','act'},@sum,'DataVars',{'nem','act'});
        
        
         
        %disp('Recognize province');
        X89.Province=cellfun(@(x)x(2:3),X89.Address, 'UniformOutput' , false);
        %disp('Dummy for every province');
       % for i=0:30
        %x=find(str2num(cell2mat(X89.Province))==i);
         %X89.(['P' num2str(i)])(x,1)=1;
        %  X89.('Province')(str2num(cell2mat(X89.Province))==i,1)={i};
       % end
        %- ------------------------------------------- with mahe moraje
        if Ismonth==1
            % summry by province
            stats1 = grpstats(X89,{'Region', 'Province' , 'MahMorajeh'},@sum,'DataVars',{'emc','nemc','actc'});
            stats2 = grpstats(X89,{ 'Province' , 'MahMorajeh'},@sum,'DataVars',{'emc','nemc','actc'});
             stats1.Properties.ObsNames= [];
              stats2.Properties.ObsNames= [];
            stats2.Region=3*ones(1,size(stats2,1)).';

            % summry by country
            stats3 = grpstats(X89, {'Region', 'MahMorajeh'} ,@sum,'DataVars',{'emc','nemc','actc'});
            stats3.Properties.ObsNames= [];
            
           
            stats3.Province=repmat({'99'},size(stats3,1),1);%{'99';'99';'99'};
          stats3=vertcat(stats3,stats1,stats2);
          clear stats1 stats2;
          stats1 = grpstats(X89,  'MahMorajeh' ,@sum,'DataVars',{'emc','nemc','actc'});
            stats1.Properties.ObsNames= [];
            stats1.Province=repmat({'99'},size(stats1,1),1);
            stats1.Region=3*ones(1,size(stats1,1)).';
             stats3=vertcat(stats3,stats1);
          clear stats1;
        end
       %- ------------------------------------------- with out mahe moraje
        % summry by province
        stats1 = grpstats(X89,{'Region', 'Province'},@sum,'DataVars',{'emc','nemc','actc'});
        stats2 = grpstats(X89,'Province',@sum,'DataVars',{'emc','nemc','actc'});
         stats1.Properties.ObsNames= [];
          stats2.Properties.ObsNames= [];
        stats2.Region=3*ones(size(stats2,1),1);
        
        % summry by country
        stats = grpstats(X89,'Region',@sum,'DataVars',{'emc','nemc','actc'});
        stats.Properties.ObsNames= [];
        %refine to clac total
       stats.Region(3)=3;
        for i=2:size(stats,2)
            An=stats.Properties.VarNames{i};
              stats.(An)(3)=stats.(An)(2)+stats.(An)(1);
             
            %{
        stats(i,3)=stats.GroupCount(2)+stats.GroupCount(1);
        stats.sum_nem(3)=stats.sum_nem(2)+stats.sum_nem(1);
        stats.sum_act(3)=stats.sum_act(2)+stats.sum_act(1);
            %}
        end
         stats.Region(3)=3;
         
        stats.Province={'99';'99';'99'};
        stats=vertcat(stats,stats1,stats2);
        stats.MahMorajeh=13*ones(1,size(stats,1)).';
        if  Ismonth==1
            stats=vertcat(stats,stats3);
        end
        stats.ur=stats.sum_nemc./stats.sum_actc; % rate of unemployment
        stats.Year=Y*ones(1,size(stats,1)).';
       
        %------------------------------------------------------
        %%
        %X89.Properties.VarNames{2} = 'Sex';
        %X89.Properties.VarNames{3} = 'Age';
        %X89.Properties.VarNames{4} = 'Education';

disp([num2str(Y) ' Done']);
end

function [Rg  Fname]=init0(Y,r)
% this function return the address of file
if r==0
    Rg='R';
else
    Rg='U';
end
%%
Adres = 'E:\Data\HouseHoldExpenditure\Access\';

if Y == 89 || Y==90 
    Fname = [num2str(Y) '.accdb'];% '"89\89.accdb"
else%if Y > 82 
    Fname = [num2str(Y) '.mdb'];
%else
  %  Fname = [num2str(Y) '\DATA' num2str(Y) ]; %'.dbf'
end 
Fname=[Adres Fname];
%%
%{
[FileName,PathName,~] = uigetfile('*.*');% get file location 
Fname=[PathName FileName];
%}
end

function [M_tp Rg tnam]=init1(Y,r)

    if Y > 82 
        M_tp = 14;
    elseif or(and(Y < 78,Y > 74),  Y < 66 )
        M_tp = 9;
    else
        M_tp = 10;
    end 
if r==0
    Rg='R';
else
    Rg='U';
end
tnam = [Rg num2str(Y) 'P3S'];

  %incom 
   %{
    Tp = '4';
    if Y > 68 
    M_tp = 3;
    else
    M_tp = 5;
    end 
%}
end