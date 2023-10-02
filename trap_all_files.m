%%
path = "K:\optical trap\060822\tif\";
mask_path = "K:\optical trap\060822\masks\";
list11=dir(strcat(path,'\'));


%%

for jj = 1:length(list11)
    clearvars -except list11 jj path mask_path
    count_11 = 0;
    M1 = 10;
    T1 =0.0001 %threshold
    cut_off = 1200;
    path22 = strcat(path, '\', list11(jj).name);
    f = fullfile(path22, "*.tif");
    list = dir(f);
    len_z = length(list); 
    
    for k1=1:len_z
        thispath(k1,1) = fullfile(path,list11(jj).name,list(k1).name);
        I = imread(thispath(k1,1));
        Iblur = imgaussfilt(I,M1);
        denoisedImage = (I - Iblur);
        normImage1 = mat2gray(denoisedImage);
        BW1 = ~im2bw(normImage1,T1);
        [sROI] = ReadImageJROI(strcat(mask_path,list11(jj).name,'.roi'));
        %sROI;
        T = struct2cell(sROI);
        M = cell2mat(T(7));
        x = M(:,1);
        y = M(:,2);
        BW = roipoly(I,x,y);
        bmask = boundarymask(BW);
    %%
    % above allover roi is found
    % clearing paricles outside mask
        ROI_sel = BW1;
        ROI_sel(BW == 0) = 0;
        SE = strel("disk",1);
        a1 = imerode(ROI_sel,SE);
        b1 = imdilate(a1,SE);
        BW2 = bwareaopen(b1,cut_off);
        BW3 = imfill( BW2 ,'holes');
    %imtool(BW3_check)
        %s = table2array(regionprops('table',BW3, 'centroid', 'area'));
        [xx11 yy11]=bwboundaries(BW3);
        if isempty(xx11) == false
            xx22 = double(xx11{1,1}(:,1)); 
            yy22 = double(xx11{1,1}(:,2));
            XY = [xx22,yy22];
            cen_xy = CircleFitByPratt(XY);
        %if cen_xy ~= 0
            count_11 = count_11+1;
            data(count_11,:) = cen_xy;
        end
    end
    %data = data';
    fid = fopen(strcat(list11(jj).name,".txt"),'wt');
    for ii2 = 1:size(data,1)
        fprintf(fid,'%g\t',data(ii2,:));
        fprintf(fid,'\n');
    end
    fclose(fid);
end
