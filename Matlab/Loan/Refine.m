function [Q] = Refine(X,nm,Y)
% eliminate Unneccery codes from rows
R=WCode(Y);
R=R(nm);

        Q=X(X.Code==R,:);        %Remove Use less Rows and kepp just rent
end

