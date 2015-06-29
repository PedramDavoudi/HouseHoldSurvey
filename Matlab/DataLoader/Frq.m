function [f]=Frq(Y,r,s)
switch s
    case 14
        f=1;
    case 13
        f=1;
    case 12
        f=12;
    case 11
        f=12;
    case 10
        if Y>82
            f=12;
        else
            f=1;
        end
    case 9
        if Y>82
            f=12;
        else
            f=1;
        end
    case 8
        f=12;
    case 7
        f=12;
    case 6
        f=12;
    case 5
        f=12;
    case 4
        f=12;
    case 3
        f=12;
    case 2
        f=12;
    case 1
        if Y>68
            f=12;
        elseif Y>62 
            if r==0
                f=365;
            else
                f=365/2;
            end
        end
    otherwise
        f=0;  
end
