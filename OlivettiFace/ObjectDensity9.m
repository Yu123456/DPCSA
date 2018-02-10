function rho = ObjectDensity9(dist)
% 2017 年 8 月 31 日
% 加权指数密度

% 输入：
% dist  距离矩阵

% 输出：
% rho  局部密度

[N,~] = size(dist);
K = 5;
[ordd,~] = sort(dist,2,'ascend');
expd = exp(-ordd(:,2:end));      % 除去自身到自身的距离 0
rho = zeros(N,1);
% weight = 1./((K+1):(N-1)).^2;
weight = 1./(1:(N-K-1)).^2;
for i=1:N
    rho(i) = sum(expd(i,1:K)) + sum(expd(i,K+1:end).*weight);
%     rho(i) = sum(expd(i,1:K));
end


end

