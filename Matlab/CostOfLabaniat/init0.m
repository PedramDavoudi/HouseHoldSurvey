function [Rg  Fname]=init0(Y,r)
% this function return the address of file
% do not hesitate to chnage the addreess
% some a few changes is needed if you have diffrent data sources
%Adres = 'E:\Data\HouseHoldExpenditure\Access\';

Adres ='D:\1.Reports\00. DataBase\HouseHoldExpenditure\Access\';
if r==0
    Rg='R';
else
    Rg='U';
end
%%

if Y == 89 || Y==90
    Fname = [num2str(Y) '.accdb'];% '"89\89.accdb"
else%if Y > 82
    Fname = [num2str(Y) '.mdb'];
    %else
    %   Fname = [num2str(Y) '\DATA' num2str(Y) ]; %'.dbf'
end
Fname=[Adres Fname];
%%
%{
[FileName,PathName,~] = uigetfile('*.*');% get file location
Fname=[PathName FileName];
%}
