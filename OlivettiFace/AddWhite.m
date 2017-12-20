function wcim = AddWhite(cim)
% 2017 年 9 月 2 日
% 给彩色图像增加一个白色圆域

[n,m] = size(cim(:,:,1));
% 4 * 4 的正方形
h = 20;
boundary = 10;
wcim = cim;
wcim(boundary:boundary+h, m-boundary-h:m-boundary,1) = 255;
wcim(boundary:boundary+h, m-boundary-h:m-boundary,2) = 255;
wcim(boundary:boundary+h, m-boundary-h:m-boundary,3) = 255;


end

