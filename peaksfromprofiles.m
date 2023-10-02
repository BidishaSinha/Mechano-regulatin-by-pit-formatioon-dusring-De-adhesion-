int=A;
 %int=B;
[row, col]=size(int);
%%
for i=1:col
    linesc=int(:,i);
    linesc(linesc==0)=[];
    [p,l,w,pr]=findpeaks(linesc,'MinPeakWidth',5,'MinPeakProminence',6)
   findpeaks(linesc,'MinPeakWidth',5,'MinPeakProminence',6)
    peaks{i,1}=p;par{i,2}=l;par{i,3}=w;par{i,4}=pr;
    np(i)=length(p);
    pix(i)=length(linesc);
    npm(i)=np(i)/pix(i);
    pause(5)
end
mean(np)
std(np)
mean(npm)
std(npm)