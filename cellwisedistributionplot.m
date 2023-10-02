
loadclear; clc; %close(all)a
cd('/Users/bidishasinha/Downloads/for lmm analysis')
con= 3; % No. of conditions
sub='n';%y if you want mean-Control subtracted distributions
ss=4; %No. of sets
% nm='atp+chol dep sdtime '  ;  bw=0.05;ed=[-0.35:0.01: 0.35];
  nm='cyto d tension';bw=0.25;bine=[0:0.15:3];ed=[-1:0.1: 5];
% nm='normal slow sdspace'  ;  bw=0.05;

T1 = readtable([nm ' set 1.csv']);
T2 = readtable([nm ' set 2.csv']);
 T3 = readtable([nm ' set 3.csv']);
 if ss>3
      T4 = readtable([nm ' set 4.csv']);
 end
  if ss>4
      T5 = readtable([nm ' set 5.csv']);
 end
   if ss>5
      T6 = readtable([nm ' set 6.csv']);
 end
%% C P2 P3
s1=[]; sett=[];CN=[];FBRN=[];val=[];
coun=0;
cc=0;pc=0;
for si=1:ss
   if si==1 settt="set1" ; T=T1;
    elseif si==2 settt="set2" ; T=T2;
    elseif si==3 settt="set3" ;T=T3;
        elseif si==4 settt="set4" ;T=T4;
            elseif si==5 settt="set5" ;T=T5;
   else settt="set6";T=T6;
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
        s1=[s1;s];sett=[sett;settt];CN=[CN;coun];FBRN=[FBRN; cc];val=[val;a(k)];
        end

    end
end
end

data=table(s1,sett,CN,FBRN, val); 
cd('/Users/bidishasinha/Downloads')
%%
data.s1=categorical(data.s1);
data.sett=categorical(data.sett);
data.logval=log10(data.val);
data.val=[];
%%
close all
norm='pdf';%"probability";%'count' ;% 'probability', 'cdf', pdf'
pa=0;pb=0;
for sn=1:ss 
%     close all

idx2=data.sett==['set' num2str(sn)];
idx = data.s1 == "Con"& idx2;
cdata=data(idx,:);
ncells=max(cdata.CN)-min(cdata.CN)+1;
for cn=min(cdata.CN):max(cdata.CN)
    idx3=cdata.CN==cn
    ccdata=cdata(idx3,:);
ea=ccdata.logval;mea=log(mean(exp(ea)));
if sub=='y'
ea=ea-mea;ed=[-3:0.1: 3];
end
figure(1)

% h=histogram(ea, "BinWidth" ,bw);

h=histogram(ea);
h.Normalization=norm;h.BinWidth = bw;
% h=histogram(ea, "BinEdges" ,bine);
Bins=(h.BinEdges(1:end-1)+h.BinEdges(2:end)/2);
pa=pa+1;

% Bins=((bine(1:end-1)+bine(2:end))/2);
[ftem,xtem]=ksdensity(ea,ed);
ffa(pa,:)=ftem/sum(sum(ftem));
xii(pa,:)=xtem;

if norm == "count"
    toplot=h.Values./length(ea);
else
toplot=h.Values;
toplot=ffa(pa,:);Bins=ed;
end
  
figure(2)
% plot(Bins,h.Values./length(ea),'k-o', 'LineWidth', 1); hold on
lh=plot(Bins,toplot,'k', 'LineWidth', 2);
 lh.Color = [lh.Color 0.2];hold on


end


idx = data.s1 == "P2" & idx2;
p1data=data(idx,:);
for cn=min(p1data.CN):max(p1data.CN)
  
idx3=p1data.CN==cn
cp1data=p1data(idx3,:);
eb=cp1data.logval;
if sub=='y'
    eb=cp1data.logval-mea;ed=[-3:0.1: 3];
end
hold on;
figure(1)
% h=histogram(eb, "BinWidth" ,bw);
h2=histogram(eb)
h2.Normalization=norm;h2.BinWidth = bw;
% h=histogram(eb, "BinEdges" ,bine);
Bins=((h2.BinEdges(1:end-1)+h2.BinEdges(2:end))/2);
pb=pb+1;
% Bins=((bine(1:end-1)+bine(2:end))/2);
[ftem,xtem]=ksdensity(eb,ed);
ffb(pb,:)=ftem/sum(sum(ftem));
xii(pb,:)=xtem;

if norm == "count"
    toplot=h2.Values./length(eb);
else
toplot=h2.Values;
toplot=ffb(pb,:);Bins=ed;
end
figure(2)
% plot(Bins,h.Values./length(eb),'b-*', 'LineWidth', 1)
lh=plot(Bins,toplot,'r', 'LineWidth', 2)
lh.Color = [lh.Color 0.2];

hold on
end

idx = data.s1 == "P3"& idx2;
p2data=data(idx,:);
for cn=min(p2data.CN):max(p2data.CN)
    idx3=p2data.CN==cn
cp2data=p2data(idx3,:);
ec=cp2data.logval;
if sub=='y'
    ec=cp2data.logval-mea;ed=[-3:0.1: 3];
end

hold on;
figure(1)
% h=histogram(ec, "BinWidth" ,bw);
h3=histogram(ec)

h3.Normalization=norm;h3.BinWidth = bw;
% h=histogram(ec, "BinEdges" ,bine);
Bins=((h3.BinEdges(1:end-1)+h3.BinEdges(2:end))/2); 
pc=pc+1;
% Bins=((bine(1:end-1)+bine(2:end))/2);
[ftem,xtem]=ksdensity(ec,ed);
ffc(pc,:)=ftem/sum(sum(ftem));
xii(pc,:)=xtem;

if norm == "count"
    toplot=h3.Values./length(ec);
else
toplot=h3.Values;
toplot=ffc(pc,:);Bins=ed;
end
figure(2)
% plot(Bins,h.Values./length(ec),'g-square', 'LineWidth', 1)
lh=plot(Bins,toplot,'g', 'LineWidth', 2)

lh.Color = [lh.Color 0.2];
% legend({"C", "P2", "P3"});

if sn==0
   title([nm "Consolidated" ]) 
else
title([nm ])
end
% pause(1)
end
end

%%

 close all;
figure(5)
y = []; % your mean vector;
%  s=sum(ffa);nffa=ffa./s;ffaa=nffa;
%   s=sum(ffb);nffb=ffb./s;ffb=nffb;
%    s=sum(ffc);nffc=ffc./s;ffc=nffa;
mffa=mean(ffa);
sffa=std(ffa)/sqrt(min(size(ffa)));
mffb=mean(ffb);
sffb=std(ffb)/sqrt(min(size(ffb)));
mffc=mean(ffc);
sffc=std(ffc)/sqrt(min(size(ffc)));

x=ed;
st=1;en=3;
for i =st:en
    if i==1 y=mffa; std_dev = sffa;cl='k';
    elseif i==2 y=mffb; std_dev = sffb;cl="m";
    elseif i==3 y=mffc;std_dev = sffc;cl='g';
    end
    
curve1 = y + std_dev;
curve2 = y - std_dev;
x2 = [x, fliplr(x)];
inBetween = [curve1, fliplr(curve2)];
h=fill(x2, inBetween, cl);
set(h,'facealpha',.2)
set(h,'EdgeColor','none')
hold on;
lh=plot(x, y, cl, 'LineWidth', 2);
% lh.Color = [lh.Color 0.2];
hold on
end
 leg=["sem","C", "sem","P2","sem","P3"];
 legend(leg(2*st-1:2*en))
figure(5);
if sub=='n' xlim([-0.05 3.75]);
else xlim([-2 2]);
end

ylim([0 0.15]);
 set(gcf, "Units", "pixels");
 set(gcf, "Position", [100 100 800 700]);
 set(gca,'FontSize',32)
saveas(gcf,[nm '_' norm '.pdf'])