function [CC]=codec(Y,r,Fname)
[M_tp Rg tnam]=init1(Y,r); % initial Value
disp(['Loading Data from ' num2str(Y) ' in ' Rg]);
%CC=dataset({''}); %Data Collector will vanish after the end
%CC.Properties.VarNames{1} = 'Address';
%CC.Properties.VarNames{2} = 'Code';
%CC.Properties.VarNames{3} = 'Cost';
%%
NumberofTable=3;%2
%IsA(1:3)=1;
Tb=WT(Y);
for i=1:NumberofTable
       nm=init2(Tb(i));
       if i==1   ||  ~strcmp(nm, init2(Tb(i-1))) % Keepp the previuse Data if there are same
          try
           %  if Y>82
                  [~, ~, Data] = readacc( Fname,[tnam  nm]);  % Read Access File        
           %  else
         %         [~, ~, Data] = readacc( [Fname '\' tnam  nm]);  % Read diff File   
           %  end
          catch  %#ok<CTCH>
             %IsA(i)=0;
             % Crear Empty dataset with tree column
             disp(['Table "' tnam nm '" is not availabe. Replaced by NaN']);
             Data=dataset({''},{'0'},{'0'},{'0'});
             %continue; % in some year Col 10 doesn't exit this remove the errors
         end
             disp(['Load '  tnam  nm ' Done' ]); 
    %{ 
    convert to num
    %}
       end
    Oo=RsName(Tb(i),M_tp,Y); %Return Distance of Golden Col from last col; ocasinally the last col is the cost but sometimes is not

    Ss=Data.Properties.VarNames{size(Data,2)+Oo};% find the Header of the Golden Col
   
    Co=RCodeName(Y,Tb(i));% find the col of the codes of Goods
    Cs=Data.Properties.VarNames{Co};% find the Header of the codes
    
    Data.(Ss)=cell2num(Data.(Ss));
    Data.(Cs)=cell2num(Data.(Cs));
    
%end
%%
    Data.Properties.VarNames{1} = 'Address';

        C14=dataset(Data.Address, Data.(Cs), Data.(Ss));% retain Just important cols  
    %clear Data;
    C14.Properties.VarNames{1} = 'Address';
    C14.Properties.VarNames{2} = 'Code';
    C14.Properties.VarNames{3} = 'Cost';
 % Refinement 
    C14 = Refine(C14,i,Y);
    %------------------------------------------------------
     if exist('CC','var')==1
             CC = join(CC,C14,'key','Address','Type','outer','MergeKeys',true); %add to data collector
     else
           CC=C14 ;
    end
    clear C14;
end
%%
         
        % catch the house sizze
        clear er;
        try
             if Y>82
                  [~, ~, Data] = readacc( Fname,[tnam(1:4) '2']);  % Read Access File        
             else
                  [~, ~, Data] = readacc( [Fname '\' tnam(1:4) '2']);  % Read dff File   
             end
             
            disp('Load P2 Done' ); 
            %{ 
            convert to num
            %}
            Oo=RsName(-1,M_tp,Y); %Return the Golden Col 
            Ss=Data.Properties.VarNames{Oo};% find the Header of the Golden Col
            Data.(Ss)=cell2num(Data.(Ss));%Data.(Ss)=str2num(char(Data.(Ss))); %#ok<*ST2NM>Data.(Ss)=str2num(cell2mat2(Data.(Ss))); %#ok<*ST2NM>
            Data.Properties.VarNames{1} = 'Address';
            C14=dataset(Data.Address, Data.(Ss));% retain Just important cols 
            C14.Properties.VarNames{1} = 'Address';
            C14.Properties.VarNames{2} = 'Hmeter';
            CC = join(CC,C14,'key','Address','Type','outer','MergeKeys',true); %add to data collector
            clear C14;
        catch  %#ok<CTCH>
             disp ('House metraj is not available. Replaced by 100');
             CC.Hmeter=100*ones(size(CC.Address,1),1);
        end
  %%
 % catch th parameter mahe morajee
        try
            [~, ~, Data] = readacc( Fname,tnam(1:3));  % Read Access File        
       catch %#ok<CTCH>
               Data=MRet(CC.Address,Y);
        end
        disp('Load MaheMoraje Done' ); 
            Oo=RsName(0,M_tp); %Return Distance of Golden Col from last col; ocasinally the last col is the cost but sometimes is not
            Ss=Data.Properties.VarNames{size(Data,2)+Oo};% find the Header of the Golden Col
            Data.(Ss)=cell2num(Data.(Ss));%Data.(Ss)=str2num(char(Data.(Ss))); %#ok<*ST2NM>Data.(Ss)=str2num(cell2mat2(Data.(Ss))); %#ok<*ST2NM>
            Data.Properties.VarNames{1} = 'Address';
            Data.Properties.VarNames{2} = 'MahMorajeh';
            if Y>86  %convert month to season
                Data.MahMorajeh= ceil(Data.MahMorajeh/3);
            end
            CC = join(CC,Data,'key','Address','Type','outer','MergeKeys',true); %add to data collector
            %% 
       
 
       % if ~exist('er','var')
                   % Remove zero or Nan metraj
                 CC(CC.Hmeter==0,:)=[];
                 CC(isnan(CC.Hmeter),:)=[];
        %----------------

               % if IsA(1)==1
                CC.TRent(isnan(CC.TRent))=0;   % Remove NAN
                CC.Rent=CC.TRent ./ CC.Hmeter;
               % end
                %if IsA(2)==1
                 CC.TPrice(isnan(CC.TPrice))=0;  % Remove NAN   
                CC.Price=CC.TPrice ./ CC.Hmeter;
                %end
               % if IsA(3)==1
                CC.TEnshurance(isnan(CC.TEnshurance))=0; % Remove NAN    
                CC.Enshurance=CC.TEnshurance ./ CC.Hmeter;
                %end
      %  end
      if Y>76 % for the year befor 1376 i'm not sure about the structure of address code
       CC.Shahr=cellfun(@(x)x(2:5),CC.Address, 'UniformOutput' , false);
      else
         CC.Shahr=cellfun(@(x)x(2:3),CC.Address, 'UniformOutput' , false);  
      end
       
    
disp('Cost Done');


