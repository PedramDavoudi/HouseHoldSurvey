function [CC]=codec(Y,r,Fname)
% Return Cost element. for the year Y in r area,
% r=0 is rural
% r=1 is urban
[M_tp Rg tnam]=init1(Y,r); % initial Value
disp(['Loading Data from ' num2str(Y) ' in ' Rg]);
CC=dataset({''}); %Data Collector will vanish after the end
CC.Properties.VarNames{1} = 'Address';
%%
for i=1:M_tp
    nm=init2(i);
    try
        
        [~, ~, Data] = readacc( Fname,[tnam  nm]);  % Read Access File
        
    catch %#ok<CTCH>
        continue; % in some year Col 10 doesn't exit this remove the errors
    end
    disp(['Load '  tnam  nm ' Done' ]);
    %{
    convert to num
    %}
    Oo=RsName(i,M_tp); %Return Distance of Golden Col from last col; ocasinally the last col is the cost but sometimes is not
    Ss=Data.Properties.VarNames{end+Oo};% find the Header of the Golden Col
    % there were many error in original Data come from human mistakes which
    % entered the Unknown charachter among the Data two line below remove such
    % data by 0 but may cuase reduce speed
    %    Data.(Ss)(strcmp(strtrim((Data.(Ss))),{''}))={'0000000000'};
    %if Y>82 % for DBf file would be converted in dbfreader
    Data.(Ss)=cell2num(Data.(Ss));%Data.(Ss)=str2num(char(Data.(Ss))); %#ok<*ST2NM>Data.(Ss)=str2num(cell2mat2(Data.(Ss))); %#ok<*ST2NM>
    %end
    %%
    if i==1
        if Y~=69 && Y<72
            Oo=Oo-1;% it may be wrong
        else
            Oo=Oo-2;
        end
        S1=Data.Properties.VarNames{end+Oo};% kilo
        Data.(S1)=cell2num(Data.(S1));
        if Y<83
            Data.Wgh=Data.(S1);
        else
            S2=Data.Properties.VarNames{end+Oo-1};%geram
            Data.(S2)=cell2num(Data.(S2));
            Data.Wgh=Data.(S1)+Data.(S2)./1000;
        end
    end
    %%
    Data.Properties.VarNames{1} = 'Address';
    if i==1
        C14=dataset(Data.Address,Data.Wgh, Data.(Ss));% retain Just important cols
    else
        C14=dataset(Data.Address, Data.(Ss));% retain Just important cols
    end
    clear Data;
    C14.Properties.VarNames{1} = 'Address';
    
    C14=grpstats(C14,'Address',@sum); % sum costs for every house hold
    if i==1
        C14.GroupCount=[];%remove useless col
    end
    C14.Properties.VarNames{2} = ['S' nm 'Count'];
    C14.Properties.VarNames{3} = ['S' nm];
    % ply to Frq
    C14.(['S' nm])=C14.(['S' nm])*Frq(Y,r,i);
    C14.( ['S' nm 'Count'])=C14.( ['S' nm 'Count'])*Frq(Y,r,i);
    %------------------------------------------------------
    CC = join(CC,C14,'key','Address','Type','outer','MergeKeys',true); %add to data collector
    clear C14;
    if i==1 % delete the '' from the first row
        CC(1,:)=[];
    end
end
for i=2:M_tp
    nm=init2(i);
    try %#ok<TRYNC>
        CC.(['S' nm])(isnan(CC.(['S' nm])))=0;% Remove Nan
        CC.(['S' nm 'Count'])(isnan(CC.(['S' nm 'Count'])))=0;% Remove Nan
    end
end

if M_tp==14 % Calc Total Cost
    %CC.Total=CC.S01*Frq(Y,r,1)+CC.S02*Frq(Y,r,2)+CC.S03*Frq(Y,r,3)+CC.S04*Frq(Y,r,4)+CC.S05*Frq(Y,r,5)+CC.S06*Frq(Y,r,6)+CC.S07*Frq(Y,r,7)+CC.S08*Frq(Y,r,8)+CC.S09*Frq(Y,r,9)+CC.S11*Frq(Y,r,11)+CC.S12*Frq(Y,r,12)+CC.S13*Frq(Y,r,13)+CC.S14*Frq(Y,r,14);
    CC.Total=CC.S01+CC.S02+CC.S03+CC.S04+CC.S05+CC.S06+CC.S07+CC.S08+CC.S09+CC.S11+CC.S12+CC.S13+CC.S14;
elseif M_tp==10
    %CC.Total=CC.S01*Frq(Y,r,1)+CC.S02*Frq(Y,r,2)+CC.S03*Frq(Y,r,3)+CC.S04*Frq(Y,r,4)+CC.S05*Frq(Y,r,5)+CC.S06*Frq(Y,r,6)+CC.S07*Frq(Y,r,7)+CC.S08*Frq(Y,r,8)+CC.S09*Frq(Y,r,9)+CC.S10*Frq(Y,r,10);
    CC.Total=CC.S01+CC.S02+CC.S03+CC.S04+CC.S05+CC.S06+CC.S07+CC.S08+CC.S09+CC.S10;
elseif M_tp==9
    % CC.Total=CC.S01*Frq(Y,r,1)+CC.S02*Frq(Y,r,2)+CC.S03*Frq(Y,r,3)+CC.S04*Frq(Y,r,4)+CC.S05*Frq(Y,r,5)+CC.S06*Frq(Y,r,6)+CC.S07*Frq(Y,r,7)+CC.S08*Frq(Y,r,8)+CC.S09*Frq(Y,r,9);
    CC.Total=CC.S01+CC.S02+CC.S03+CC.S04+CC.S05+CC.S06+CC.S07+CC.S08+CC.S09;
else
    disp('I''m not ready to calc Total Cost');
end
CC.FoodShare=CC.S01./CC.Total;
disp('Cost Done');
