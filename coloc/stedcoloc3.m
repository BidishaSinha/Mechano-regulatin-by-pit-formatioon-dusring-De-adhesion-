clear
ldall=[];mldall=[];counter=0;
% fn='ctrl_statsCON'; % Change here
% fn='clathrin+AP2_trypsin_statsCON'; % Change here
fn='ctrl_statssted28'; % Change here

for n=1:70
   fname= [num2str(n) fn '.mat']
load(fname)
% s=size(statsC,1)
s=size(statsCs,1) %for sted
if s>0
for i=1:s
% Cenc=statsC(i).Centroid; %for confocal
Cenc=statsCs(i).Centroid; %for sted
X(i)=Cenc(1);Y(i)=Cenc(2);
end
end
% sa=size(statsAP2,1)
sa=size(statsAP2s,1) %for sted
if sa>0
for i=1:sa
% Cenc=statsAP2(i).Centroid; %for confocal
Cenc=statsAP2s(i).Centroid; %for sted
Xa(i)=Cenc(1);Ya(i)=Cenc(2);
end
end

ld=[];mld=[];
for i=1:s
        ds=10000;counter=counter+1;
    for j=1:sa
    d=sqrt((X(i)-Xa(j))^2 + (Y(i)-Ya(j))^2);
        if d<ds ds=d;
        end
    end
ld(i)=ds;
    if ds <10000
    ldall=[ldall, ld(i)];
    end
end
mld=mean(ld(ld<10000));
mldall=[mldall,mld];

end
save([fn 'ALLcon28.mat'])
