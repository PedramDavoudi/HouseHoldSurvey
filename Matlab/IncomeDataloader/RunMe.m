% is is another version of c_runme.m
%function RunMe(StartYear,EndYear)
% Runner
% tic;
%{
[FileName,PathName,~] = uigetfile('*.*');% get file location
Fname=[PathName FileName];
Y=str2double(FileName(1:2));
%}
%%{
%the below code is ok just in my pc
for Y=84:84
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
    for r=0:1
        [ Rg, ~]=init0(Y,r); % initial Value
        X=codec(Y,r,Fname);
        C=codep(Y,r,Fname);
        eval(['T' Rg num2str(Y) '= join(X, C,''key'',''Address'',''Type'',''outer'',''MergeKeys'',true);']);
        clear X C;
    end
    eval(['global T' num2str(Y)]);
    eval(['TT=vertcat(' 'TR' num2str(Y) ',' 'TU'  num2str(Y) ');']);
    eval(['clear TR' num2str(Y) ' ' 'TU'  num2str(Y) ';']);
    eval(['T' num2str(Y) '=TT;']);
    %  export(TT,'XLSfile',['T' num2str(Y)]);
    save(num2str(Y), ['T' num2str(Y)]);
    eval(['clear T' num2str(Y)]);
    clear TT;
end
% a=toc;
clc;
disp(['All Done in ']);% num2str(fix(a/60)) ':' num2str(a-60*fix(a/60))]);
clear a Fname Rg Y r;
