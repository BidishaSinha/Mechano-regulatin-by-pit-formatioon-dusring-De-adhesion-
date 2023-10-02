clear
close all
% f1=    '/Users/bidishasinha/Downloads/Tithi';
 % f1=    '/Users/bidishasinha/Downloads/070923_ap2_clathrin';
 % f1=    '/Users/bidishasinha/Downloads/280923_clathrin_ap2_new/control';
  f1=    '/Users/bidishasinha/Downloads/280923_clathrin_ap2_new/trypsin';

 % ctrl_001 - Alexa 568 STED
 % clathrin+AP2_control_001_AP2
cl=0;
for cll=1:28 % Chhange as per number of cells 
    BW6=[];
  fs='tryp_';
 % fs='ctrl_';
% f2=['ctrl_' num2str(cl,'%03d') ' - STAR RED STED.tiff']; f3=['ctrl_' num2str(cl,'%03d') ' - mCherry STED.tiff'];
% f2=[fs num2str(cll,'%03d') ' - STAR RED STED.tiff']; f3=['trp_' num2str(cll,'%03d') ' - mCherry STED.tiff'];
% f2=[fs num2str(cll,'%03d') ' - STAR RED.tiff']; f3=[fs num2str(cll,'%03d') ' - mCherry.tiff'];
% f5=[fs num2str(cll,'%03d') ' - STAR RED STED.tiff']; f6=[fs num2str(cll,'%03d') ' - mCherry STED.tiff'];
f2=[fs num2str(cll,'%03d') ' - Alexa 568.tiff']; f3=[fs num2str(cll,'%03d') ' - STAR RED.tiff'];
f5=[fs num2str(cll,'%03d') ' - Alexa 568 STED.tiff']; f6=[fs num2str(cll,'%03d') ' - STAR RED STED.tiff'];

filename=[f1 '/' f2];
filename2=[f1 '/' f3];filename5=[f1 '/' f5];filename6=[f1 '/' f6];
I2a=imread(filename); ThreshA=20; ThreshB=700;
I4a=imread(filename2);
I5a=imread(filename5);
I6a=imread(filename6);
 % imshow(I4a, []); colormap jet;
%%
for run=1:3
    BW6=[];
cl=cl+1;
figure (1)
imshow(I4a, []); colormap jet;
    r1 = drawrectangle('Label','Bck','Color',[1 0 0]);
    xstart=floor(r1.Position(2));
    xend=xstart+floor(r1.Position(4));
    ystart=floor(r1.Position(1));
    yend=ystart+floor(r1.Position(3));
   
    I2=I2a(xstart:xend,ystart:yend);
    I4=I4a(xstart:xend,ystart:yend);
    I5=I5a(xstart:xend,ystart:yend);
    I6=I6a(xstart:xend,ystart:yend);
c=0;
%%
for i=1:2
    
    
    if i==1 I3=I2;type="AP2";
    elseif i==2 I3=I4;type='Clath';
    end
    

 T = adaptthresh(I3, 0.6); %, 'NeighborhoodSize', 7);%was0.5
    % Convert image to binary image, specifying the threshold value.

    BW2 = imbinarize(I3,T);% imbinarize(I, T)
%     figure (2);imshow(BW2, []); title("Detected Pits"); %colormap jet; colorbar 

    se = strel('disk',1);BW2b=imfill(BW2,'holes');se2 = strel('disk',1);
    BW3b=imerode(BW2, se);BW3=imerode(BW3b, se);BW4=imdilate(BW3b, se2);BW5=imfill(BW4, 'holes');
    bw=BW5;
     figure (2)
     subplot(2,2,2*(i-1)+1);imshow(BW5, []);title(type)
     
 
    D = bwdist(~bw);
imshow(D,[])
% title('Distance Transform of Binary Image')
    D = -D;
% imshow(D,[])
% title('Complement of Distance Transform')
    L = watershed(D);
L(~bw) = 0;
    
    cc = bwconncomp(L); %was BW5
    stats = regionprops(cc,'Area','Eccentricity','PixelIdxList', 'centroid'); 
    idx = find(([stats.Area] > ThreshA) & ([stats.Area] <ThreshB)); % THRESH A 
BW = ismember(labelmatrix(cc),idx); LL=bwlabeln(BW); BW6(:,:,i)=BW;
% figure (3);
 subplot(2,2,2*i); imshow(BW, []); title(type)%colorbar; %title ("Labelled endosomes")
cc2 = bwconncomp(BW); 
% BWall(:,:,n)=BW;% BWall saves all teh particles detected
 stats2 = regionprops(LL,'Area','Eccentricity','PixelIdxList', 'BoundingBox','Centroid','Circularity');
% stats_AAA = regionprops('table',LL,'Area','Eccentricity','PixelIdxList', 'BoundingBox','Centroid','Circularity');
% statsall{n}=stats; % saves all teh stats
sLL=BW(BW==1);
if i==1 statsAP2=stats2;totAAp2(cl)=size(sLL,1);
    else statsC =stats2;totCl(cl)=size(sLL,1);
end
end
save([num2str(cl) fs 'statsCON.mat'], 'statsAP2','statsC')

BW7=BW6(:,:,1)+BW6(:,:,2);
figure(2)
BW9=BW7(BW7==2);
colocA(cl)=size(BW9,1)
colocAAp2(cl)=100*size(BW9,1)/totAAp2(cl)
colocCL(cl)=100*size(BW9,1)/totCl(cl)
%% STED
for i=1:2
    
    
    if i==1 I3=I5;type="AP2STED";
    elseif i==2 I3=I6;type='ClathSTED';
    end
    

 T = adaptthresh(I3, 0.6); %, 'NeighborhoodSize', 7);%was0.5
    % Convert image to binary image, specifying the threshold value.

    BW2 = imbinarize(I3,T);% imbinarize(I, T)
%     figure (2);imshow(BW2, []); title("Detected Pits"); %colormap jet; colorbar 

    se = strel('disk',1);BW2b=imfill(BW2,'holes');se2 = strel('disk',1);
    BW3b=imerode(BW2, se);BW3=imerode(BW3b, se);BW4=imdilate(BW3b, se2);BW5=imfill(BW4, 'holes');
    bw=BW5;
     figure (2)
     subplot(2,2,2*(i-1)+1);imshow(BW5, []);title(type)
     
 %%
    D = bwdist(~bw);
imshow(D,[])
% title('Distance Transform of Binary Image')
    D = -D;
% imshow(D,[])
% title('Complement of Distance Transform')
    L = watershed(D);
L(~bw) = 0;
    
    cc = bwconncomp(L); %was BW5
    stats = regionprops(cc,'Area','Eccentricity','PixelIdxList', 'centroid'); 
    idx = find(([stats.Area] > ThreshA) & ([stats.Area] <ThreshB)); % THRESH A 
BW = ismember(labelmatrix(cc),idx); LL=bwlabeln(BW); BW6(:,:,i)=BW;
% figure (3);
 subplot(2,2,2*i); imshow(BW, []); title(type)%colorbar; %title ("Labelled endosomes")
cc2 = bwconncomp(BW); 
% BWall(:,:,n)=BW;% BWall saves all teh particles detected
 stats2 = regionprops(LL,'Area','Eccentricity','PixelIdxList', 'BoundingBox','Centroid','Circularity');
% stats_AAA = regionprops('table',LL,'Area','Eccentricity','PixelIdxList', 'BoundingBox','Centroid','Circularity');
% statsall{n}=stats; % saves all teh stats
sLL=BW(BW==1);
if i==1 statsAP2s=stats2;totAAp2s(cl)=size(sLL,1);
    else statsCs =stats2;totCls(cl)=size(sLL,1);
end
end
save([num2str(cl) fs 'statssted28.mat'], 'statsAP2s','statsCs')

BW7=BW6(:,:,1)+BW6(:,:,2);
figure(2)
BW9=BW7(BW7==2);
colocAs(cl)=size(BW9,1)
colocAAp2s(cl)=100*size(BW9,1)/totAAp2s(cl)
colocCLs(cl)=100*size(BW9,1)/totCls(cl)
end
end
%%
save([num2str(cl) fs 'coloc28.mat'], 'colocAAp2','colocCL', 'colocA','colocAAp2s','colocCLs', 'colocAs')