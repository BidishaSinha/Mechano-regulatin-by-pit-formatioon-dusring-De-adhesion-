clear;clc;
close all
I = imread('I:\clathrin counting\14032022\clathrin transfection\0 min\cme trans_0 min_001.tif');
imtool(I,[])
Iblur = imgaussfilt(I,10);
denoisedImage = (I - Iblur);
normImage1 = mat2gray(denoisedImage);
%T111 = adaptthresh(I, 0.4);
BW1 = im2bw(normImage1,0.01);
imtool(BW1)
roi = regionprops('table',BW1,'Centroid');
%%
%output = imgaussfilt(I,8);                                 
%normImage = mat2gray(output);
%BW = im2bw(normImage,0.09);
%imtool(BW)
%mask = boundarymask(BW);
%%
[sROI] = ReadImageJROI('I:\clathrin counting\14032022\clathrin transfection\masks\0 min\cell1.roi');
sROI;
T = struct2cell(sROI);
M = cell2mat(T(7));
x = M(:,1);
y = M(:,2);
BW = roipoly(I,x,y);
imtool(BW)
bmask = boundarymask(BW);
%
%imtool(labeloverlay(BW,bmask,'Transparency',0))
%imtool(imfuse(bmask,I))
%%
% above allover roi is found
% clearing paricles outside mask
ROI_sel = BW1;
ROI_sel(BW == 0) = 0;
imtool(ROI_sel)
SE = strel("disk",1);
a1 = imerode(ROI_sel,SE);
b1 = imdilate(a1,SE);
%b1 = imdilate(ROI_sel,SE);
%imtool(b1)
imtool(imfuse(bmask,b1))
%%
roi_actual = regionprops('table',b1,'Centroid');
roi_area_cen = regionprops('table',b1,'area','Centroid');
[x,t] = size(roi_actual);
% selected roi is found out,next we have to calculate the area
[m,n] = size(BW);
count = 0;
for i = 1 : m
    for j = 1 : n
        if BW(i,j) == 1
         count = count + 1;
        end
    end
end
Total_area_of_cell = count*(0.065*0.065);
Number_density = (x/Total_area_of_cell);
% Number density has been found now letz calulate area density
[m1,n1] = size(ROI_sel);
count1 = 0;
for k = 1 : m1
    for l = 1 : n1
        if ROI_sel(k,l) == 1
         count1 = count1 + 1;
        end
    end
end
Area_density = count1/count;
% for finding the average distance between rois'
% converting table to array first
A_roi = table2array(roi_area_cen);
A = table2array(roi_actual);
[m2,n2] = size(A);
D = pdist(A);
[t1,t2] = size(D);
Sum1 = (sum(D));
Av_dist_px = (Sum1/t2);
Av_dist_um = Av_dist_px * 0.065;
% for saving the rois selected
fid = fopen('cme trans_0 min_001.txt','wt');
for ii = 1:size(A_roi,1)
    fprintf(fid,'%g\t',A_roi(ii,:));
    fprintf(fid,'\n');
end
fclose(fid);
Number_density
Area_density
Av_dist_um
Total_area_of_cell

        