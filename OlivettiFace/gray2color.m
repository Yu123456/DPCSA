function colorimt = gray2color(imt,cmap)
% 2017 �� 9 �� 2 ��
% ���Ҷ�ͼת��ɲ�ɫͼ��ʹ�ý�������ڱ�����������һ����ɫ

% ���룺
% imt     �Ҷ�ͼ����
% cmap    ��ɫ��RGB ��ʽ

% �����
% colorimt  ���ӱ���ɫ�Ĳ�ɫͼ


imtt = imt;
imtt(:,:,2) = imt;
imtt(:,:,3) = imt;
% converting to ycbcr color space
nspace = rgb2ycbcr(imtt);
% double ����ɫ RGB 
umap = im2uint8(cmap);
nimage(:,:,1) = nspace(:,:,1);
nimage(:,:,2) = umap(2);
nimage(:,:,3) = umap(3);

colorimt = uint8(ycbcr2rgb(nimage));

end

