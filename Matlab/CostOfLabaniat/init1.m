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
   