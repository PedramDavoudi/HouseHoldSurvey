function [n]=nPr(Y)
% return the number of provinces
if Y<=72
    n=24;
elseif Y<=74
    n=25;
 elseif Y==75
    n=26;
 elseif Y<=82
    n=28;
 elseif Y<=90
    n=30;
else
    n=31;
end
end
