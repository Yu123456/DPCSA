function wcim = AddWhite(cim)
% 2017 �� 9 �� 2 ��
% ����ɫͼ������һ����ɫԲ��

[n,m] = size(cim(:,:,1));
% 4 * 4 ��������
h = 20;
boundary = 10;
wcim = cim;
wcim(boundary:boundary+h, m-boundary-h:m-boundary,1) = 255;
wcim(boundary:boundary+h, m-boundary-h:m-boundary,2) = 255;
wcim(boundary:boundary+h, m-boundary-h:m-boundary,3) = 255;


end

