function [Oo]=RsName(s,M_tp,Y) %Distance of Golden Col from last col

if s==-1 % this column relate to p2 amd metraj
      if Y>86
        Oo=5;
      elseif Y>68
         Oo=4; % this column relate to p2 and house metrage it is not distance from last
      elseif Y==68
            Oo=7;
      elseif Y==65
         Oo=9;
      elseif Y==64
          Oo=9;
      else
          Oo=0;
     end
elseif s==0 % for mahe morajee
      Oo = 0;
else
    if Y==66
        if s==9
            Oo=-1;
        else
            Oo=0;
        end
    else
        if M_tp == 9 
             MO = 8; 
        else
              MO = M_tp - 2;
        end

        if s > MO 
             Oo = -1;
        else
               Oo = 0;
        end
    end
end

% for p2 and metraj

%{
Y	n	title
63	nan	
64	9	Q8
65	10	Q9
66	nan	
67	nan	
68	7	Q6
69	4	Q3
70	4	Q3
%}