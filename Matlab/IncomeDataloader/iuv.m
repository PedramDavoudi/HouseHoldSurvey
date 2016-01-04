function [Res]=iuv(X14)
% im not sure about this code
%this will calc integrated unit value
[M_tp ,~  ,~]=init1(X14.Year(1),1);
%add new var
X14.Constant=ones(size(X14,1),1);
X14.x=X14.S01./X14.HH;
X15=X14;
if M_tp==14
    X14.nFv=X14.S02Count+X14.S03Count+X14.S04Count+X14.S05Count+X14.S06Count+X14.S07Count+X14.S08Count+X14.S09Count+X14.S11Count+X14.S12Count+X14.S13Count+X14.S14Count;
    X14.nFc=X14.S02./Frq(X14.Year,X14.Region,2)+X14.S03+X14.S04+X14.S05+X14.S06+X14.S07+X14.S08+X14.S09+X14.S11+X14.S12+X14.S13+X14.S14;
elseif M_tp==10
    X14.nFv=X14.S02Count+X14.S03Count+X14.S04Count+X14.S05Count+X14.S06Count+X14.S07Count+X14.S08Count+X14.S09Count+X14.S10Count;
    X14.nFc=X14.S02./Frq(X14.Year,X14.Region,2)+X14.S03./Frq(X14.Year,X14.Region,3)+X14.S04./Frq(X14.Year,X14.Region,4)+X14.S05./Frq(X14.Year,X14.Region,5)+X14.S06./Frq(X14.Year,X14.Region,6)+X14.S07./Frq(X14.Year,X14.Region,7)+X14.S08./Frq(X14.Year,X14.Region,8)+X14.S09./Frq(X14.Year,X14.Region,9)+X14.S10./Frq(X14.Year,X14.Region,10);
elseif M_tp==9
    X14.nFv=X14.S02Count+X14.S03Count+X14.S04Count+X14.S05Count+X14.S06Count+X14.S07Count+X14.S08Count+X14.S09Count;
    X14.nFc=X14.S02+X14.S03+X14.S04+X14.S05+X14.S06+X14.S07+X14.S08+X14.S09;
else
    X14.nFv=0;
    X14.nFc=0;
end
X14.nFp= X14.nFc./X14.nFv;
X14.Fp= (X14.S01./Frq(X14.Year,X14.Region,1))./X14.S01Count;
%% remove usless var
X14.nFc=[];
X14.nFv=[];
X14.Address=[];
X14.S01Count=[];
X14.S02Count=[];
X14.S03Count=[];
X14.S04Count=[];
X14.S05Count=[];
X14.S06Count=[];
X14.S07Count=[];
X14.S08Count=[];
X14.S09Count=[];

X14.S01=[];
X14.S02=[];
X14.S03=[];
X14.S04=[];
X14.S05=[];
X14.S06=[];
X14.S07=[];
X14.S08=[];
X14.S09=[];

if M_tp==10
    X14.S10Count=[];
    X14.S10=[];
end
if M_tp>10
    X14.S11Count=[];
    X14.S12Count=[];
    X14.S13Count=[];
    X14.S14Count=[];
    X14.S11=[];
    X14.S12=[];
    X14.S13=[];
    X14.S14=[];
end
X14.Total=[];
X14.FoodShare=[];
%X14.Sex=[];
%X14.Age=[];
X14.Education=[];
X14.COL11=[];
X14.COL12=[];
X14.COL13=[];
X14.Region=[];
X14.Year=[];
X14.male=[];
X14.female=[];
X14.B16_64=[];
X14.P0=[];
X14.Province=[];
X14.Dipl=[];
X14.UnderD=[];
X14.Tech=[];
X14.BS=[];
X14.MS=[];
X14.PhD=[];
%{
X14.HH=[];
%X14.F_H=[];
%X14.B16_64=[];
X14.W_H=[];
X14.UnderD=[];
X14.Tech=[];
X14.BS=[];
X14.MS=[];
X14.PhD=[];
%}

X14.P1=[];X14.P2=[];X14.P3=[];X14.P4=[];X14.P5=[];X14.P6=[];X14.P7=[];X14.P8=[];X14.P9=[];X14.P10=[];X14.P11=[];X14.P12=[];X14.P13=[];X14.P14=[];X14.P15=[];X14.P16=[];X14.P17=[];X14.P18=[];X14.P19=[];X14.P20=[];X14.P21=[];X14.P22=[];X14.P23=[];X14.P24=[];X14.P25=[];X14.P26=[];X14.P27=[];X14.P28=[];X14.P29=[];X14.P30=[];
%%


Y=[X14.Fp X14.nFp];
%Y=cell2mat(X(:,end-1:end));
X14.Fp=[];
X14.nFp=[];
%X=cell2mat(X(:,1:end-2));
X=dataset2cell(X14);

%save headers
Tl=X(1,:);
X(1,:)=[];
X=cell2mat(X);
Res(1)=ols(Y(:,1),X);
X(:,end)=(X15.Total-X15.S01)./X15.HH;
Res(2)=ols(Y(:,2),X);
Res(1).Headers=Tl;
Res(2).Headers=Tl;
for i=1:2
    %   c(i)=Res(1,i).beta(strcmp(Res(1,i).Headers, 'Constant'));
    p(:,i)=Res(1,i).beta(strcmp(Res(1,i).Headers, 'Constant'))+Res(1,i).resid;%C+resid
end
clear X14 Res X Y ;
% calculating iuv is ended ************************************************
%%
X15.Fp= log(p(:,1));
X15.nFp= log(p(:,2));
X15.Total=log(X15.Total);
%% remove usless var
X15.Address=[];
X15.S01Count=[];
X15.S02Count=[];
X15.S03Count=[];
X15.S04Count=[];
X15.S05Count=[];
X15.S06Count=[];
X15.S07Count=[];
X15.S08Count=[];
X15.S09Count=[];

X15.S01=[];
X15.S02=[];
X15.S03=[];
X15.S04=[];
X15.S05=[];
X15.S06=[];
X15.S07=[];
X15.S08=[];
X15.S09=[];

if M_tp==10
    X15.S10Count=[];
    X15.S10=[];
end
if M_tp>10
    X15.S11Count=[];
    X15.S12Count=[];
    X15.S13Count=[];
    X15.S14Count=[];
    X15.S11=[];
    X15.S12=[];
    X15.S13=[];
    X15.S14=[];
end
%X15.Total=[];
%X15.FoodShare=[];
%X14.Sex=[];
%X14.Age=[];
X15.Education=[];
X15.COL11=[];
X15.COL12=[];
X15.COL13=[];
X15.Region=[];
X15.Year=[];
X15.male=[];
X15.female=[];
X15.B16_64=[];
X15.P0=[];
X15.Province=[];
X15.Dipl=[];
X15.UnderD=[];
X15.Tech=[];
X15.BS=[];
X15.MS=[];
X15.PhD=[];
%{
X14.HH=[];
%X14.F_H=[];
%X14.B16_64=[];
X14.W_H=[];
X14.UnderD=[];
X14.Tech=[];
X14.BS=[];
X14.MS=[];
X14.PhD=[];
%}

%X15.P1=[];X15.P2=[];X15.P3=[];X15.P4=[];X15.P5=[];X15.P6=[];X15.P7=[];X15.P8=[];X15.P9=[];X15.P10=[];X15.P11=[];X15.P12=[];X15.P13=[];X15.P14=[];X15.P15=[];X15.P16=[];X15.P17=[];X15.P18=[];X15.P19=[];X15.P20=[];X15.P21=[];X15.P22=[];X15.P23=[];X15.P24=[];X15.P25=[];X15.P26=[];X15.P27=[];X15.P28=[];X15.P29=[];X15.P30=[];
% remove no existance province
for i=1:30
    if isempty(find(X15.(['P' num2str(i)]), 1));
        X15.(['P' num2str(i)])=[];
    end
end
%%
Y=X15.FoodShare;
X15.FoodShare=[];
%--------------------
%X15.Fp=[];
%--------------
X=dataset2cell(X15);
%save headers
Tl=X(1,:);
X(1,:)=[];
X=cell2mat(X);
Res=ols(Y,X);
Res.Header=Tl;
end