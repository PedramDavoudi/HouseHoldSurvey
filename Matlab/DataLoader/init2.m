function [nm]=init2(i)
% standadize number in 2 letters string
if i < 10
    nm = ['0' num2str(i)];
else
    nm = num2str(i);
end
