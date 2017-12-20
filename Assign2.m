function ClassLabel = Assign2(classlabel,dist,center)
% 本程序编写于 2017 年 8 月 24 日
% 以最近邻动态表的思想进行聚类

% 输入
% classlabel     已经进行部分聚类的类别标记（列向量），0 值表示未进行类别标记
% dist           距离矩阵
% center         中心点编号（对应 dist 中的编号）

% 输出
% ClassLabel   已标记类别标签

N = length(classlabel);  % 数据点个数
K = length(center);      % 簇个数，中心点个数
unassignBool = classlabel == 0;    % 未进行类别标记点的逻辑索引
M = sum(unassignBool);             % 未类别标记点个数
ClassLabel = classlabel;           % 返回标记类别
if M == 0
    % M 为 0 说明已经全部赋值
    return;
end
unSeq = zeros(M,1);

% 按行递增排序
% sdist   未标记点距离递增
% sord    未标记点按距离递增时在原序列中的索引，即在 1:M 中，可以从 unSeq 中
% 读取原始数据中的编号
[sdist, sord] =sort(dist(:,unassignBool),2,'ascend');

% 最近邻动态表初始大小
ND = round( N/K ) * 2;
% 已经标记类别点的编号
AssignedNumber = zeros(K,ND);
% 已标记类别点的最近邻点编号，对应 dist(:,unassignBool') 中的编号，如果需要原始
% 编号，从 unSeq 中读取
AssignedNearest = zeros(K,ND);
% 该点到最近邻点（未标记类别的点）的距离
NearestDist = zeros(K,ND);
% 已经处理到最近邻索引，对应着 sord 
% 对于未标记类别的点，sdist 中第一个值是到自身的距离，其值为 0
% 对于已标记点，sdist 中的第一个点不为 0
flagSord = zeros(N,1);
% 每一个类别已经标记点个数
ClusterNumber = zeros(K,1);
% 每个类的最近邻点编号（对应 AssignedNumber 中的索引编号）
MinIndex = zeros(K,1) ;
% 每个类的最近邻距离
dconst = max(max(sdist)) + 1.0;
MinDist = zeros(K,1) + dconst; % 加 1 是为了确保第一次赋值一定可以执行;

% 初始化最近邻动态表
k = 0;
for i=1:N
    if unassignBool(i)
        % 该点未标记类别
        k = k+1;
        unSeq(k) = i;          % unSeq 中的第 k 个索引对应值为原始数据中的第 i 个编号点
        % 该点最近邻应从 sord 中的第 2 个索引开始
        flagSord(i) = 2;
    else
        % 该点已经归类，
        label = ClassLabel(i);
        flagSord(i) = 1;          % 最近邻从 sord 中的第 1 个索引开始
        ClusterNumber(label) = ClusterNumber(label) + 1;  % label 这个类聚类点数加 1
        AssignedNumber(label,ClusterNumber(label)) = i;   % 已标记类别点的编号
        % 该点的最近邻点编号，对应 dist(:,unassignBool') 中的编号，可以从 unSeq 
        % 获取原始数据编号，对应 dist 矩阵
        AssignedNearest(label,ClusterNumber(label)) = sord(i,flagSord(i)); 
        % 该点的最近邻距离
        NearestDist(label,ClusterNumber(label)) = sdist(i,flagSord(i));
        if sdist(i,flagSord(i)) < MinDist(label)
            MinDist(label) = sdist(i,flagSord(i));
            MinIndex(label) = ClusterNumber(label);
        end
    end
end

% 对于未标记类别的点逐一标记类别
for i=1:M-1
    % 下一个标记类别的点为 P
    [~,label] = min(MinDist);   % label 是最小值索引，同时也是最小距离所在类的编号,
                                % 即下一个待标记点的类别编号为 label
    Pind = unSeq(AssignedNearest(label,MinIndex(label)));      % 待标记点编号为 Pind, 对应原始数据编号
%     disp(['编号：',num2str(Pind),' 赋值前：',num2str(ClassLabel(Pind)),' , 赋值后：',num2str(label)]);
    ClassLabel(Pind) = label;   % 标记 Pind 点的类别为 label
    ClusterNumber(label) = ClusterNumber(label) + 1;   % 已标记点加 1
    AssignedNumber(label, ClusterNumber(label)) = Pind;  % 已标记点类别编号
    % 编号 Pind 点的最近邻点编号，对应 dist(:,unassignBool') 中的编号
    % 找到最近邻未标记类别的点
    bool = 1;
    while bool
        nn = sord(Pind,flagSord(Pind));     % 当前最近邻
        % 检查当前最近邻是否已经标记类别
        if ClassLabel(unSeq(nn)) == 0
            % 没有标记类别标签，可以最为最近邻
            bool = 0;
            AssignedNearest(label,ClusterNumber(label)) = nn;
        else
            % 当前点已经标记类别，最近邻下移一个
            flagSord(Pind) = flagSord(Pind) + 1;
        end
    end
    % 编号 Pind 点的最近邻距离
    NearestDist(label, ClusterNumber(label)) = sdist(Pind, flagSord(Pind));
    
    % 更新最近邻动态表
    for k=1:K
        % 更新第 k 个簇，同时更新每个类的最近邻及其距离
        % 重新初始化
        MinDist(k) = dconst;
        MinIndex(k) = 0;
        for j=1:ClusterNumber(k)
            % 如果第 k 个簇中的第 j 个点的最近邻恰好是编号为 Pind 的点，则更新其最近邻
            % 否则，不更新
            flag = AssignedNearest(k,j);  % 对应 dist(:,unassignBool') 中的编号
            if unSeq(flag) == Pind
                % AssignedNumber(k,j) 点需要更新最近邻
                kjNum = AssignedNumber(k,j);
                % 先找出下一个最近邻且未标记类别的点
                bool = 1;
                while bool
                    flagSord(kjNum) = flagSord(kjNum) + 1;    % 最近邻移向下一个
                    nn = sord(kjNum,flagSord(kjNum));    % 最近邻索引值，对应 dist(:,unassignBool') 中的编号
                    if ClassLabel(unSeq(nn)) == 0
                        % 如果编号 num 的点类标记为 0， 说明未标记类别
                        bool = 0;     % 退出 while 循环，停止最近邻向下移动
                        AssignedNearest(k,j) = nn;   % 更新最近邻
                        % 更新最近邻距离
                        NearestDist(k,j) = sdist(kjNum,flagSord(kjNum)); 
                    end
                end
            end
            % 此时第 j 个点最近邻已经更新完毕
            % 第 j 个点是否可以作为新的类的最近邻
            if NearestDist(k,j) < MinDist(k)
                MinDist(k) = NearestDist(k,j);
                MinIndex(k) = j;
            end
        end
    end
end

% 处理最后一个点的类别标记，即编号为 M 的未标记类别点
[~,label] = min(MinDist);   % label 是最小值索引，同时也是最小距离所在类的编号,
                                % 即下一个待标记点的类别编号为 label
Pind = unSeq(AssignedNearest(label,MinIndex(label)));      % 待标记点编号为 Pind, 对应原始数据编号
    
ClassLabel(Pind) = label;   % 标记 Pind 点的类别为 label

end

