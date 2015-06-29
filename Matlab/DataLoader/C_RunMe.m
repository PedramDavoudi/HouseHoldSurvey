%function RunMe(StartYear,EndYear)
% Runner
tic;
%{
[FileName,PathName,~] = uigetfile('*.*');% get file location 
Fname=[PathName FileName];
Y=str2double(FileName(1:2));
%}
%%{ 
%the below code is ok just in my pc
Y=80;
[~, Fname]=init0(Y,0); % initial Value

%}
%{ 
%for iteration
if nargin==1 
    EndYear=StartYear;
end
for Y=StartYear:EndYear
%}
%TT=vertcat(R,U);
TT=vertcat(join(codec(Y,0,Fname), codep(Y,0,Fname),'key','Address','Type','outer','MergeKeys',true),join(codec(Y,1,Fname), codep(Y,1,Fname),'key','Address','Type','outer','MergeKeys',true));
eval(['T' num2str(Y) '=TT;']);
%export(TT,'XLSfile',['T' num2str(Y)]);
clear TT;
%end
a=toc;
clc;
disp(['All Done in ' num2str(fix(a/60)) ':' num2str(a-60*fix(a/60))]);
clear a Fname Y;
