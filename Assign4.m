function ClassLabel = Assign4(classlabel,rho,ordrho,nneigh,delta)
% �������д�� 2017 �� 8 �� 30 ��
% �� DPC ��˼���Ǿ���С�ھ�ֵ�ĵ������ǩ

% ����
% classlabel     �Ѿ����в��־��������ǣ�����������0 ֵ��ʾδ���������
% rho            �ܶ�����
% ordrho         �ܶȵݼ�����������
% nneigh         �������
% delta          �ܶȴ����Լ����������

% ���
% ClassLabel   �ѱ������ǩ

ClassLabel = classlabel;
n = length(rho);
boolDelta = delta < mean(delta) ;
for i=1:n
    % ClassLabel(i) Ϊ 0 ˵�����Ǵ�������
    % ��ô������ݵ����������ھ���������������ܶȴ�����ݵ���
    % �� rho �ĵݼ�˳�򣬱�֤�˸�ֵ������ִ���
    % ��Ϊ�Ǵ��ܶ����ĵ㿪ʼ��ֵ��
    if ClassLabel(ordrho(i)) == 0 && boolDelta(ordrho(i))
        ClassLabel(ordrho(i)) = ClassLabel(nneigh(ordrho(i)));
    end
end

end

