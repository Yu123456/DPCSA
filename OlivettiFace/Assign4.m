function ClassLabel = Assign4(classlabel,rho,ordrho,nneigh,delta)
% 本程序编写于 2017 年 8 月 30 日
% 以 DPC 的思想标记距离小于均值的点的类别标签

% 输入
% classlabel     已经进行部分聚类的类别标记（列向量），0 值表示未进行类别标记
% rho            密度序列
% ordrho         密度递减排序后的索引
% nneigh         最近点编号
% delta          密度大于自己的最近距离

% 输出
% ClassLabel   已标记类别标签

ClassLabel = classlabel;
n = length(rho);
boolDelta = delta < mean(delta) ;
for i=1:n
    % ClassLabel(i) 为 0 说明不是簇类中心
    % 那么这个数据的所属类别等于距离其最近并比其密度大的数据的类
    % 用 rho 的递减顺序，保证了赋值不会出现传递
    % 因为是从密度最大的点开始赋值的
    if ClassLabel(ordrho(i)) == 0 && boolDelta(ordrho(i))
        ClassLabel(ordrho(i)) = ClassLabel(nneigh(ordrho(i)));
    end
end

end

