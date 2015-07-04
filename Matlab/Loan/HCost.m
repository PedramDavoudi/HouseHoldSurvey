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
if StartYear>90
    StartYear=90;
end
if EndYear>90
    EndYear=90;
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
        X=codec(Y,1,Fname); % Just Urban 
        if ~isa(X,'dataset')
           continue; 
        end
     X.year=Y*ones(size(X,1),1);
     for j=3:5
        X.Properties.VarNames{j}=['C' num2str(j)];
     end
    %   
 if ~exist('Res','var')
     Res=X;
 else
    Res=[Res;X];
 end
   % TT=TU;
   
   % clear TR TU;
  %  TT.Year=Y*ones(size(TT.Address,1));
  %  disp('Exporting . . . ');
 %   export(TT,'XLSfile',['T' num2str(Y)]);
 %   eval(['T' num2str(Y) '=TT;']);
  % clear TT;
  
end

Res=Res(~isnan(Res.Code),:);
   disp('Exporting . . . ');
 %   export(Res,'XLSfile','KharidMaskan');
    
 %Cat=[  {'Year'}, {'WRent'}, {'WPrice'}, {'WEnsurance'} , {'Rent'}, {'Price'}, {'Ensurance'}];
a=toc;
clc;
disp(['All Done in ' num2str(fix(a/60)) ':' num2str(a-60*fix(a/60))]);
%clear a Fname Rg Y r;
