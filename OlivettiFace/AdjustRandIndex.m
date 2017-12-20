function ARI = AdjustRandIndex(RealLabel,PredictLabel)
% 本程序编写于2016年12月8日
% 实现 Adjust Rand Index 
% 参考维基百科
% 或 NoteExpress 中的笔记

% RealLabel 实际标签
% PredictLabel 预测标签

% ARI 返回 Adjust Rand Index 值

n = length(RealLabel);      % 数据集大小
seq = 1:n;
Rlabel = unique(RealLabel);
KR = numel(Rlabel);      % 实际簇个数
Plabel = unique(PredictLabel);
KP = numel(Plabel);   % 预测簇个数
% contingency table
CT = zeros(KR,KP);
for i=1:KR
    flagR = RealLabel == Rlabel(i);
    numR = seq(flagR);     % 属于簇 i 的样本编号/序号
    for j=1:KP
        flagP = PredictLabel == Plabel(j);
        numP = seq(flagP);   % 属于簇 j 的样本编号/序号
        % n_{ij} = | X_i \bigcap Y_i |
        CT(i,j) = numel(intersect(numR,numP));
    end
end
a = sum(CT,2);
b = sum(CT,1);
% 计算组合数
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

