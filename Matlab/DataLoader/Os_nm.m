function [ Ost , Reg] = Os_nm( n )
%OS_NM Summary of this function goes here
%   Detailed explanation goes here
if nargin ==0 
    error ('inpput argument is needed');
end
      Reg(numel(n),1)={''};
pt={'markazi';'Gilan';'maz';'az_sh';'az_gh';'kermanshah';'khoz';'fars';'kerman';'khorasan (razavi)';'esf';'sis';'kord';'ham';'char';'lor';'iel';'koh';'bosh';'zan';'sem';'yazd';'hor';'teh';'ard';'ghom';'ghaz';'gol';'khor_sh';'khor_jon';'alb'};

if isa(n,'numeric')
        Ost=pt(n+1,:);
else
            Ost(numel(n),1)={''};
       for i=1:numel(n)
           el=n{i};
            if strcmp(el(1),'P')  || strcmp(el(1),'p')
               el(1)=[];
                if strcmp(el(1),'U')  || strcmp(el(1),'u') 
                   Reg{i}='Urban';
                    el(1)=[];
                end
                 if strcmp(el(1),'R')  || strcmp(el(1),'r')
                    Reg{i}='Rural';
                    el(1)=[];
                end  
                Ost(i)=pt(str2double(el)+1,:);
            else
                warn([' i can not recognize ' el]);
            end

       end
end
end

