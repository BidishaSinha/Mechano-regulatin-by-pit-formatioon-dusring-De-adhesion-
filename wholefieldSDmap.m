clear
dirname='H:\Jibitesh\IRM\270522\mbdd\Exported\mbcd\006\Set';
old_dir=cd(dirname)
list=dir('*.tif');
nfiles=length(list);
inmin=238.93436;conv=4.80613;

for n=1:2048
     
A1=imread(list(n).name);
A=double(A1);
Im(:,:,n)=double((A-inmin)./conv);
% imshow(A, []);
end
imstd=std(Im,0,3);
imshow(imstd, [2 15]); colormap jet; colorbar
cd(old_dir)