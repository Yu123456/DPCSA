function PlotFace(datamat,icl, cl)
% 2017 年 9 月 2 日
% Olivetti Face 聚类结果绘制图

% 输入
% datamat   Face 数据集的 mat 文件
% icl       聚类中心点编号
% cl        类别标签

n = 20;     % 绘制成 20*20 的子图形式
K = length(icl);

margin = [0.0005 0.00005];
figure;
cmap = colormap;    % 调色板
for i=1:n
    for j=1:n
        % 处理第 (i,j) 个图
        k = (i-1)*n + j;        % 处理第 k 幅图
        % 图像中的索引 ii,jjj
        [ii,jj] = NumberFace(i,j);
        
        if cl(k) == 0
            % 未进行类别标记，直接绘制在 subplot(n,n,k)
            subplot_tight(n,n,k,margin);
            imshow(datamat.faceData{ii,jj});
        elseif ismember(k,icl)
            % 如果是中心点
            nk = cl(k);        % 类标签，即第 nk 个类
            ic = int8((nk*64.0)/(K*1.0));
            ima =gray2color(datamat.faceData{ii,jj},cmap(ic,:));  % 转成背景彩色
            ima = AddWhite(ima);     % 增加中心点标志，白色正方形
            subplot_tight(n,n,k,margin);
            imshow(ima);
        else
            % 已经标记类别标号，但不是中心点
            nk = cl(k);        % 类标签，即第 nk 个类
            ic = int8((nk*64.0)/(K*1.0));
            ima =gray2color(datamat.faceData{ii,jj},cmap(ic,:));  % 转成背景彩色
            subplot_tight(n,n,k,margin);
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