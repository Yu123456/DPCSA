function [cl, icl, time]=DPCSAF(dist)
% 2017�� 8 �� 25 ��
% DPCSA ����
% 1�����ڽض����м�Ȩ�ľֲ��ܶȼ���
% 2���������ֵ����

% dist �����������

% ����ֵ
% cl   �����������ر��
% icl  ���ĵ�����Ӧ�����ݱ��, icl(2) = k  ˵���� 2 ���ص����ĵ���Ϊ k
% time  ����ʱ��

tic;     % ��һ�μ�ʱ��ʼ

[N,~] = size(dist);       % ��������

% ����ֲ��ܶ�
% rho = ObjectDensity3(dist);    % �ֲ��ܶȷ��� 3
% rho = ObjectDensity5(dist);    % �ֲ��ܶȷ��� 5
% rho = ObjectDensity6(dist);    % �ֲ��ܶȷ��� 6
% rho = ObjectDensity7(dist);    % �ֲ��ܶȷ��� 7
% rho = ObjectDensity8(dist);    % �ֲ��ܶȷ��� 8
rho = ObjectDensity9(dist);    % �ֲ��ܶȷ��� 9
% rho = ObjectDensity10(dist);    % �ֲ��ܶȷ��� 10
% rho = libsvmscale(rho,0,1);      % �ܶȹ�һ��
% �� rho �Ӵ�С����
% rho_sorted ������������
% ordrho ������� rho_sorted ������Ԫ���� rho �еı��
[~,ordrho]=sort(rho,'descend');
% maxd Ϊ�ܶ����ֵ���������
maxd=max(dist(ordrho(1),:));
% delta �������е� \delta
% ����õġ��ضϡ���
% rho ΪС�ڽضϾ�����ھ�����Ҳ�����ܶ�
% ��ˣ������ܶ����ĵ������� delta Ϊ -1
% ���������ܶȵ�� delta ֵΪ��С�ľ���ֵ
delta = zeros(N,1);
% delta(ordrho(1))=-1.;
% nneigh ���Ǿ�������ĵ�ı��
nneigh = zeros(N,1);
% nneigh(ordrho(1))=0;

% ���� delta ֵ�Ĺ���
% �ҵ����Լ��ܶȴ�ĵ��о����Լ�����ĵ�
% ��¼������ nneigh �У���¼������ delta ��
for ii = 2:N
    [value, jj] =min(dist(ordrho(ii),ordrho(1:ii-1)));
    delta(ordrho(ii)) = value;
    nneigh(ordrho(ii)) = ordrho(jj);
end

% �ܶ����� delta Ϊ delta �����ֵ��
% �����ж���Ϊ�ܶ����ĵ�� delta Ϊ������Զ��֮��ľ���
% ��Ϊ�ܶ����ĵ���֮��Զ�ľ���ĵ�϶����ڵ��� delta �����ֵ
% ���������˼���������� max ����������������Ļ���������㸴�Ӷ���ͬ��
% delta(ordrho(1))=max(delta(:));
delta(ordrho(1))=maxd;
% ��һ������
% deltaMin = min(delta);
% delta = (delta-deltaMin)/(maxd-deltaMin);

% ��һ����ͼ--����ͼ
fig_cluster = figure;
% ���� rho, delta ͼ������ȡͼ���� tt
% o ��ʾ������ɢ��
% MarkerSize ��ʶ����С
% MarkerFaceColor ��ʶ�������ɫ, k ��ʾ��ɫ
% MarkerEdgeColor ��ʶ����Ե��ɫ, k ��ʾ��ɫ
tt=plot(rho(:),delta(:),'o','MarkerSize',5,'MarkerFaceColor','k','MarkerEdgeColor','k');
xlabel ('\rho');
ylabel ('\delta');

t1 = toc;      % ��һ�μ�ʱ����

% �ڵ�һ��ͼ�л�ȡ��������
% rect һ���ĸ���ֵ
% �ֱ�Ϊ xmin ymin width height
rect = getrect(fig_cluster);

tic;        % �ڶ��μ�ʱ��ʼ

% x ��Ϊ rho, ����Ϊ��������� rho ��Сֵ
rhomin=rect(1);
% ���ĸ�����Ϊ�߶�
% ���������ڴ��������Ѿ���ʾ���Ǹ�����
% �������˸����Ĵ���
% deltamin = rect(4) �޸�Ϊ deltamin = rect(2)
deltamin=rect(2);
% ��������
NCLUST=0;
% ��ʼ�� cl ����Ϊ 0
% cl Ϊ������־���飬cl(i) = j ��ʾ�� i �����ݵ�����ڵ� j �� cluster
cl = zeros(1,N);
% ͳ�����ݵ� rho �� delta ֵ��������Сֵ�ĵ�
% Ҳ����Ȧ���ο򣬰Ѿ��ε���߽���±߽���Ϊ��һ���ָ�߽�
% �ҵ�����Ҫ��ĵ�
% �ҵ�һ����˵���ҵ�һ����������
% �� cl(i) ��ֵ���Ǵ������ı�ţ��ڼ������ࣩ
% cl �ĺ������ i �������ĸ���
% icl ��¼���� nclust ��������ĵ���Ϊ i
for i=1:N
    if ( (rho(i)>rhomin) && (delta(i)>deltamin))
        NCLUST=NCLUST+1;
        cl(i)=NCLUST;     % �� i �����ݵ����ڵ� NCLUST �� cluster
        icl(NCLUST)=i;    % ��ӳ�䣬�� NCLUST �� cluster ������Ϊ�� i �����ݵ�
    end
end

% ��ȡ��ǰͼ�ε���ɫ��
% ���ص���һ�� 64*3 �ľ���ȱʡֵ�����
cmap=colormap;
figure(fig_cluster);
for i=1:NCLUST
    % ic Ϊ��ɫ����
    % ѡ�� 64 ��ĳһ�У�Ҳ����˵ֻ�ܻ��� 64 ���಻ͬ��ɫ��
    ic=int8((i*64.)/(NCLUST*1.));
    %subplot(2,1,1)
    hold on
    plot(rho(icl(i)),delta(icl(i)),'o','MarkerSize',8,'MarkerFaceColor',cmap(ic,:),'MarkerEdgeColor',cmap(ic,:));
end
title(['Decision Graph, clusters : ',num2str(NCLUST)],'FontSize',15.0);
hold off

%assignation 
% ��һ�����ֵ����
% cl = Assign1(cl,rho,ordrho,nneigh);
% ���������ֵ����
% cl = Assign3(cl,rho,ordrho,nneigh,delta);
% ���������ֵ����
cl = Assign4(cl,rho,ordrho,nneigh,delta);
% ���������ֵ����
% cl = Assign5(cl,rho,ordrho,nneigh,delta);
% �ڶ������ֵ����
cl = Assign2(cl,dist,icl);
 
t2 = toc;        % �ڶ��μ�ʱ����
time = t1 + t2;
end

