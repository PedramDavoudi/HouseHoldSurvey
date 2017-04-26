function [Q]=MDT(Y,X)
% it would mean the data for each city
% Y is the Cities' Code
% X is the data
A=Y(X~=0);
B=X(X~=0);
clear Y X;
Q=dataset(A,B);
clear A B;
Q.Properties.VarNames{1} = 'Sh';
Q.Properties.VarNames{2} = 'C';

 Q=grpstats(Q,'Sh',@mean); % Groupin in each city
 
 Q.GroupCount=[];
 Q.Properties.ObsNames=[];
 Q.Properties.VarNames{1} = 'Shahr';
 Q.Properties.VarNames{2} = 'M';
