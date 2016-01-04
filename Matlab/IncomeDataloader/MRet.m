function [Result]=MRet(X,Y)
% this would extract the Season of moraje
% to do; 
%   X=Housholds address
%   Y=year
%   Result is a data set
% for example after exracting data from houshold micro data of 1380, save it to
% a dataset variable like M, then use the command 
% A=MRet(M.Address,80)
% A.Address is equl to X
% A.MahMorajeh is the season when houshold  fullfill the quastinaries
if ~isa(X,'cell')
   error('I Feed by cell'); 
end
% Appoint which character shows the season
if Y>76
   Ctr=6 ;
elseif Y>62
    Ctr=4;

    
end
Result=cellfun(@(x)x(Ctr),X, 'UniformOutput' , false);
Result=dataset(X,Result);
Result.Properties.VarNames{1} = 'Address';
Result.Properties.VarNames{2} = 'MahMorajeh';

end