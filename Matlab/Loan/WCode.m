function [C] = WCode(Y)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    C(1)=33134;
    C(2)=33338;
if Y>82
    C(3)=126111;
    C(4)=126112;
    C(5)=nan;
elseif Y>65
    C(3)=31230;
    C(4)=84124;
    if Y==65
        C(5)=31241;
    else
       C(5)=0; 
    end
elseif Y==65 || Y==64
    C(3)=31274;
    C(4)=84124;
    C(5)=0;
elseif Y==63
    C(3)=31274;
    C(4)=0;
    C(5)=31285;
end

end

