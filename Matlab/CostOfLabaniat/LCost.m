function [Res Cat]=HCost(StartYear,EndYear)
% This Would Caculate Labaniat Buying cost
% Runner
tic;
%{
[FileName,PathName,~] = uigetfile('*.*');% get file location
Fname=[PathName FileName];
Y=str2double(FileName(1:2));
%}
if ~exist('out','dir')
    mkdir ('out');
end
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
if StartYear>94
    StartYear=94;
end
if EndYear>94
    EndYear=94;
end
if EndYear<63
    EndYear=63;
end



for Y=StartYear:EndYear
    
    [~, Fname]=init0(Y,0); % initial Value
    %for r=0:1
    
    %[Rg, ~]=init0(Y,r); % initial Value
    X=codec(Y,1,Fname); % Just Urban
    eval(['X' num2str(Y) '=X;']);
    save(['out\' num2str(Y) '.mat'], ['X' num2str(Y)]);
    %end
    clear X;
    
end
%    disp('Exporting . . . ');
%     export(Res,'XLSfile','Maskan');
%
%  Cat=[  {'Year'}, {'WRent'}, {'WPrice'}, {'WEnsurance'} , {'Rent'}, {'Price'}, {'Ensurance'}];
a=toc;
clc;
disp(['All Done in ' num2str(fix(a/60)) ':' num2str(a-60*fix(a/60))]);
%clear a Fname Rg Y r;
