function [nm]=init2(i)
if i < 10 
nm = ['0' num2str(i)];
else
nm = num2str(i);
end 
