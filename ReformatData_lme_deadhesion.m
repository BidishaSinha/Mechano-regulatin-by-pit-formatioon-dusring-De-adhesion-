% This code helps you reorganize data assuming starting point is as pe
% sheets in for lmm analysis by Tithi. work on line 5, line 7 and cooment out  
% line 12 if 3 sets are there ..not 4. when done open variable aoutm. fisr
% row: c-p2 ; 2nd: c-p3; third: p2-p3. first col: pval; 2nd 'estimate'
% (slope) and third SE.

clear; clc; %close(all)a
% cd('/Users/bidishasinha/Downloads/for lmm analysis')
%   cd('/Users/bidishasinha/Downloads/for lmm analysis/excess area dynasore')
 cd(    'H:\tithi\edta')
con= 3; % No. of conditions
ss=2; %No. of sets
% nm='normal fast excess area'  ;  
% nm='normal fast tension';
 nm='tension';
%  nm='atp dep  sdtime';
T1 = readtable([nm ' set 1.csv']);
T2 = readtable([nm ' set 2.csv']);
  %T3 = readtable([nm ' set 3.csv']);
%       T4 = readtable([nm ' set 4.csv']);
%       T5 = readtable([nm ' set 5.csv']);
%       T6 = readtable([nm ' set 6.csv']);
      
%% C P2 P3
s1=[]; sett=[];CN=[];FBRN=[];val=[];
coun=0;
cc=0;
for si=1:ss
   if si==1 set="set1" ; T=T1;
    elseif si==2 set="set2" ; T=T2;
    elseif si==3 set="set3" ;T=T3;
   elseif si==4 set="set4";T=T4;
       elseif si==5 set="set5";T=T5;
           elseif si==6 set="set6";T=T6;
   end
[row, col] = size(T);
 
for i=1:col
    rem=mod(i,3);
    if rem==1 s="Con";
    elseif rem==2 s="P2"; 
    elseif rem==0 s="P3"; 
    end
    choose=(rem==1)+(rem==2)+(rem==0) ; firstcell=1;
    
    if choose==1
        if rem==firstcell coun=coun+1;
        end
        a=table2array(T(:,i));
        [row2, col2] = size(a(~isnan(a)));
        for k= 1:row2
            cc=cc+1;
        s1=[s1;s];sett=[sett;set];CN=[CN;coun];FBRN=[FBRN; cc];val=[val;a(k)];
        end

    end
end
end

data=table(s1,sett,CN,FBRN, val); 
cd('H:\tithi\edta')
%%
data.s1=categorical(data.s1);
data.sett=categorical(data.sett);
data.logval=log(data.val);
data.val=[];
%%
clc
%   lme1 = fitlme(data,'logval ~ s1 + (1|sett)+(1|CN)')
lme2 = fitlme(data,'logval ~ s1 +(s1|sett:CN)')
% lme3 = fitlme(data,'logval ~ s1 +(sett|sett:CN)' )
% %  compare(lme1, lme2)
%  pVal = coefTest(lme2)
%% P2 P3
s1=[]; sett=[];CN=[];FBRN=[];val=[];
coun=0;
cc=0;
for si=1:ss
   if si==1 set="set1" ; T=T1;
    elseif si==2 set="set2" ; T=T2;
    elseif si==3 set="set3" ;T=T3;
      elseif si==4 set="set4";T=T4;
       elseif si==5 set="set5";T=T5;
           elseif si==6 set="set6";T=T6;
   end
[row, col] = size(T);
 
for i=1:col
    rem=mod(i,3);
    if rem==1 s="Con";  
    elseif rem==2 s="P2"; 
    elseif rem==0 s="P3"; 
    end
   
    choose=(rem==2)+(rem==0) ;firstcell=2;
    if choose==1
        if rem==firstcell coun=coun+1;
        end
        a=table2array(T(:,i));
        [row2, col2] = size(a(~isnan(a)));
        for k= 1:row2
            cc=cc+1;
        s1=[s1;s];sett=[sett;set];CN=[CN;coun];FBRN=[FBRN; cc];val=[val;a(k)];
        end

    end
end
end

data=table(s1,sett,CN,FBRN, val); 
cd('H:\tithi\edta')
%%
data.s1=categorical(data.s1);
data.sett=categorical(data.sett);
data.logval=log(data.val);
data.val=[];
%%

%   lme1 = fitlme(data,'logval ~ s1 + (1|sett)+(1|CN)')
lme3 = fitlme(data,'logval ~ s1 +(s1|sett:CN)')
% lme3 = fitlme(data,'logval ~ s1 +(sett|sett:CN)' )
% %  compare(lme1, lme2)
%  pVal = coefTest(lme2)
%%
 aoutm=zeros(3,3);
aoutm(1,1)=lme2.Coefficients(2,6); aoutm(1,2)=lme2.Coefficients(2,2);aoutm(1,3)=lme2.Coefficients(2,3);
aoutm(2,1)=lme2.Coefficients(3,6); aoutm(2,2)=lme2.Coefficients(3,2);aoutm(2,3)=lme2.Coefficients(3,3);
aoutm(3,1)=lme3.Coefficients(2,6); aoutm(3,2)=lme3.Coefficients(2,2);aoutm(3,3)=lme3.Coefficients(2,3);