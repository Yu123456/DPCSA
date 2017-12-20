function [sdata,model]=libsvmscale(data,lower,upper)
% 实现 libsvm 中的归一化函数
% 归一化范围 ： [lower,upper]
% 所使用的规则： y=lower+（upper-lower）*(x-MinValue)/(MaxValue-MinValue)
% x、y为转换前、后的值，MaxValue、MinValue分别为样本每一列最大值和最小值

% 参数
%  data:  数据（一行一个样本）
%  lower: 归一化下限
%  upper: 归一化上限

% 返回参数
%   sdata: 归一化后的数据
%   model: 归一化模型中的参数，以便测试集可以直接进行归一化

cmax = max(data);   % 最大值
cmin = min(data);   % 最小值

[m,n]=size(data);   % 行数（样本个数） m，列数（样本维数）n
sdata = zeros(m,n);
for i = 1:n
    sdata(:,i) = lower + (upper-lower)*(data(:,i)-cmin(i))/(cmax(i)-cmin(i));
end

% 如果出现 NaN，可能某一列值全相同，则将其置为 lower
flag = isnan(sdata);
sdata(flag) = lower;

model.max = cmax;
model.min = cmin;
model.lower = lower;
model.upper = upper;

end

