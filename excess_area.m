% % IF continuing after a longtime
% Allfilenames=uigetfile({'*.mat'}, 'Select all matfiles to work woth','MultiSelect','On');
% [rr ncells]=size(Allfilenames);loadten='n';
%     %jjj1 = jjj+41;
% %%
% for nn=1:ncells 
%    clearvars -except nn Allfilenames rr ncells 
%    name=Allfilenames{nn};filename = name;
 %%
%     load(filename);
clear;clc
filename = "BAAAna001-01Cell_01";
path = strcat("J:\normal\04082021\normal\p2\001_1\","\set");
load(strcat("J:\normal\04082021\normal\p2\BAAAna001-01Cell_01.mat"));
%path = d_name;
cccc = strcat("newexcess_area_same_fbr_20frames_",filename,".mat");
Inmin = 501.79;
conv = 20.15;
pix_siz = 72; % in nm
f = fullfile(path, "*.tif");
list = dir(f);
len_z =20; %length(list);
for k=1:len_z
    %thispath(k,1) = fullfile(path, list(k).name);
    A = imread(fullfile(path, list(k).name));
    AA1=double((A(xstart:xend, ystart:yend)-Inmin)./conv);
    for i=1:length(fbrTen)
        Tension(i) = fbrTen(i,2);
        fbr_numbers(i) = fbrTen(i,1);
    end
    Tension1 = Tension'; fbr_numbers1 = fbr_numbers';
%% for selecting the locations of fbrs
    for i=1:length(fbrTen)
        pos_x(i,:) =  FBR(fbr_numbers1(i,:),1);
        pos_y(i,:) =  FBR(fbr_numbers1(i,:),2);
    end

%%
    for i=1:length(fbrTen)
        Im_stack_fbr(:,:,i) = AA1(pos_x(i):pos_x(i)+11,pos_y(i):pos_y(i)+11);
    end
%%
    for i=1:length(fbrTen)
        AA = Im_stack_fbr(:,:,i);
        A1=AA(1:end-1, 1:end-1);
        A2=AA(2:end, 2:end);
        A1=AA(1:end-1, 1:end);
        A2=AA(2:end, :);
        hx=A1-A2;
        hx1=hx(1:end-1, :);
        hx=A1-A2;
        hx1=hx(:, 1:end-1)./pix_siz;
        A1y=AA(1:end, 1:end-1);
        A2y=AA(1:end, 2:end);
        hy=A1y-A2y;
        hy1=hy(1:end-1, :)./pix_siz;
        dA2=(1+(hx1.*hx1)+(hy1.*hy1));
        dA=(dA2.^(1/2))*pix_siz*pix_siz;
        delA=dA-pix_siz*pix_siz;
    %imshow(dA2, []); colormap jet; colorbar
        stack_eA(:,:,i,k)=100*(delA./dA);
%     s=12;  
%             stack_filteredImage(:,:,i) = conv2((stack_eA(:,:,i)), ones(s)/(s*s));
    end

    for i=1:length(fbrTen)
        s=13;  
        filteredImage = conv2((stack_eA(:,:,i,k)), ones(s)/(s*s));
        stack_filteredImage(:,:,i,k) = filteredImage(7:17,7:17);
%         mean_stack_filteredImage(i,k) = mean(stack_filteredImage(:,:,i,k), 'all');
        mean_stack_filteredImage(i,k) = mean(stack_eA(:,:,i,k), 'all');%NOT FILTERING ANYMORE
        %excess_area_all = mean_stack_filteredImage';
    end
    %save("ezrin_inhibited_020.mat")
end
mean_frames_filtered_image = mean(mean_stack_filteredImage,2);
sd_frames_filtered_image = std(mean_stack_filteredImage,0,2);
%%
save(cccc, 'mean_frames_filtered_image', 'sd_frames_filtered_image', 'Tension1', 'FBR', 'fbrTen');