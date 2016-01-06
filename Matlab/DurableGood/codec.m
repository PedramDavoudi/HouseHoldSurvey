function [CC]=codec(Y,r,Fname)
[M_tp Rg tnam]=init1(Y,r); % initial Value
disp(['Loading Data from ' num2str(Y) ' in ' Rg]);
%CC=dataset({''}); %Data Collector will vanish after the end
%CC.Properties.VarNames{1} = 'Address';
%CC.Properties.VarNames{2} = 'Code';
%CC.Properties.VarNames{3} = 'Cost';

for i=1:M_tp
       nm=init2(i);
       %if i==1   ||  ~strcmp(nm, init2(Tb(i-1))) % Keepp the previuse Data if there are same
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
       %end
    Oo=RsName(i,M_tp,Y); %Return Distance of Golden Col from last col; ocasinally the last col is the cost but sometimes is not

    Ss=Data.Properties.VarNames{size(Data,2)+Oo};% find the Header of the Golden Col
   
    Co=RCodeName(Y,i);% find the col of the codes of Goods
    Cs=Data.Properties.VarNames{Co};% find the Header of the codes
    
    Data.(Ss)=cell2num(Data.(Ss));
    Data.(Cs)=cell2num(Data.(Cs));
    
%end
%%
    Data.Properties.VarNames{1} = 'Address';
    
    C14=dataset(Data.Address, Data.(Cs), Data.(Ss));% retain Just important cols  
    clear Data;
    C14.Properties.VarNames{1} = 'Address';
    C14.Properties.VarNames{2} = 'Code';
    C14.Properties.VarNames{3} = 'Cost';
 % Refinement 
   % C14 = Refine(C14,i,Y);
    %------------------------------------------------------
     if exist('CC','var')==1
             %CC = join(CC,C14,'key','Address','Type','outer','MergeKeys',true); %add to data collector
           CC=[CC;C14];
     else
           CC=C14 ;
    end
    clear C14;
end
     CC = Refine(CC,i,Y);
%%
         disp('Loading Cosst is Done');
       
  %%
 % catch th parameter mahe morajee
CC = join(CC,MRet(CC.Address,Y,Fname,tnam),'key','Address','Type','outer','MergeKeys',true); %add to data collector
            %% 
CC.Region=r*ones(size(CC,1),1);
       
    
disp('Cost Done');


