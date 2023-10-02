clear;clc;
wannasave = 't' ;% write 't' to save
rr=9; % No. of ROIs to follow
for ni=1:rr
clearvars -except Npall ni rr wannasave Ndall Adall Ndall_rab4_5 Adall_rab4_5
dirname1='J:\22082023_tirf\control-tryp\plate 2\template match\001\';
% dirname2='I:\Tanmoy\rab4_rab5_both_same_cell\rab 5 rab 4 images\10 min trypsin\rab 5\cell 19.tif';
cd(dirname1)
dir1 = dir('*.tif');
%olddir=cd(dirname);%list=dir('*.tif');
frames=141;
for n=1:frames
I1(:,:,n)=imread(strcat(dir1(n,:).folder, '\', dir1(n,:).name));
filename{n}=dir1(n,:);
end
Imean=mean(I1,2);
Imean=I1(:,:,1);


figure (1); imshow(Imean, []); colormap jet; title ("Average of all frames")
r1 = drawrectangle('Label','Bck','Color',[1 0 0]);
    xstart=floor(r1.Position(2));
    xend=xstart+floor(r1.Position(4));
    ystart=floor(r1.Position(1));
    yend=ystart+floor(r1.Position(3));
%%    
frames=141;
for n=1:frames
    %%
    I2=I1(:,:,n);
    I=I2(xstart:xend,ystart:yend);
    
    T = adaptthresh(I, 0.6);
    % Convert image to binary image, specifying the threshold value.

    BW2 = imbinarize(I,T);
    figure (2);imshow(BW2, []); title("Detected Endosomes"); %colormap jet; colorbar 
 %%
    se = strel('disk',1);BW2b=imfill(BW2,'holes');se2 = strel('disk',1);
BW3=imerode(BW2b, se);BW4=imdilate(BW3, se2);BW5=imfill(BW4, 'holes');
cc = bwconncomp(BW5); 
stats = regionprops(cc,'Area','Eccentricity','PixelIdxList'); 
idx = find([stats.Area] > 10 ); 
BW = ismember(labelmatrix(cc),idx); LL=bwlabeln(BW);
figure (3); imshow(LL, []); colormap jet; colorbar; title ("Labelled endosomes")
cc2 = bwconncomp(BW); 
BWall(:,:,n)=BW;% BWall saves all teh particles detected
stats = regionprops(LL,'Area','Eccentricity','PixelIdxList', 'BoundingBox','Centroid','Circularity');
stats_AAA = regionprops('table',LL,'Area','Eccentricity','PixelIdxList', 'BoundingBox','Centroid','Circularity');
statsall{n}=stats; % saves all teh stats
%
np=max(LL(:)); clear int
Np(n)=np; area=(xend-xstart)*(yend-ystart);
Npall(ni,n)=np;
Ndall(ni,n)=np/(area*0.065*0.065);
Adall(ni,n)=sum(stats_AAA.Area)/area;
props = regionprops(LL, I, 'MeanIntensity');
allIntensities{ni,n} = [props.MeanIntensity];
allvalues{ni,n} = [stats_AAA];
% pause(1)

%%
end
% BW1111=BWall(:,:,1)+BWall(:,:,2);
% [m1,n1] = size(BW1111);
% count1 = 0;
% for k = 1 : m1
%     for l = 1 : n1
%         if BW1111(k,l) == 2
%             count1 = count1 + 1;
%             BW2222(k,l) = 1;
%         else
%             BW2222(k,l) = 0;
%         end
%     end
% end
% stats_AAA111 = regionprops('table',BW2222,'Area','Eccentricity','PixelIdxList', 'BoundingBox');
% [x111,t111] = size(stats_AAA111);
% Ndall_rab4_5(ni,n)=x111/(area*0.065*0.065);
% Adall_rab4_5(ni,n)=sum(stats_AAA111.Area)/area;
% % %cd(olddir);name2=list(n).name;change name accordingly the number end-10;
name=[ dirname1(end-11:end-5) '_ALL_' num2str(xstart, '%04d') num2str(ystart,'%04d' ) num2str(xend,'%04d') num2str(yend,'%04d')];
if wannasave == 't'
save(name)
end







end
%%
% f=cellstr(cellfun(@(x) x(5:6),filename,'UniformOutput',false));
% for i=1:length(filename)
%     try 
%         ff(i)= str2num(f{i});
%     catch
%         ff(i)=0;
%     end
%     
% end
% bar(ff,mean(Ndall))
% %[p15, h15]=ranksum(Ndall(:,1), Ndall(:,5))
% %[p25, h25]=ranksum(Ndall(:,2), Ndall(:,5))
% %%
% 
% for i=1:length(Ndall)
%     plot(ff,Ndall(i,:));
%     hold on;
% end
% hold off