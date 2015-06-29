function [Oo]=RsName(s,M_tp) %Distance of Golden Col from last col
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