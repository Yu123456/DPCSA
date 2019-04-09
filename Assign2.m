function ClassLabel = Assign2(classlabel,dist,center)
% �������д�� 2017 �� 8 �� 24 ��
% ������ڶ�̬���˼����о���

% ����
% classlabel     �Ѿ����в��־��������ǣ�����������0 ֵ��ʾδ���������
% dist           �������
% center         ���ĵ��ţ���Ӧ dist �еı�ţ�

% ���
% ClassLabel   �ѱ������ǩ

N = length(classlabel);  % ���ݵ����
K = length(center);      % �ظ��������ĵ����
unassignBool = classlabel == 0;    % δ��������ǵ���߼�����
M = sum(unassignBool);             % δ����ǵ����
ClassLabel = classlabel;           % ���ر�����
if M == 0
    % M Ϊ 0 ˵���Ѿ�ȫ����ֵ
    return;
end
unSeq = zeros(M,1);

% ���е�������
% sdist   δ��ǵ�������
% sord    δ��ǵ㰴�������ʱ��ԭ�����е����������� 1:M �У����Դ� unSeq ��
% ��ȡԭʼ�����еı��
[sdist, sord] =sort(dist(:,unassignBool),2,'ascend');

% ����ڶ�̬���ʼ��С
ND = round( N/K ) * 2;
% �Ѿ��������ı��
AssignedNumber = zeros(K,ND);
% �ѱ�����������ڵ��ţ���Ӧ dist(:,unassignBool') �еı�ţ������Ҫԭʼ
% ��ţ��� unSeq �ж�ȡ
AssignedNearest = zeros(K,ND);
% �õ㵽����ڵ㣨δ������ĵ㣩�ľ���
NearestDist = zeros(K,ND);
% �Ѿ������������������Ӧ�� sord 
% ����δ������ĵ㣬sdist �е�һ��ֵ�ǵ�����ľ��룬��ֵΪ 0
% �����ѱ�ǵ㣬sdist �еĵ�һ���㲻Ϊ 0
flagSord = zeros(N,1);
% ÿһ������Ѿ���ǵ����
ClusterNumber = zeros(K,1);
% ÿ���������ڵ��ţ���Ӧ AssignedNumber �е�������ţ�
MinIndex = zeros(K,1) ;
% ÿ���������ھ���
dconst = max(max(sdist)) + 1.0;
MinDist = zeros(K,1) + dconst; % �� 1 ��Ϊ��ȷ����һ�θ�ֵһ������ִ��;

% ��ʼ������ڶ�̬��
k = 0;
for i=1:N
    if unassignBool(i)
        % �õ�δ������
        k = k+1;
        unSeq(k) = i;          % unSeq �еĵ� k ��������ӦֵΪԭʼ�����еĵ� i ����ŵ�
        % �õ������Ӧ�� sord �еĵ� 2 ��������ʼ
        flagSord(i) = 2;
    else
        % �õ��Ѿ����࣬
        label = ClassLabel(i);
        flagSord(i) = 1;          % ����ڴ� sord �еĵ� 1 ��������ʼ
        ClusterNumber(label) = ClusterNumber(label) + 1;  % label ������������� 1
        AssignedNumber(label,ClusterNumber(label)) = i;   % �ѱ������ı��
        % �õ������ڵ��ţ���Ӧ dist(:,unassignBool') �еı�ţ����Դ� unSeq 
        % ��ȡԭʼ���ݱ�ţ���Ӧ dist ����
        AssignedNearest(label,ClusterNumber(label)) = sord(i,flagSord(i)); 
        % �õ������ھ���
        NearestDist(label,ClusterNumber(label)) = sdist(i,flagSord(i));
        if sdist(i,flagSord(i)) < MinDist(label)
            MinDist(label) = sdist(i,flagSord(i));
            MinIndex(label) = ClusterNumber(label);
        end
    end
end

% ����δ������ĵ���һ������
for i=1:M-1
    % ��һ��������ĵ�Ϊ P
    [~,label] = min(MinDist);   % label ����Сֵ������ͬʱҲ����С����������ı��,
                                % ����һ������ǵ�������Ϊ label
    Pind = unSeq(AssignedNearest(label,MinIndex(label)));      % ����ǵ���Ϊ Pind, ��Ӧԭʼ���ݱ��
%     disp(['��ţ�',num2str(Pind),' ��ֵǰ��',num2str(ClassLabel(Pind)),' , ��ֵ��',num2str(label)]);
    ClassLabel(Pind) = label;   % ��� Pind ������Ϊ label
    ClusterNumber(label) = ClusterNumber(label) + 1;   % �ѱ�ǵ�� 1
    AssignedNumber(label, ClusterNumber(label)) = Pind;  % �ѱ�ǵ������
    % ��� Pind �������ڵ��ţ���Ӧ dist(:,unassignBool') �еı��
    % �ҵ������δ������ĵ�
    bool = 1;
    while bool
        nn = sord(Pind,flagSord(Pind));     % ��ǰ�����
        % ��鵱ǰ������Ƿ��Ѿ�������
        if ClassLabel(unSeq(nn)) == 0
            % û�б������ǩ��������Ϊ�����
            bool = 0;
            AssignedNearest(label,ClusterNumber(label)) = nn;
        else
            % ��ǰ���Ѿ����������������һ��
            flagSord(Pind) = flagSord(Pind) + 1;
        end
    end
    % ��� Pind �������ھ���
    NearestDist(label, ClusterNumber(label)) = sdist(Pind, flagSord(Pind));
    
    % ��������ڶ�̬��
    for k=1:K
        % ���µ� k ���أ�ͬʱ����ÿ���������ڼ������
        % ���³�ʼ��
        MinDist(k) = dconst;
        MinIndex(k) = 0;
        for j=1:ClusterNumber(k)
            % ����� k �����еĵ� j ����������ǡ���Ǳ��Ϊ Pind �ĵ㣬������������
            % ���򣬲�����
            flag = AssignedNearest(k,j);  % ��Ӧ dist(:,unassignBool') �еı��
            if unSeq(flag) == Pind
                % AssignedNumber(k,j) ����Ҫ���������
                kjNum = AssignedNumber(k,j);
                % ���ҳ���һ���������δ������ĵ�
                bool = 1;
                while bool
                    flagSord(kjNum) = flagSord(kjNum) + 1;    % �����������һ��
                    nn = sord(kjNum,flagSord(kjNum));    % ���������ֵ����Ӧ dist(:,unassignBool') �еı��
                    if ClassLabel(unSeq(nn)) == 0
                        % ������ num �ĵ�����Ϊ 0�� ˵��δ������
                        bool = 0;     % �˳� while ѭ����ֹͣ����������ƶ�
                        AssignedNearest(k,j) = nn;   % ���������
                        % ��������ھ���
                        NearestDist(k,j) = sdist(kjNum,flagSord(kjNum)); 
                    end
                end
            end
            % ��ʱ�� j ����������Ѿ��������
            % �� j �����Ƿ������Ϊ�µ���������
            if NearestDist(k,j) < MinDist(k)
                MinDist(k) = NearestDist(k,j);
                MinIndex(k) = j;
            end
        end
    end
end

% �������һ���������ǣ������Ϊ M ��δ�������
[~,label] = min(MinDist);   % label ����Сֵ������ͬʱҲ����С����������ı��,
                                % ����һ������ǵ�������Ϊ label
Pind = unSeq(AssignedNearest(label,MinIndex(label)));      % ����ǵ���Ϊ Pind, ��Ӧԭʼ���ݱ��
    
ClassLabel(Pind) = label;   % ��� Pind ������Ϊ label

end

