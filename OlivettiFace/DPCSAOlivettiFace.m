% 2017 年 8 月 26 日
% 计算 FKNNDPC 聚类评价指数， Clustering Accuracy(Acc), Adjust Rand Index, 
% Adjusted Mutual Information (AMI)

clear all
close all
clc
disp('DPCSA Clustering based on sequence running ...');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 添加数据文件夹
addpath('C:\Users\YU Donghua\Documents\MATLAB\Cluster\Data');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 数据集是 Olivetti Face

% object name
objName = 'OlivettiFace.mat';
datamat = load(objName);
xx = datamat.faceDataPCA;
xx = libsvmscale(xx,0,1);  % 数据归一化
label = datamat.labelPCA;     % 实际簇标签
dist = pdist2(xx,xx);
[ND, NL] = size(dist);  % ND = NL  数据集大小





%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
disp(['data set : ',objName]);
% DPCSA 聚类
[cl,icl]=DPCSAFOlivettiFace3(dist);


% 三种度量评价聚类
Acc = ClusteringAccuracy(label,cl);
ARI = AdjustRandIndex(label,cl);
AMI = ami(label,cl);

% F/P 值
% F  中心点个数，P 找出的中心点实际位于多少个簇内
iclabel = label(icl);
F = length(icl);
P = length(unique(iclabel));


disp(['             Acc  : ',num2str(Acc)]);
disp(['Adjust Rand index : ',num2str(ARI)]);
disp(['             AMI  : ',num2str(AMI)]);
disp(['                F : ',num2str(F)]);
disp(['                P : ',num2str(P)]);


% 绘制聚类结果
PlotFace2(datamat,icl, cl);

% 保存聚类结果
save('OlivettiFaceResult.mat','cl','icl');

disp('running over!');