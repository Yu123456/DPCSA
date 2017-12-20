% 2017 年 8 月 26 日
% 计算 FKNNDPC 聚类评价指数， Clustering Accuracy(Acc), Adjust Rand Index, 
% Adjusted Mutual Information (AMI)

clear all
close all
clc
disp('DPCSA Clustering based on sequence running ...');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 添加数据文件夹
addpath('C:\Users\YU Donghua\Documents\MATLAB\Cluster\Data');    % add the data path

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Datasets

% % object name
% objName = 'dermatology.mat';
% % xx 为数据点坐标
% % 其格式为：数据点 x 坐标   数据点 y 坐标  类别标号
% datamat = load(objName);
% xx = datamat.attribute;
% xx = libsvmscale(xx,0,1);  % 数据归一化
% label = datamat.label;     % 实际簇标签
% dist = pdist2(xx,xx);
% [ND, NL] = size(dist);  % ND = NL  数据集大小

% % object name
% objName = 'Iris.mat';
% % xx 为数据点坐标
% % 其格式为：数据点 x 坐标   数据点 y 坐标  类别标号
% datamat = load(objName);
% xx = datamat.attribute;
% xx = libsvmscale(xx,0,1);  % 数据归一化
% label = datamat.label;     % 实际簇标签
% dist = pdist2(xx,xx);
% [ND, NL] = size(dist);  % ND = NL  数据集大小

% % object name
% objName = 'ionoshere32.mat';
% % xx 为数据点坐标
% % 其格式为：数据点 x 坐标   数据点 y 坐标  类别标号
% datamat = load(objName);
% xx = datamat.attribute;
% xx = libsvmscale(xx,0,1);  % 数据归一化
% label = datamat.label;     % 实际簇标签
% dist = pdist2(xx,xx);
% [ND, NL] = size(dist);  % ND = NL  数据集大小

% % object name
% objName = 'libras.mat';
% % xx 为数据点坐标
% % 其格式为：数据点 x 坐标   数据点 y 坐标  类别标号
% datamat = load(objName);
% xx = datamat.attribute;
% xx = libsvmscale(xx,0,1);  % 数据归一化
% label = datamat.label;     % 实际簇标签
% dist = pdist2(xx,xx);
% [ND, NL] = size(dist);  % ND = NL  数据集大小

% % object name
% objName = 'parkinsons.mat';
% % xx 为数据点坐标
% % 其格式为：数据点 x 坐标   数据点 y 坐标  类别标号
% datamat = load(objName);
% xx = datamat.attribute;
% xx = libsvmscale(xx,0,1);  % 数据归一化
% label = datamat.label;     % 实际簇标签
% label = label+1;
% dist = pdist2(xx,xx);
% [ND, NL] = size(dist);  % ND = NL  数据集大小

% % object name
% objName = 'pima.mat';
% % xx 为数据点坐标
% % 其格式为：数据点 x 坐标   数据点 y 坐标  类别标号
% datamat = load(objName);
% xx = datamat.attribute;
% xx = libsvmscale(xx,0,1);  % 数据归一化
% label = datamat.label;     % 实际簇标签
% label = label + 1;
% dist = pdist2(xx,xx);
% [ND, NL] = size(dist);  % ND = NL  数据集大小

% % object name
% objName = 'seeds.mat';
% % xx 为数据点坐标
% % 其格式为：数据点 x 坐标   数据点 y 坐标  类别标号
% datamat = load(objName);
% xx = datamat.attribute;
% xx = libsvmscale(xx,0,1);  % 数据归一化
% label = datamat.label;     % 实际簇标签
% dist = pdist2(xx,xx);
% [ND, NL] = size(dist);  % ND = NL  数据集大小

% % object name
% objName = 'segmentation210.mat';
% % xx 为数据点坐标
% % 其格式为：数据点 x 坐标   数据点 y 坐标  类别标号
% datamat = load(objName);
% xx = datamat.attribute;
% xx = libsvmscale(xx,0,1);  % 数据归一化
% label = datamat.label;     % 实际簇标签
% dist = pdist2(xx,xx);
% [ND, NL] = size(dist);  % ND = NL  数据集大小

% % object name
% objName = 'wdbc.mat';
% % xx 为数据点坐标
% % 其格式为：数据点 x 坐标   数据点 y 坐标  类别标号
% datamat = load(objName);
% xx = datamat.attribute;
% xx = libsvmscale(xx,0,1);  % 数据归一化
% label = datamat.label;     % 实际簇标签
% dist = pdist2(xx,xx);
% [ND, NL] = size(dist);  % ND = NL  数据集大小


% object name
objName = 'wine.mat';
% xx 为数据点坐标
% 其格式为：数据点 x 坐标   数据点 y 坐标  类别标号
datamat = load(objName);
xx = datamat.attribute;
xx = libsvmscale(xx,0,1);  % 数据归一化
label = datamat.label;     % 实际簇标签
dist = pdist2(xx,xx);
[ND, NL] = size(dist);  % ND = NL  数据集大小


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
disp(['                  AMI  : ',num2str(AMI)]);
disp(['                     F : ',num2str(F)]);
disp(['                     P : ',num2str(P)]);
disp(['clustering running time: ',num2str(time),' s']);

eval =[Acc, ARI, AMI, F, P, time];


disp('running over!');