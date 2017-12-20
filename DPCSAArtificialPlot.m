% 2017 年 9 月 4 日
% 人工合成数据集
% 计算 FKNNDPC 聚类评价指数， Adjust Rand Index, 
% Adjusted Mutual Information (AMI)

% 绘制二维图

clear all
close all
clc
disp('DPCSA Clustering based on sequence running ...');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 添加数据文件夹
addpath('C:\Users\YU Donghua\Documents\MATLAB\Cluster\Data');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 以下数据集是 DPCSA 中采用的人工数据集

% object name
objName = 'Aggregation.mat';
% xx 为数据点坐标
% 其格式为：数据点 x 坐标   数据点 y 坐标  类别标号
datamat = load(objName);
xx = datamat.attribute;
xx = libsvmscale(xx,0,1);  % 数据归一化
label = datamat.label;     % 实际簇标签
dist = pdist2(xx,xx);
[ND, NL] = size(dist);  % ND = NL  数据集大小

% % object name
% objName = 'D31.mat';
% % xx 为数据点坐标
% % 其格式为：数据点 x 坐标   数据点 y 坐标  类别标号
% datamat = load(objName);
% xx = datamat.attribute;
% xx = libsvmscale(xx,0,1);  % 数据归一化
% label = datamat.label;     % 实际簇标签
% dist = pdist2(xx,xx);
% [ND, NL] = size(dist);  % ND = NL  数据集大小

% % object name
% objName = 'dim512.mat';
% % xx 为数据点坐标
% % 其格式为：数据点 x 坐标   数据点 y 坐标  类别标号
% datamat = load(objName);
% xx = datamat.attribute;
% xx = libsvmscale(xx,0,1);  % 数据归一化
% label = datamat.label;     % 实际簇标签
% dist = pdist2(xx,xx);
% [ND, NL] = size(dist);  % ND = NL  数据集大小

% % object name
% objName = 'dim1024.mat';
% % xx 为数据点坐标
% % 其格式为：数据点 x 坐标   数据点 y 坐标  类别标号
% datamat = load(objName);
% xx = datamat.attribute;
% xx = libsvmscale(xx,0,1);  % 数据归一化
% label = datamat.label;     % 实际簇标签
% dist = pdist2(xx,xx);
% [ND, NL] = size(dist);  % ND = NL  数据集大小

% % object name
% objName = 'flame.mat';
% % xx 为数据点坐标
% % 其格式为：数据点 x 坐标   数据点 y 坐标  类别标号
% datamat = load(objName);
% xx = datamat.attribute;
% xx = libsvmscale(xx,0,1);  % 数据归一化
% label = datamat.label;     % 实际簇标签
% dist = pdist2(xx,xx);
% [ND, NL] = size(dist);  % ND = NL  数据集大小

% % object name
% objName = 'pathbased1.mat';
% % xx 为数据点坐标
% % 其格式为：数据点 x 坐标   数据点 y 坐标  类别标号
% datamat = load(objName);
% xx = datamat.attribute;
% xx = libsvmscale(xx,0,1);  % 数据归一化
% label = datamat.label;     % 实际簇标签
% dist = pdist2(xx,xx);
% [ND, NL] = size(dist);  % ND = NL  数据集大小

% % object name
% objName = 'newpathbased1.mat';
% % xx 为数据点坐标
% % 其格式为：数据点 x 坐标   数据点 y 坐标  类别标号
% datamat = load(objName);
% xx = datamat.attribute;
% xx = libsvmscale(xx,0,1);  % 数据归一化
% label = datamat.label;     % 实际簇标签
% dist = pdist2(xx,xx);
% [ND, NL] = size(dist);  % ND = NL  数据集大小

% % object name
% objName = 'spiral.mat';
% % xx 为数据点坐标
% % 其格式为：数据点 x 坐标   数据点 y 坐标  类别标号
% datamat = load(objName);
% xx = datamat.attribute;
% xx = libsvmscale(xx,0,1);  % 数据归一化
% label = datamat.label;     % 实际簇标签
% dist = pdist2(xx,xx);
% [ND, NL] = size(dist);  % ND = NL  数据集大小


% % object name
% objName = 's1.mat';
% % xx 为数据点坐标
% % 其格式为：数据点 x 坐标   数据点 y 坐标  类别标号
% datamat = load(objName);
% xx = datamat.attribute;
% xx = libsvmscale(xx,0,1);  % 数据归一化
% label = datamat.label;     % 实际簇标签
% dist = pdist2(xx,xx);
% [ND, NL] = size(dist);  % ND = NL  数据集大小

% % object name
% objName = 's2.mat';
% % xx 为数据点坐标
% % 其格式为：数据点 x 坐标   数据点 y 坐标  类别标号
% datamat = load(objName);
% xx = datamat.attribute;
% xx = libsvmscale(xx,0,1);  % 数据归一化
% label = datamat.label;     % 实际簇标签
% dist = pdist2(xx,xx);
% [ND, NL] = size(dist);  % ND = NL  数据集大小

% % object name
% objName = 's3.mat';
% % xx 为数据点坐标
% % 其格式为：数据点 x 坐标   数据点 y 坐标  类别标号
% datamat = load(objName);
% xx = datamat.attribute;
% xx = libsvmscale(xx,0,1);  % 数据归一化
% label = datamat.label;     % 实际簇标签
% dist = pdist2(xx,xx);
% [ND, NL] = size(dist);  % ND = NL  数据集大小

% % object name
% objName = 's4.mat';
% % xx 为数据点坐标
% % 其格式为：数据点 x 坐标   数据点 y 坐标  类别标号
% datamat = load(objName);
% xx = datamat.attribute;
% xx = libsvmscale(xx,0,1);  % 数据归一化
% label = datamat.label;     % 实际簇标签
% dist = pdist2(xx,xx);
% [ND, NL] = size(dist);  % ND = NL  数据集大小





%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
disp(['data set : ',objName]);
% DPCSA 聚类
[cl,icl, time]=DPCSAF(dist);

% 三种度量评价聚类
Acc = ClusteringAccuracy(label,cl);
ARI = AdjustRandIndex(label,cl);
AMI = ami(label,cl);

% F/P 值
% F  中心点个数，P 找出的中心点实际位于多少个簇内
iclabel = label(icl);
F = length(icl);
P = length(unique(iclabel));


disp(['                  Acc  : ',num2str(Acc)]);
disp(['     Adjust Rand index : ',num2str(ARI)]);
disp(['                   AMI : ',num2str(AMI)]);
disp(['                     F : ',num2str(F)]);
disp(['                     P : ',num2str(P)]);
disp(['clustering running time: ',num2str(time),' s']);


eval =[Acc, ARI, AMI, F, P, time];


% 绘制聚类图
if length(xx(1,:)) == 2
    % 如果是 2 维数据，则直接绘制数据图
    % 默认为第 1 列为 x 坐标，第 2 列为 y 坐标
    Y1 = xx;
    % 绘制了所有的点
    % 全部是黑色的点，之后再去上色
    figure;    
    
    plot(Y1(:,1),Y1(:,2),'o','MarkerSize',2,'MarkerFaceColor','k','MarkerEdgeColor','k');
    title (['2D directly plot, clusters : ',num2str(length(icl))],'FontSize',15.0);
    xlabel ('X');
    ylabel ('Y');
    
    
    NCLUST = length(icl);         % 簇个数
    % 获取当前图形的颜色板
    % 返回的是一个 64*3 的矩阵（缺省值情况）
    cmap=colormap;
    for i=1:NCLUST
        % 绘制簇
        % 用该类的颜色绘制
        nn= cl==i;
        % 对于每个簇类确定一个颜色变量 ic
        % 也就是 cmap 的某一行
        ic=int8((i*64.)/(NCLUST*1.));
        Ax = Y1(nn,1);
        Ay = Y1(nn,2);
        hold on
        plot(Ax,Ay,'o','MarkerSize',2,'MarkerFaceColor',cmap(ic,:),'MarkerEdgeColor',cmap(ic,:));
        % 绘制中心点
        plot(Y1(icl(i),1),Y1(icl(i),2),'s','MarkerSize',10,'MarkerFaceColor',cmap(ic,:),'MarkerEdgeColor',cmap(ic,:));
    end
    hold off
else
    % 如果不是 2 维数据，则需要进行非量测多尺度变化
    % mdscale 是非量测多尺度变化（ Non-metric Multi-Dimensional Scaling）
    % mdscale 直观展现数据差异或通过降维来呈现高维数据
    % 使用 mdscale 函数执行非经典多维度尺度变换，需要指定期望维数和重建输出配置的
    % 方法。mdscale 的第二个输出是一个评价输出配置的值，它衡量了输出配置的距离与
    % 原始输入差异性的吻合程度
    Y1 = mdscale(dist, 2, 'criterion','metricstress');
    
    % 绘制了所有的点
    % 全部是黑色的点，之后再去上色
    figure;
    plot(Y1(:,1),Y1(:,2),'o','MarkerSize',2,'MarkerFaceColor','k','MarkerEdgeColor','k');
    title (['2D Nonclassical multidimensional scaling, clusters : ',num2str(length(icl))],'FontSize',15.0);
    xlabel ('X');
    ylabel ('Y');
    
    NCLUST = length(icl);         % 簇个数
    % 获取当前图形的颜色板
    % 返回的是一个 64*3 的矩阵（缺省值情况）
    cmap=colormap;
    for i=1:NCLUST
        % 绘制簇
        % 用该类的颜色绘制
        nn= cl==i;
        % 对于每个簇类确定一个颜色变量 ic
        % 也就是 cmap 的某一行
        ic=int8((i*64.)/(NCLUST*1.));
        Ax = Y1(nn,1);
        Ay = Y1(nn,2);
        hold on
        plot(Ax,Ay,'o','MarkerSize',2,'MarkerFaceColor',cmap(ic,:),'MarkerEdgeColor',cmap(ic,:));
        % 绘制中心点
        plot(Y1(icl(i),1),Y1(icl(i),2),'s','MarkerSize',10,'MarkerFaceColor',cmap(ic,:),'MarkerEdgeColor',cmap(ic,:));
    end
    hold off
end


disp('running over!');