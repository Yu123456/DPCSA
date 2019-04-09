function [cl, icl, time]=DPCSAF(dist)
% 2017年 8 月 25 日
% DPCSA 聚类
% 1、基于截断序列加权的局部密度计算
% 2、两种类别赋值策略

% dist 样本距离矩阵

% 返回值
% cl   各样本所属簇标号
% icl  中心点所对应的数据编号, icl(2) = k  说明第 2 个簇的中心点编号为 k
% time  运行时间

tic;     % 第一次计时开始

[N,~] = size(dist);       % 样本个数

% 计算局部密度
% rho = ObjectDensity3(dist);    % 局部密度方法 3
% rho = ObjectDensity5(dist);    % 局部密度方法 5
% rho = ObjectDensity6(dist);    % 局部密度方法 6
% rho = ObjectDensity7(dist);    % 局部密度方法 7
% rho = ObjectDensity8(dist);    % 局部密度方法 8
rho = ObjectDensity9(dist);    % 局部密度方法 9
% rho = ObjectDensity10(dist);    % 局部密度方法 10
% rho = libsvmscale(rho,0,1);      % 密度归一化
% 将 rho 从大到小排序
% rho_sorted 是排序结果向量
% ordrho 保存的是 rho_sorted 向量中元素在 rho 中的编号
[~,ordrho]=sort(rho,'descend');
% maxd 为密度最大值点的最大距离
maxd=max(dist(ordrho(1),:));
% delta 就是文中的 \delta
% 如果用的“截断”核
% rho 为小于截断距离的邻居数，也就是密度
% 因此，这里密度最大的点先设置 delta 为 -1
% 而其他的密度点的 delta 值为最小的距离值
delta = zeros(N,1);
% delta(ordrho(1))=-1.;
% nneigh 就是距其最近的点的编号
nneigh = zeros(N,1);
% nneigh(ordrho(1))=0;

% 计算 delta 值的过程
% 找到比自己密度大的点中距离自己最近的点
% 记录点编号在 nneigh 中，记录距离在 delta 中
for ii = 2:N
    [value, jj] =min(dist(ordrho(ii),ordrho(1:ii-1)));
    delta(ordrho(ii)) = value;
    nneigh(ordrho(ii)) = ordrho(jj);
end

% 密度最大的 delta 为 delta 中最大值？
% 论文中定义为密度最大的点的 delta 为与其最远点之间的距离
% 因为密度最大的点与之最远的距离的点肯定大于等于 delta 的最大值
% 这样减少了计算量（如果 max 函数不是逐个搜索的话，否则计算复杂度相同）
% delta(ordrho(1))=max(delta(:));
delta(ordrho(1))=maxd;
% 归一化处理
% deltaMin = min(delta);
% delta = (delta-deltaMin)/(maxd-deltaMin);

% 第一幅绘图--决策图
fig_cluster = figure;
% 绘制 rho, delta 图，并获取图像句柄 tt
% o 表示绘制离散点
% MarkerSize 标识符大小
% MarkerFaceColor 标识符填充颜色, k 表示黑色
% MarkerEdgeColor 标识符边缘颜色, k 表示黑色
tt=plot(rho(:),delta(:),'o','MarkerSize',5,'MarkerFaceColor','k','MarkerEdgeColor','k');
xlabel ('\rho');
ylabel ('\delta');

t1 = toc;      % 第一次计时结束

% 在第一幅图中获取矩形区域
% rect 一共四个数值
% 分别为 xmin ymin width height
rect = getrect(fig_cluster);

tic;        % 第二次计时开始

% x 轴为 rho, 这里为矩形区域的 rho 最小值
rhomin=rect(1);
% 第四个参数为高度
% 这里代码存在错误，作者已经表示这是个错误
% 并给出了改正的代码
% deltamin = rect(4) 修改为 deltamin = rect(2)
deltamin=rect(2);
% 簇类数量
NCLUST=0;
% 初始化 cl 数组为 0
% cl 为归属标志数组，cl(i) = j 表示第 i 号数据点归属于第 j 个 cluster
cl = zeros(1,N);
% 统计数据点 rho 和 delta 值都大于最小值的点
% 也就是圈矩形框，把矩形的左边界和下边界作为了一个分割边界
% 找到符合要求的点
% 找到一个就说明找到一个簇类中心
% 其 cl(i) 的值就是簇类中心编号（第几个簇类）
% cl 的含义就是 i 点属于哪个类
% icl 记录的是 nclust 类的类中心点编号为 i
for i=1:N
    if ( (rho(i)>rhomin) && (delta(i)>deltamin))
        NCLUST=NCLUST+1;
        cl(i)=NCLUST;     % 第 i 号数据点属于第 NCLUST 个 cluster
        icl(NCLUST)=i;    % 逆映射，第 NCLUST 个 cluster 的中心为第 i 号数据点
    end
end

% 获取当前图形的颜色板
% 返回的是一个 64*3 的矩阵（缺省值情况）
cmap=colormap;
figure(fig_cluster);
for i=1:NCLUST
    % ic 为颜色设置
    % 选择 64 的某一行（也就是说只能绘制 64 个类不同颜色）
    ic=int8((i*64.)/(NCLUST*1.));
    %subplot(2,1,1)
    hold on
    plot(rho(icl(i)),delta(icl(i)),'o','MarkerSize',8,'MarkerFaceColor',cmap(ic,:),'MarkerEdgeColor',cmap(ic,:));
end
title(['Decision Graph, clusters : ',num2str(NCLUST)],'FontSize',15.0);
hold off

%assignation 
% 第一种类别赋值方法
% cl = Assign1(cl,rho,ordrho,nneigh);
% 第三种类别赋值方法
% cl = Assign3(cl,rho,ordrho,nneigh,delta);
% 第四种类别赋值方法
cl = Assign4(cl,rho,ordrho,nneigh,delta);
% 第五种类别赋值方法
% cl = Assign5(cl,rho,ordrho,nneigh,delta);
% 第二种类别赋值方法
cl = Assign2(cl,dist,icl);
 
t2 = toc;        % 第二次计时结束
time = t1 + t2;
end

