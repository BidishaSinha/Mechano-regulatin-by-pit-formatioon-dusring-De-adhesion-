% x=fbrTen(:,1);
% y=fbrTen(:,2);
fbrsize=12; %2x2
close all
[row,col]=size(FBinM3);
% Tenmap=zeros(row, col);
Tenmap=ones(row,col)*-20;
for i=1:length(fbrTen);
    id=fbrTen(i,1);
    x=FBR(id,1);
    y=FBR(id,2);
    Tenmap(x:x+fbrsize-1, y:y+fbrsize-1)=fbrTen(i,2);
end
imshow(Tenmap, [-20 100]); colormap jet
colorbar