function [Q] = Refine(X,nm,Y)
% eliminate Unneccery codes from rows
if nm==1% Rent
        if Y>82
            R=[41111; ... % Rent for own house
                42111]; % Actually Rented
         else
            R=[31117; ... % Rent for own house
               31139]; % Actually Rented 
        end
        Q=[];
    for i=1:numel(R)
        Q=vertcat(X(X.Code==R(i),:),Q);        %Remove Use less Rows and kepp just rent
    end
    clear X;
    Q.Code=[];
    Q=unique(Q);
  %  Q=grpstats(Q,'Address',@max); % remove the duplication
   % Q.GroupCount=[];
   % Q.Properties.ObsNames=[];
     Q.Properties.VarNames{1} = 'Address';
    Q.Properties.VarNames{2} = 'TRent';
elseif nm==2 % Buy house
    Q=X;
    Q(Q.Code~=33134 , : )=[];
    Q.Code=[];
    Q.Properties.VarNames{1} = 'Address';
    Q.Properties.VarNames{2} = 'TPrice';
 elseif nm==3 % ensurance
     if Y>82  
        E=125211;
     elseif Y>65
         E=31220;
     else
         E=31263;
     end
     Q=X;
     clear X;
    Q(Q.Code~=E , : )=[];
    Q.Code=[];
    Q.Properties.VarNames{1} = 'Address';
    Q.Properties.VarNames{2} = 'TEnshurance';
     
 end
end

