function PlotFace2(datamat,icl, cl)
% 2017 �� 9 �� 2 ��
% Olivetti Face ����������ͼ
% �� tightPlots ���ƶ����ͼ���������

% ����
% datamat   Face ���ݼ��� mat �ļ�
% icl       �������ĵ���
% cl        ����ǩ

n = 20;     % ���Ƴ� 20*20 ����ͼ��ʽ
K = length(icl);

figure;
Nh = n;
Nw = n;
w = 10;
AR = [92 112];
gap = [0 0.01];
marg_h = [0.05 0.05];
marg_w = [0.05 0.05];
units = 'centimeters';
ha = tightPlots(Nh, Nw, w, AR, gap, marg_h, marg_w, units);
cmap = colormap;    % ��ɫ��
for i=1:n
    for j=1:n
        % ����� (i,j) ��ͼ
        k = (i-1)*n + j;        % ����� k ��ͼ
        % ͼ���е����� ii,jjj
        [ii,jj] = NumberFace(i,j);
        
        if cl(k) == 0
            % δ��������ǣ�ֱ�ӻ����� subplot(n,n,k)
            axes(ha(k));
            imshow(datamat.faceData{ii,jj});
        elseif ismember(k,icl)
            % ��������ĵ�
            nk = cl(k);        % ���ǩ������ nk ����
            ic = int8((nk*64.0)/(K*1.0));
            ima =gray2color(datamat.faceData{ii,jj},cmap(ic,:));  % ת�ɱ�����ɫ
            ima = AddWhite(ima);     % �������ĵ��־����ɫ������
            axes(ha(k));
            imshow(ima);
        else
            % �Ѿ��������ţ����������ĵ�
            nk = cl(k);        % ���ǩ������ nk ����
            ic = int8((nk*64.0)/(K*1.0));
            ima =gray2color(datamat.faceData{ii,jj},cmap(ic,:));  % ת�ɱ�����ɫ
            axes(ha(k));
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