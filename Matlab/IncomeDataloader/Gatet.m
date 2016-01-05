% this is gather the title of files
clear
Data={''};
for i=69:93
load(['out\T' num2str(i) '.mat'])
eval(['T=T' num2str(i) '; clear T' num2str(i)]);
Data=[Data;T.Properties.VarNames.'];
end
clear T i