function colorimt = gray2color(imt,cmap)
% 2017 年 9 月 2 日
% 将灰度图转变成彩色图，使得结果类似在背景上增加了一种颜色

% 输入：
% imt     灰度图矩阵
% cmap    颜色，RGB 格式

% 输出：
% colorimt  增加背景色的彩色图


imtt = imt;
imtt(:,:,2) = imt;
imtt(:,:,3) = imt;
% converting to ycbcr color space
nspace = rgb2ycbcr(imtt);
% double 型颜色 RGB 
umap = im2uint8(cmap);
nimage(:,:,1) = nspace(:,:,1);
nimage(:,:,2) = umap(2);
nimage(:,:,3) = umap(3);

colorimt = uint8(ycbcr2rgb(nimage));

end

