

clc
clear
close all
cd('G:\.shortcut-targets-by-id\18Cv0jirYMSpErnSEdSX7ifVfVIW21zMZ\Tithi_BSDrive\DeadhesioPaper\Prep230503\');
nm='spread area change_formatted';
data=table;
Th1=0.90;Th2=0.67;Th3=0.33;namep1=[num2str(Th1*100) num2str(Th2*100) num2str(Th3*100)]
freename=['all' namep1];
% a='ATP Dep';
%  a='ATP+chol Dep';
 a1="normal fast"; a2="dyna treated"; a3="cyto D fast";a4="ATP dep"; 
 a5="normal slow"; a6="cyto d"; a7="normal slow"; a8="cyto d";
  xP1all=[];xP2all=[];xP3all=[];J=[];
  %%
for j=1:8
    xP1=[];xP2=[];xP3=[];
    if j==1; a=a1;
    elseif j==2 ;a=a2;
    elseif j==3 ;a=a3;  
        elseif j==4 ;a=a4;   
            elseif j==5 ;a=a5;   
                elseif j==6 ;a=a6;
                     elseif j==7 ;a=a7;
                          elseif j==8 ;a=a8
                  
    end
T = readtable([nm '.xlsx'], 'Sheet',a );
%%
[row, col]=size(T);
for i =1: col/2
    figure(1)
    AX=table2array(T(:,2*i-1));ax=AX(~isnan(AX));
    AY=table2array(T(:,2*i));ay=AY(~isnan(AY));
    xq=min(ax):0.1:max(ax);
    yq=makima(ax,ay,xq);
    plot(ax, ay, 'o',xq,yq,'--')
%      pause (0.5)
    x=yq;target=Th1;temp= abs(target - x);
    closest = x(find(temp == min(abs(target - x)), 1, 'first'));
    xP1(i,1)=xq(yq==closest);xP1all=[xP1all;xP1(i,1)];
    J=[J;a];
    
    x=yq;target=Th2;temp= abs(target - x);
    closest = x(find(temp == min(abs(target - x)), 1, 'first'));
    xP2(i,1)=xq(yq==closest);xP2all=[xP2all;xP2(i,1)];
    
    x=yq;target=Th3;temp= abs(target - x);
    closest = x(find(temp == min(abs(target - x)), 1, 'first'));
    xP3(i,1)=xq(yq==closest);xP3all=[xP3all;xP3(i,1)];

    

end

data=table(J,xP1all,xP2all,xP3all); 
    end
cd('G:\.shortcut-targets-by-id\18Cv0jirYMSpErnSEdSX7ifVfVIW21zMZ\Tithi_BSDrive\DeadhesioPaper\Prep230503');
%%
glmeP1 = fitglme(data,'xP1all ~ 1+J +(1|J)' )
mufit = fitted(glmeP1);
figure
scatter(data.xP1all,mufit)
title('Observed Values versus Fitted Values')
xlabel('Fitted Values')
ylabel('Observed Values')
glmeP2 = fitglme(data,'xP2all ~ 1+J +(1|J)' )
mufit = fitted(glmeP2);
figure
scatter(data.xP1all,mufit)
title('Observed Values versus Fitted Values')
xlabel('Fitted Values')
ylabel('Observed Values')
glmeP3 = fitglme(data,'xP3all ~ 1+J +(1|J)' )
mufit = fitted(glmeP3);
figure
scatter(data.xP3all,mufit)
title('Observed Values versus Fitted Values')
xlabel('Fitted Values')
ylabel('Observed Values')


save([freename '.mat'])
writetable(data,[freename '.csv'])
%%
% p=zeros(3,3);
p=[];CDyna=[];CCytoD=[];CATPdep=[];Ccholdep=[];Catpcholdep=[];atp_choldep=[];atp_atpcholdep=[];
[p(1,1),h11]=ranksum(data.xP1all(J==a1),data.xP1all(J==a2));CDyna=[CDyna;p(1,1)];
[p(1,2),h12]=ranksum(data.xP1all(J==a1),data.xP1all(J==a3));CCytoD=[CCytoD;p(1,2)];
[p(1,3),h12]=ranksum(data.xP1all(J==a1),data.xP1all(J==a4));CATPdep=[CATPdep;p(1,3)];
[p(1,4),h12]=ranksum(data.xP1all(J==a1),data.xP1all(J==a5));Ccholdep=[Ccholdep;p(1,4)];
[p(2,5),h12]=ranksum(data.xP2all(J==a1),data.xP2all(J==a6));Catpcholdep=[Catpcholdep;p(1,5)];
[p(1,6),h12]=ranksum(data.xP1all(J==a4),data.xP1all(J==a5));atp_choldep=[atp_choldep;p(1,6)];
[p(1,7),h12]=ranksum(data.xP1all(J==a4),data.xP1all(J==a6));atp_atpcholdep=[atp_atpcholdep;p(1,7)];

[p(2,1),h21]=ranksum(data.xP2all(J==a1),data.xP2all(J==a2));CDyna=[CDyna;p(2,1)];
[p(2,2),h22]=ranksum(data.xP2all(J==a1),data.xP2all(J==a3));CCytoD=[CCytoD;p(2,2)];
[p(2,3),h12]=ranksum(data.xP2all(J==a1),data.xP2all(J==a4));CATPdep=[CATPdep;p(2,3)];
[p(2,4),h12]=ranksum(data.xP2all(J==a1),data.xP2all(J==a5));Ccholdep=[Ccholdep;p(2,4)];
[p(2,5),h12]=ranksum(data.xP2all(J==a1),data.xP2all(J==a6));Catpcholdep=[Catpcholdep;p(2,5)];
[p(2,6),h12]=ranksum(data.xP2all(J==a4),data.xP2all(J==a5));atp_choldep=[atp_choldep;p(2,6)];
[p(2,7),h12]=ranksum(data.xP2all(J==a4),data.xP2all(J==a6));atp_atpcholdep=[atp_atpcholdep;p(2,7)];

[p(3,1),h31]=ranksum(data.xP3all(J==a1),data.xP3all(J==a2));CDyna=[CDyna;p(3,1)];
[p(3,2),h32]=ranksum(data.xP3all(J==a1),data.xP3all(J==a3));CCytoD=[CCytoD;p(3,2)];
[p(3,3),h12]=ranksum(data.xP3all(J==a1),data.xP3all(J==a4));CATPdep=[CATPdep;p(3,3)];
[p(3,4),h12]=ranksum(data.xP3all(J==a1),data.xP3all(J==a5));Ccholdep=[Ccholdep;p(3,4)];
[p(3,5),h12]=ranksum(data.xP3all(J==a1),data.xP3all(J==a6));Catpcholdep=[Catpcholdep;p(3,5)];
[p(3,6),h12]=ranksum(data.xP3all(J==a4),data.xP3all(J==a5));atp_choldep=[atp_choldep;p(3,6)];
[p(3,7),h12]=ranksum(data.xP3all(J==a4),data.xP3all(J==a6));atp_atpcholdep=[atp_atpcholdep;p(3,7)];

comp=table(CDyna, CCytoD, CATPdep, Ccholdep, Catpcholdep,atp_choldep,atp_atpcholdep);
% writetable(comp,[ 'comp' freename '.csv'])

