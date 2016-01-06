function [CC]=codec(Y,r,Fname)
[M_tp, Rg, tnam]=init1(Y,r); % initial Value
disp(['Loading Data from ' num2str(Y) ' in ' Rg]);

%%
NumberofTable=3;%2
%IsA(1:3)=1;
Tb=WT(Y);
for i=3:2+NumberofTable
    if Tb(i)==0;
        continue;
    end
       nm=init2(Tb(i));
       if (i==1 || ~strcmp(nm, init2(Tb(i-1))))% Keepp the previuse Data if there are same
          try
                      [~, ~, Data] = readacc( Fname,[tnam  nm]);  % Read Access File        
       catch  %#ok<CTCH>
             disp(['Table "' tnam nm '" is not availabe. Replaced by NaN']);
             %Data=dataset({''},{'0'},{'0'},{'0'});
             %continue; % in some year Col 10 doesn't exit this remove the errors
         end
             disp(['Load '  tnam  nm ' Done' ]); 
    %{ 
    convert to num
    %}
     %  end
    %Oo=RsName(Tb(i),M_tp,Y); %Return Distance of Golden Col from last col; ocasinally the last col is the cost but sometimes is not

   % Ss=Data.Properties.VarNames{size(Data,2)+Oo};% find the Header of the Golden Col
   
    %Co=RCodeName(Y,Tb(i));% find the col of the codes of Goods
    %Cs=Data.Properties.VarNames{Co};% find the Header of the codes
    
     if Y>87 %remove the banks name
           Data.(4)=[];
     end
   for j=2:size(Data,2)

     % Ss=Data.Properties.VarNames{j};
        Data.(j)=cell2num(Data.(j));
   end
       Data.Properties.VarNames{1} = 'Address';
    Data.Properties.VarNames{2} = 'Code';
end
%%
   % Data.Properties.VarNames{1} = 'Address';

       % C14=Data;%dataset(Data.Address, Data.(Cs), Data.(Ss));% retain Just important cols  
    %clear Data;

   % C14.Properties.VarNames{3} = 'Cost';
 % Refinement 
    C14 = Refine(Data,i,Y);
    
    %------------------------------------------------------
     if exist('CC','var')==1
             CC =[CC;C14]; %%join(CC,C14,'key','Address','Type','outer','MergeKeys',true); %add to data collector
     else
           CC=C14 ;
    end
    clear C14;
end
%%
         
     clear Data; 
     
  %%
 % catch th parameter mahe morajee
   if exist('CC','var')==1
       
       %% create extra column to have same column all year
%        for i=size(CC,2)+1:5
%          CC.(['C' num2str(i)])=CC.(i-1);
%          CC.(i-1)=nan(size(CC,1),1);
%        end
       if size(CC,2)>5
            CC.(4)=[];
       end
    
            %% 
   else
       
        CC=0; 
   end     
     
     %% MaheMoraje
              CC = join(CC,MRet(CC.Address,Y,Fname,tnam),'key','Address','Type','outer','MergeKeys',true); %add to data collector
disp('Cost Done');


