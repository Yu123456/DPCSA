function PlotFace2(datamat,icl, cl)
% 2017 年 9 月 2 日
% Olivetti Face 聚类结果绘制图
% 用 tightPlots 绘制多幅子图，调整间距

% 输入
% datamat   Face 数据集的 mat 文件
% icl       聚类中心点编号
% cl        类别标签

n = 20;     % 绘制成 20*20 的子图形式
K = length(icl);

figure;
Nh = n;
Nw = n;
w = 10;
AR = [92 112];
gap = [0 0.01];
marg_h = [0.05 0.05];
marg_w = [0.05 0.05];
units = 'centimeters';
ha = tightPlots(Nh, Nw, w, AR, gap, marg_h, marg_w, units);
cmap = colormap;    % 调色板
for i=1:n
    for j=1:n
        % 处理第 (i,j) 个图
        k = (i-1)*n + j;        % 处理第 k 幅图
        % 图像中的索引 ii,jjj
        [ii,jj] = NumberFace(i,j);
        
        if cl(k) == 0
            % 未进行类别标记，直接绘制在 subplot(n,n,k)
            axes(ha(k));
            imshow(datamat.faceData{ii,jj});
        elseif ismember(k,icl)
            % 如果是中心点
            nk = cl(k);        % 类标签，即第 nk 个类
            ic = int8((nk*64.0)/(K*1.0));
            ima =gray2color(datamat.faceData{ii,jj},cmap(ic,:));  % 转成背景彩色
            ima = AddWhite(ima);     % 增加中心点标志，白色正方形
            axes(ha(k));
            imshow(ima);
        else
            % 已经标记类别标号，但不是中心点
            nk = cl(k);        % 类标签，即第 nk 个类
            ic = int8((nk*64.0)/(K*1.0));
            ima =gray2color(datamat.faceData{ii,jj},cmap(ic,:));  % 转成背景彩色
            axes(ha(k));
            imshow(ima);
        end
    end
end

end

function [ii,jj] = NumberFace(i,j)

if j < 11
    ii = 2*i -1;
    jj = j;
else
    ii = 2*i;
    jj = j-10;
end

end