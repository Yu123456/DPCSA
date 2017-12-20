% 2017 �� 8 �� 26 ��
% ���� FKNNDPC ��������ָ���� Clustering Accuracy(Acc), Adjust Rand Index, 
% Adjusted Mutual Information (AMI)

clear all
close all
clc
disp('DPCSA Clustering based on sequence running ...');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ��������ļ���
addpath('C:\Users\YU Donghua\Documents\MATLAB\Cluster\Data');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ���ݼ��� Olivetti Face

% object name
objName = 'OlivettiFace.mat';
datamat = load(objName);
xx = datamat.faceDataPCA;
xx = libsvmscale(xx,0,1);  % ���ݹ�һ��
label = datamat.labelPCA;     % ʵ�ʴر�ǩ
dist = pdist2(xx,xx);
[ND, NL] = size(dist);  % ND = NL  ���ݼ���С





%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
disp(['data set : ',objName]);
% DPCSA ����
[cl,icl]=DPCSAFOlivettiFace3(dist);


% ���ֶ������۾���
Acc = ClusteringAccuracy(label,cl);
ARI = AdjustRandIndex(label,cl);
AMI = ami(label,cl);

% F/P ֵ
% F  ���ĵ������P �ҳ������ĵ�ʵ��λ�ڶ��ٸ�����
iclabel = label(icl);
F = length(icl);
P = length(unique(iclabel));


disp(['             Acc  : ',num2str(Acc)]);
disp(['Adjust Rand index : ',num2str(ARI)]);
disp(['             AMI  : ',num2str(AMI)]);
disp(['                F : ',num2str(F)]);
disp(['                P : ',num2str(P)]);


% ���ƾ�����
PlotFace2(datamat,icl, cl);

% ���������
save('OlivettiFaceResult.mat','cl','icl');

disp('running over!');