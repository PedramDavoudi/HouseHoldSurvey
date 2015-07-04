function [ Tb ] = WT( Y )
%WT Tells You wich Table in each yrae contian the rent and price data
%   Detailed explanation goes here
if Y>82
    Tb(1)=14;
    Tb(2)=14;
    Tb(3)=13;
    Tb(4)=13;
    Tb(5)=0;
elseif Y>66 && Y~=77  && Y~=75 && Y~=76
    Tb(1)=10;
    Tb(2)=10;
    Tb(3)=9;
    Tb(4)=9;
    Tb(5)=0;
elseif Y<=77 && Y>=75
    Tb(1)=0;
    Tb(2)=0;
    Tb(3)=9;
    Tb(4)=9;
    Tb(5)=0;
elseif Y==66
    Tb(1)=10;
    Tb(2)=10;
    Tb(3)=9;
    Tb(4)=9;
    Tb(5)=9;
elseif Y==65 || Y==64
    Tb(1)=0;
    Tb(2)=0;
    Tb(3)=9;
    Tb(4)=9;
    Tb(5)=0;
elseif Y==63
    Tb(1)=0;
    Tb(2)=0;
    Tb(3)=9;
    Tb(4)=0;
    Tb(5)=9;
end
end

