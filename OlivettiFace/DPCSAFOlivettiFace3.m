function [cl, icl]=DPCSAFOlivettiFace3(dist)
% 2017�� 9 �� 3 ��
% DPCSA ���� Olivetti Face ���ݼ�
% 1�����ڽض����м�Ȩ�ľֲ��ܶȼ���
% 2���������ֵ����

% dist �����������

% ����ֵ
% cl   �����������ر��
% icl  ���ĵ�����Ӧ�����ݱ��, icl(2) = k  ˵���� 2 ���ص����ĵ���Ϊ k

[N,~] = size(dist);       % ��������

% ����ֲ��ܶ�
rho = ObjectDensity9(dist);    % �ֲ��ܶȷ��� 
% �� rho �Ӵ�С����
% rho_sorted ������������
% ordrho ������� rho_sorted ������Ԫ���� rho �еı��
[~,ordrho]=sort(rho,'descend');

% delta �������е� \delta
delta = zeros(N,1);
% nneigh ���Ǿ�������ĵ�ı��
nneigh = zeros(N,1);

% ���� delta ֵ�Ĺ���
% �ҵ����Լ��ܶȴ�ĵ��о����Լ�����ĵ�
% ��¼������ nneigh �У���¼������ delta ��
for ii = 2:N
    [value, jj] =min(dist(ordrho(ii),ordrho(1:ii-1)));
    delta(ordrho(ii)) = value;
    nneigh(ordrho(ii)) = ordrho(jj);
end

% maxd Ϊ�ܶ����ֵ���������
% maxd=max(delta);
maxd=max(dist(ordrho(1),:));

% �ܶ����� delta Ϊ delta �����ֵ
delta(ordrho(1))=maxd;

gamma = rho.*delta;

[valg, ordg] = sort(gamma,'descend');
valg(1) = valg(2) + 0.01;

% ��һ����ͼ--����ͼ
fig_cluster = figure;
% ���� gamma �ݼ�ͼ������ȡͼ���� tt
% o ��ʾ������ɢ��
% MarkerSize ��ʶ����С
% MarkerFaceColor ��ʶ�������ɫ, k ��ʾ��ɫ
% MarkerEdgeColor ��ʶ����Ե��ɫ, k ��ʾ��ɫ
tt=plot(valg,'o','MarkerSize',2,'MarkerFaceColor','k','MarkerEdgeColor','k');
ylim([min(valg) valg(1)]);
xlabel ('n');
ylabel ('\gamma');

% �ڵ�һ��ͼ�л�ȡ��������
% rect һ���ĸ���ֵ
% �ֱ�Ϊ xmin ymin width height
rect = getrect(fig_cluster);
% x ��Ϊ rho, ����Ϊ��������� rho ��Сֵ
rhomin=rect(1);
gammamin=rect(2);
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
    if (gamma(i)>gammamin)
        NCLUST=NCLUST+1;
        cl(i)=NCLUST;     % �� i �����ݵ����ڵ� NCLUST �� cluster
        icl(NCLUST)=i;    % ��ӳ�䣬�� NCLUST �� cluster ������Ϊ�� i �����ݵ�
    end
end

% ��ȡ��ǰͼ�ε���ɫ��
% ���ص���һ�� 64*3 �ľ���ȱʡֵ�����
cmap=colormap;
for i=1:NCLUST
    % ic Ϊ��ɫ����
    % ѡ�� 64 ��ĳһ�У�Ҳ����˵ֻ�ܻ��� 64 ���಻ͬ��ɫ��
    ic=int8((i*64.)/(NCLUST*1.));
    hold on
    plot(i,valg(i),'o','MarkerSize',2,'MarkerFaceColor',cmap(ic,:),'MarkerEdgeColor',cmap(ic,:));
end
title(['Decision Graph, clusters : ',num2str(NCLUST)],'FontSize',15.0);
hold off

% 400 �����Ե��ܼ���ȡ 100 ������ƾ���ͼ
figure;
vn = 100;
vvalg = valg(1:vn);
plot(1:vn,vvalg,'o','MarkerSize',2,'MarkerFaceColor','k','MarkerEdgeColor','k');
ylim([min(vvalg),vvalg(1)]);
xlabel ('n');
ylabel ('\gamma');


%assignation 
cl = Assign4(cl,rho,ordrho,nneigh,delta);
cl = Assign2(cl,dist,icl);
 
end

