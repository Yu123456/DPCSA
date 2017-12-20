function rho = ObjectDensity9(dist)
% 2017 �� 8 �� 31 ��
% ��Ȩָ���ܶ�

% ���룺
% dist  �������

% �����
% rho  �ֲ��ܶ�

[N,~] = size(dist);
K = 5;
[ordd,~] = sort(dist,2,'ascend');
expd = exp(-ordd(:,2:end));      % ��ȥ��������ľ��� 0
rho = zeros(N,1);
% weight = 1./((K+1):(N-1)).^2;
weight = 1./(1:(N-K-1)).^2;
for i=1:N
    rho(i) = sum(expd(i,1:K)) + sum(expd(i,K+1:end).*weight);
%     rho(i) = sum(expd(i,1:K));
end


end

