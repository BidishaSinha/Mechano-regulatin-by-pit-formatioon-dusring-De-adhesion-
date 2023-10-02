%% Plotting temporal data with error bar

clear; clc; close all
cd('/Users/bidishasinha/Downloads/for lmm analysis')
con= 4; % No. of time points
sub='n';%y if you want mean-Control subtracted distributions
  nm='tf without trypsin area fraction time wise'  ;  bw=0.05;ed=[-0.35:0.01: 0.35];
 % nm='cyto d tension';bw=0.25;bine=[0:0.15:3];ed=[-1:0.1: 5];
% nm='normal slow sdspace'  ;  bw=0.05; rab 4 area fraction time wise
%  nm='rab 5 area fraction time wise'  ; 
T = readtable([nm '.csv']);

for i = 1: con
a=table2array(T(:,i));
[row2, col2] = size(a(~isnan(a)));
m(i)=mean(a(~isnan(a)));
med(i)=median(a(~isnan(a)));
sd(i)=std(a(~isnan(a)));
se(i)=std(a(~isnan(a)))/sqrt(row2);
end
x=[0:5:15];cl='k';
y=m;     std_dev=se;
curve1 = y + std_dev;
curve2 = y - std_dev;
x2 = [x, fliplr(x)];
inBetween = [curve1, fliplr(curve2)];
h=fill(x2, inBetween, cl);
set(h,'facealpha',.2)
set(h,'EdgeColor','none')
hold on;
lh=plot(x, y, 'k-o', 'LineWidth', 2);
xlabel("Time (min)")
ylabel("Normalized area fraction")


  nm='tf with trypsin area fraction time wise'  ;  bw=0.05;ed=[-0.35:0.01: 0.35];
 % nm='cyto d tension';bw=0.25;bine=[0:0.15:3];ed=[-1:0.1: 5];
% nm='normal slow sdspace'  ;  bw=0.05;
% nm='rab 4 area fraction time wise';

T = readtable([nm '.csv']);

for i = 1: con
a=table2array(T(:,i));
[row2, col2] = size(a(~isnan(a)));
m(i)=mean(a(~isnan(a)));
med(i)=median(a(~isnan(a)));
sd(i)=std(a(~isnan(a)));
se(i)=std(a(~isnan(a)))/sqrt(row2);
end
x=[0:5:15];cl='r';
y=m;     std_dev=se;
curve1 = y + std_dev;
curve2 = y - std_dev;
x2 = [x, fliplr(x)];
inBetween = [curve1, fliplr(curve2)];
h=fill(x2, inBetween, cl);
set(h,'facealpha',.2)
set(h,'EdgeColor','none')
hold on;
lh=plot(x, y, 'r-o', 'LineWidth', 2);

 set(gca,'FontSize',22)
 legend(["", "+Tf", "", "+Tf +Trypsin"])
 
 cd('/Users/bidishasinha/Downloads')