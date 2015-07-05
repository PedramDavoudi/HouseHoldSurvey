function [M_tp, Rg,  tnam]=init1(Y,r)
% M_tp is the number of tables
% Rg is the region
% tnam is the begining part of table name
if Y > 82
    M_tp = 14;
elseif or(and(Y < 78,Y > 74),  Y < 66 )
    M_tp = 9;
else
    M_tp = 10;
end
if nargin>1
    if r==0
        Rg='R';
    else
        Rg='U';
    end
    tnam = [Rg num2str(Y) 'P3S'];
else
    Rg='';
    tnam = '';
end

%incom Not Available now
%{
    Tp = '4';
    if Y > 68
    M_tp = 3;
    else
    M_tp = 5;
    end
%}
