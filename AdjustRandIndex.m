function ARI = AdjustRandIndex(RealLabel,PredictLabel)
% �������д��2016��12��8��
% ʵ�� Adjust Rand Index 
% �ο�ά���ٿ�
% �� NoteExpress �еıʼ�

% RealLabel ʵ�ʱ�ǩ
% PredictLabel Ԥ���ǩ

% ARI ���� Adjust Rand Index ֵ

n = length(RealLabel);      % ���ݼ���С
seq = 1:n;
Rlabel = unique(RealLabel);
KR = numel(Rlabel);      % ʵ�ʴظ���
Plabel = unique(PredictLabel);
KP = numel(Plabel);   % Ԥ��ظ���
% contingency table
CT = zeros(KR,KP);
for i=1:KR
    flagR = RealLabel == Rlabel(i);
    numR = seq(flagR);     % ���ڴ� i ���������/���
    for j=1:KP
        flagP = PredictLabel == Plabel(j);
        numP = seq(flagP);   % ���ڴ� j ���������/���
        % n_{ij} = | X_i \bigcap Y_i |
        CT(i,j) = numel(intersect(numR,numP));
    end
end
a = sum(CT,2);
b = sum(CT,1);
% ���������
aR = zeros(KR,1);
for i=1:KR
    aR(i) = a(i)*(a(i)-1)/2.0;
end
bP = zeros(KP,1);
for i=1:KP
    bP(i) = b(i)*(b(i)-1)/2.0;
end
nRP = zeros(KR,KP);
for i=1:KR
    for j=1:KP
        nRP(i,j) = CT(i,j)*(CT(i,j)-1)/2.0;
    end
end
saR = sum(aR);
sbP = sum(bP);
snRP = sum(sum(nRP));
nk2 = n*(n-1)/2.0;
ARI = (snRP-saR*sbP/nk2)/((saR+sbP)/2.0-(saR*sbP)/nk2);

end

