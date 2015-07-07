function [Res]=HCost(StartYear,EndYear)
% This Would Caculate House Buying cost
% Runner
tic;
%{
[FileName,PathName,~] = uigetfile('*.*');% get file location 
Fname=[PathName FileName];
Y=str2double(FileName(1:2));
%}

%for iteration
%Y=76;
tic;
if nargin==1 
    EndYear=StartYear;
end
% check some thing
if StartYear>EndYear
    a=StartYear;
    StartYear=EndYear;
    EndYear=a;
    clear a;
end
if StartYear<63
    StartYear=63;
end
if StartYear>92
    StartYear=92;
end
if EndYear>92
    EndYear=92;
end
if EndYear<63
    EndYear=63;
end



%
%Res(EndYear-StartYear+1,3)=0;
%Res=dataset();
%Res.MahMorajeh=0;
for Y=StartYear:EndYear

%if  Y==63 ||  Y==64 ||  Y==65 || Y==66 || Y==67  || Y==75  || Y==76  || Y==77 % for some resson we dont have the data
 %   continue;
%end
[~, Fname]=init0(Y,0); % initial Value
    %for r=0:1
        
        %[Rg, ~]=init0(Y,r); % initial Value
        X0=codec(Y,0,Fname);
        X0=grpstats(X0,{'MahMorajeh' 'Region' 'R8'},'sum','DataVars','Cost');
        X0.Properties.ObsNames =[];
        
        X1=codec(Y,1,Fname);
        X1=grpstats(X1,{'MahMorajeh' 'Region' 'R8'},'sum','DataVars','Cost');
        X1.Properties.ObsNames =[];
        % X=[codec(Y,0,Fname);codec(Y,1,Fname)]; 
        X=[X0;X1];
        X.Year=Y*ones(size(X,1),1);
        % X=grpstats(X,{'Year' 'MahMorajeh' 'Region' 'R8'},'sum','DataVars','Cost');
        %X.Properties.ObsNames =[];
 if ~exist('Res','var')
     Res=X;
 else
    Res=vertcat(Res,X);
 end
   % TT=TU;
   
   % clear TR TU;
  %  TT.Year=Y*ones(size(TT.Address,1));
  %  disp('Exporting . . . ');
 %   export(TT,'XLSfile',['T' num2str(Y)]);
 %   eval(['T' num2str(Y) '=TT;']);
  % clear TT;
  
end
   disp('Exporting . . . ');
    export(Res,'XLSfile',['Dur' num2str(StartYear) '.xlsx']);
    
 %Cat=[  {'Year'}, {'WRent'}, {'WPrice'}, {'WEnsurance'} , {'Rent'}, {'Price'}, {'Ensurance'}];
a=toc;
clc;
disp(['All Done in ' num2str(fix(a/60)) ':' num2str(a-60*fix(a/60))]);
%clear a Fname Rg Y r;
