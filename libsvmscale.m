function [sdata,model]=libsvmscale(data,lower,upper)
% ʵ�� libsvm �еĹ�һ������
% ��һ����Χ �� [lower,upper]
% ��ʹ�õĹ��� y=lower+��upper-lower��*(x-MinValue)/(MaxValue-MinValue)
% x��yΪת��ǰ�����ֵ��MaxValue��MinValue�ֱ�Ϊ����ÿһ�����ֵ����Сֵ

% ����
%  data:  ���ݣ�һ��һ��������
%  lower: ��һ������
%  upper: ��һ������

% ���ز���
%   sdata: ��һ���������
%   model: ��һ��ģ���еĲ������Ա���Լ�����ֱ�ӽ��й�һ��

cmax = max(data);   % ���ֵ
cmin = min(data);   % ��Сֵ

[m,n]=size(data);   % ���������������� m������������ά����n
sdata = zeros(m,n);
for i = 1:n
    sdata(:,i) = lower + (upper-lower)*(data(:,i)-cmin(i))/(cmax(i)-cmin(i));
end

% ������� NaN������ĳһ��ֵȫ��ͬ��������Ϊ lower
flag = isnan(sdata);
sdata(flag) = lower;

model.max = cmax;
model.min = cmin;
model.lower = lower;
model.upper = upper;

end

