function [outputmat]=cell2num(inputcell)
% this function is modified from the first usage
% Function Force to convert all numeric cell array to a double precision array
% ********************************************
% Usage: outputmatrix=cell2num(inputcellarray)
% ********************************************
% Output matrix will have the same dimensions as the input cell array
% Non-numeric cell contest will become 0 outputs in outputmat
% This function only works for 1-2 dimensional cell arrays

if ~iscell(inputcell), error('Input cell array is not.'); end

outputmat=zeros(size(inputcell));

for c=1:size(inputcell,2)
    for r=1:size(inputcell,1)
        %if isnumeric(inputcell{r,c})
        try
            outputmat(r,c)=str2num(inputcell{r,c});
        catch  %#ok<CTCH>
            a=inputcell{r,c};% get the unconvertable string
            if isa(a,'char')
                if isempty(a)
                    c1=0;
                else
                    for i=1:length(a)
                        b(i)=unicode2native(a(i));%#ok<*AGROW> %convert to ascii code
                    end
                    b(b<48)=48; %ignore the non numberic letter
                    b(b>57)=48; %ignore the non numberic letter
                    b=b-48; % set to nubmer
                    c1=double(0);
                    for i=1:length(b)
                        c1=c1*10+double(b(i));% sum to one nubmer
                    end
                end
            else
                c1=a;
            end
            %   disp(['Data in row ' num2str(r) ': col ' num2str(c) ' removed by ' num2str(c1)]);
            outputmat(r,c)=c1;
        end
    end
end

end
