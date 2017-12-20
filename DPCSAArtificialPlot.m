% 2017 �� 9 �� 4 ��
% �˹��ϳ����ݼ�
% ���� FKNNDPC ��������ָ���� Adjust Rand Index, 
% Adjusted Mutual Information (AMI)

% ���ƶ�άͼ

clear all
close all
clc
disp('DPCSA Clustering based on sequence running ...');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ��������ļ���
addpath('C:\Users\YU Donghua\Documents\MATLAB\Cluster\Data');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% �������ݼ��� DPCSA �в��õ��˹����ݼ�

% object name
objName = 'Aggregation.mat';
% xx Ϊ���ݵ�����
% ���ʽΪ�����ݵ� x ����   ���ݵ� y ����  �����
datamat = load(objName);
xx = datamat.attribute;
xx = libsvmscale(xx,0,1);  % ���ݹ�һ��
label = datamat.label;     % ʵ�ʴر�ǩ
dist = pdist2(xx,xx);
[ND, NL] = size(dist);  % ND = NL  ���ݼ���С

% % object name
% objName = 'D31.mat';
% % xx Ϊ���ݵ�����
% % ���ʽΪ�����ݵ� x ����   ���ݵ� y ����  �����
% datamat = load(objName);
% xx = datamat.attribute;
% xx = libsvmscale(xx,0,1);  % ���ݹ�һ��
% label = datamat.label;     % ʵ�ʴر�ǩ
% dist = pdist2(xx,xx);
% [ND, NL] = size(dist);  % ND = NL  ���ݼ���С

% % object name
% objName = 'dim512.mat';
% % xx Ϊ���ݵ�����
% % ���ʽΪ�����ݵ� x ����   ���ݵ� y ����  �����
% datamat = load(objName);
% xx = datamat.attribute;
% xx = libsvmscale(xx,0,1);  % ���ݹ�һ��
% label = datamat.label;     % ʵ�ʴر�ǩ
% dist = pdist2(xx,xx);
% [ND, NL] = size(dist);  % ND = NL  ���ݼ���С

% % object name
% objName = 'dim1024.mat';
% % xx Ϊ���ݵ�����
% % ���ʽΪ�����ݵ� x ����   ���ݵ� y ����  �����
% datamat = load(objName);
% xx = datamat.attribute;
% xx = libsvmscale(xx,0,1);  % ���ݹ�һ��
% label = datamat.label;     % ʵ�ʴر�ǩ
% dist = pdist2(xx,xx);
% [ND, NL] = size(dist);  % ND = NL  ���ݼ���С

% % object name
% objName = 'flame.mat';
% % xx Ϊ���ݵ�����
% % ���ʽΪ�����ݵ� x ����   ���ݵ� y ����  �����
% datamat = load(objName);
% xx = datamat.attribute;
% xx = libsvmscale(xx,0,1);  % ���ݹ�һ��
% label = datamat.label;     % ʵ�ʴر�ǩ
% dist = pdist2(xx,xx);
% [ND, NL] = size(dist);  % ND = NL  ���ݼ���С

% % object name
% objName = 'pathbased1.mat';
% % xx Ϊ���ݵ�����
% % ���ʽΪ�����ݵ� x ����   ���ݵ� y ����  �����
% datamat = load(objName);
% xx = datamat.attribute;
% xx = libsvmscale(xx,0,1);  % ���ݹ�һ��
% label = datamat.label;     % ʵ�ʴر�ǩ
% dist = pdist2(xx,xx);
% [ND, NL] = size(dist);  % ND = NL  ���ݼ���С

% % object name
% objName = 'newpathbased1.mat';
% % xx Ϊ���ݵ�����
% % ���ʽΪ�����ݵ� x ����   ���ݵ� y ����  �����
% datamat = load(objName);
% xx = datamat.attribute;
% xx = libsvmscale(xx,0,1);  % ���ݹ�һ��
% label = datamat.label;     % ʵ�ʴر�ǩ
% dist = pdist2(xx,xx);
% [ND, NL] = size(dist);  % ND = NL  ���ݼ���С

% % object name
% objName = 'spiral.mat';
% % xx Ϊ���ݵ�����
% % ���ʽΪ�����ݵ� x ����   ���ݵ� y ����  �����
% datamat = load(objName);
% xx = datamat.attribute;
% xx = libsvmscale(xx,0,1);  % ���ݹ�һ��
% label = datamat.label;     % ʵ�ʴر�ǩ
% dist = pdist2(xx,xx);
% [ND, NL] = size(dist);  % ND = NL  ���ݼ���С


% % object name
% objName = 's1.mat';
% % xx Ϊ���ݵ�����
% % ���ʽΪ�����ݵ� x ����   ���ݵ� y ����  �����
% datamat = load(objName);
% xx = datamat.attribute;
% xx = libsvmscale(xx,0,1);  % ���ݹ�һ��
% label = datamat.label;     % ʵ�ʴر�ǩ
% dist = pdist2(xx,xx);
% [ND, NL] = size(dist);  % ND = NL  ���ݼ���С

% % object name
% objName = 's2.mat';
% % xx Ϊ���ݵ�����
% % ���ʽΪ�����ݵ� x ����   ���ݵ� y ����  �����
% datamat = load(objName);
% xx = datamat.attribute;
% xx = libsvmscale(xx,0,1);  % ���ݹ�һ��
% label = datamat.label;     % ʵ�ʴر�ǩ
% dist = pdist2(xx,xx);
% [ND, NL] = size(dist);  % ND = NL  ���ݼ���С

% % object name
% objName = 's3.mat';
% % xx Ϊ���ݵ�����
% % ���ʽΪ�����ݵ� x ����   ���ݵ� y ����  �����
% datamat = load(objName);
% xx = datamat.attribute;
% xx = libsvmscale(xx,0,1);  % ���ݹ�һ��
% label = datamat.label;     % ʵ�ʴر�ǩ
% dist = pdist2(xx,xx);
% [ND, NL] = size(dist);  % ND = NL  ���ݼ���С

% % object name
% objName = 's4.mat';
% % xx Ϊ���ݵ�����
% % ���ʽΪ�����ݵ� x ����   ���ݵ� y ����  �����
% datamat = load(objName);
% xx = datamat.attribute;
% xx = libsvmscale(xx,0,1);  % ���ݹ�һ��
% label = datamat.label;     % ʵ�ʴر�ǩ
% dist = pdist2(xx,xx);
% [ND, NL] = size(dist);  % ND = NL  ���ݼ���С





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
disp(['                   AMI : ',num2str(AMI)]);
disp(['                     F : ',num2str(F)]);
disp(['                     P : ',num2str(P)]);
disp(['clustering running time: ',num2str(time),' s']);


eval =[Acc, ARI, AMI, F, P, time];


% ���ƾ���ͼ
if length(xx(1,:)) == 2
    % ����� 2 ά���ݣ���ֱ�ӻ�������ͼ
    % Ĭ��Ϊ�� 1 ��Ϊ x ���꣬�� 2 ��Ϊ y ����
    Y1 = xx;
    % ���������еĵ�
    % ȫ���Ǻ�ɫ�ĵ㣬֮����ȥ��ɫ
    figure;    
    
    plot(Y1(:,1),Y1(:,2),'o','MarkerSize',2,'MarkerFaceColor','k','MarkerEdgeColor','k');
    title (['2D directly plot, clusters : ',num2str(length(icl))],'FontSize',15.0);
    xlabel ('X');
    ylabel ('Y');
    
    
    NCLUST = length(icl);         % �ظ���
    % ��ȡ��ǰͼ�ε���ɫ��
    % ���ص���һ�� 64*3 �ľ���ȱʡֵ�����
    cmap=colormap;
    for i=1:NCLUST
        % ���ƴ�
        % �ø������ɫ����
        nn= cl==i;
        % ����ÿ������ȷ��һ����ɫ���� ic
        % Ҳ���� cmap ��ĳһ��
        ic=int8((i*64.)/(NCLUST*1.));
        Ax = Y1(nn,1);
        Ay = Y1(nn,2);
        hold on
        plot(Ax,Ay,'o','MarkerSize',2,'MarkerFaceColor',cmap(ic,:),'MarkerEdgeColor',cmap(ic,:));
        % �������ĵ�
        plot(Y1(icl(i),1),Y1(icl(i),2),'s','MarkerSize',10,'MarkerFaceColor',cmap(ic,:),'MarkerEdgeColor',cmap(ic,:));
    end
    hold off
else
    % ������� 2 ά���ݣ�����Ҫ���з������߶ȱ仯
    % mdscale �Ƿ������߶ȱ仯�� Non-metric Multi-Dimensional Scaling��
    % mdscale ֱ��չ�����ݲ����ͨ����ά�����ָ�ά����
    % ʹ�� mdscale ����ִ�зǾ����ά�ȳ߶ȱ任����Ҫָ������ά�����ؽ�������õ�
    % ������mdscale �ĵڶ��������һ������������õ�ֵ����������������õľ�����
    % ԭʼ��������Ե��Ǻϳ̶�
    Y1 = mdscale(dist, 2, 'criterion','metricstress');
    
    % ���������еĵ�
    % ȫ���Ǻ�ɫ�ĵ㣬֮����ȥ��ɫ
    figure;
    plot(Y1(:,1),Y1(:,2),'o','MarkerSize',2,'MarkerFaceColor','k','MarkerEdgeColor','k');
    title (['2D Nonclassical multidimensional scaling, clusters : ',num2str(length(icl))],'FontSize',15.0);
    xlabel ('X');
    ylabel ('Y');
    
    NCLUST = length(icl);         % �ظ���
    % ��ȡ��ǰͼ�ε���ɫ��
    % ���ص���һ�� 64*3 �ľ���ȱʡֵ�����
    cmap=colormap;
    for i=1:NCLUST
        % ���ƴ�
        % �ø������ɫ����
        nn= cl==i;
        % ����ÿ������ȷ��һ����ɫ���� ic
        % Ҳ���� cmap ��ĳһ��
        ic=int8((i*64.)/(NCLUST*1.));
        Ax = Y1(nn,1);
        Ay = Y1(nn,2);
        hold on
        plot(Ax,Ay,'o','MarkerSize',2,'MarkerFaceColor',cmap(ic,:),'MarkerEdgeColor',cmap(ic,:));
        % �������ĵ�
        plot(Y1(icl(i),1),Y1(icl(i),2),'s','MarkerSize',10,'MarkerFaceColor',cmap(ic,:),'MarkerEdgeColor',cmap(ic,:));
    end
    hold off
end


disp('running over!');