% 2017 �� 8 �� 26 ��
% ���� FKNNDPC ��������ָ���� Clustering Accuracy(Acc), Adjust Rand Index, 
% Adjusted Mutual Information (AMI)

clear all
close all
clc
disp('DPCSA Clustering based on sequence running ...');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ��������ļ���
addpath('C:\Users\YU Donghua\Documents\MATLAB\Cluster\Data');    % add the data path

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Datasets

% % object name
% objName = 'dermatology.mat';
% % xx Ϊ���ݵ�����
% % ���ʽΪ�����ݵ� x ����   ���ݵ� y ����  �����
% datamat = load(objName);
% xx = datamat.attribute;
% xx = libsvmscale(xx,0,1);  % ���ݹ�һ��
% label = datamat.label;     % ʵ�ʴر�ǩ
% dist = pdist2(xx,xx);
% [ND, NL] = size(dist);  % ND = NL  ���ݼ���С

% % object name
% objName = 'Iris.mat';
% % xx Ϊ���ݵ�����
% % ���ʽΪ�����ݵ� x ����   ���ݵ� y ����  �����
% datamat = load(objName);
% xx = datamat.attribute;
% xx = libsvmscale(xx,0,1);  % ���ݹ�һ��
% label = datamat.label;     % ʵ�ʴر�ǩ
% dist = pdist2(xx,xx);
% [ND, NL] = size(dist);  % ND = NL  ���ݼ���С

% % object name
% objName = 'ionoshere32.mat';
% % xx Ϊ���ݵ�����
% % ���ʽΪ�����ݵ� x ����   ���ݵ� y ����  �����
% datamat = load(objName);
% xx = datamat.attribute;
% xx = libsvmscale(xx,0,1);  % ���ݹ�һ��
% label = datamat.label;     % ʵ�ʴر�ǩ
% dist = pdist2(xx,xx);
% [ND, NL] = size(dist);  % ND = NL  ���ݼ���С

% % object name
% objName = 'libras.mat';
% % xx Ϊ���ݵ�����
% % ���ʽΪ�����ݵ� x ����   ���ݵ� y ����  �����
% datamat = load(objName);
% xx = datamat.attribute;
% xx = libsvmscale(xx,0,1);  % ���ݹ�һ��
% label = datamat.label;     % ʵ�ʴر�ǩ
% dist = pdist2(xx,xx);
% [ND, NL] = size(dist);  % ND = NL  ���ݼ���С

% % object name
% objName = 'parkinsons.mat';
% % xx Ϊ���ݵ�����
% % ���ʽΪ�����ݵ� x ����   ���ݵ� y ����  �����
% datamat = load(objName);
% xx = datamat.attribute;
% xx = libsvmscale(xx,0,1);  % ���ݹ�һ��
% label = datamat.label;     % ʵ�ʴر�ǩ
% label = label+1;
% dist = pdist2(xx,xx);
% [ND, NL] = size(dist);  % ND = NL  ���ݼ���С

% % object name
% objName = 'pima.mat';
% % xx Ϊ���ݵ�����
% % ���ʽΪ�����ݵ� x ����   ���ݵ� y ����  �����
% datamat = load(objName);
% xx = datamat.attribute;
% xx = libsvmscale(xx,0,1);  % ���ݹ�һ��
% label = datamat.label;     % ʵ�ʴر�ǩ
% label = label + 1;
% dist = pdist2(xx,xx);
% [ND, NL] = size(dist);  % ND = NL  ���ݼ���С

% % object name
% objName = 'seeds.mat';
% % xx Ϊ���ݵ�����
% % ���ʽΪ�����ݵ� x ����   ���ݵ� y ����  �����
% datamat = load(objName);
% xx = datamat.attribute;
% xx = libsvmscale(xx,0,1);  % ���ݹ�һ��
% label = datamat.label;     % ʵ�ʴر�ǩ
% dist = pdist2(xx,xx);
% [ND, NL] = size(dist);  % ND = NL  ���ݼ���С

% % object name
% objName = 'segmentation210.mat';
% % xx Ϊ���ݵ�����
% % ���ʽΪ�����ݵ� x ����   ���ݵ� y ����  �����
% datamat = load(objName);
% xx = datamat.attribute;
% xx = libsvmscale(xx,0,1);  % ���ݹ�һ��
% label = datamat.label;     % ʵ�ʴر�ǩ
% dist = pdist2(xx,xx);
% [ND, NL] = size(dist);  % ND = NL  ���ݼ���С

% % object name
% objName = 'wdbc.mat';
% % xx Ϊ���ݵ�����
% % ���ʽΪ�����ݵ� x ����   ���ݵ� y ����  �����
% datamat = load(objName);
% xx = datamat.attribute;
% xx = libsvmscale(xx,0,1);  % ���ݹ�һ��
% label = datamat.label;     % ʵ�ʴر�ǩ
% dist = pdist2(xx,xx);
% [ND, NL] = size(dist);  % ND = NL  ���ݼ���С


% object name
objName = 'wine.mat';
% xx Ϊ���ݵ�����
% ���ʽΪ�����ݵ� x ����   ���ݵ� y ����  �����
datamat = load(objName);
xx = datamat.attribute;
xx = libsvmscale(xx,0,1);  % ���ݹ�һ��
label = datamat.label;     % ʵ�ʴر�ǩ
dist = pdist2(xx,xx);
[ND, NL] = size(dist);  % ND = NL  ���ݼ���С


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
disp(['data set : ',objName]);
% DPCSA ����
[cl,icl, time]=DPCSAF(dist);


% ���ֶ������۾���
Acc = ClusteringAccuracy(label,cl);
ARI = AdjustRandIndex(label,cl);
AMI = ami(label,cl);

% F/P ֵ
% F  ���ĵ������P �ҳ������ĵ�ʵ��λ�ڶ��ٸ�����
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