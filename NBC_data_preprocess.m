% -*- coding: gbk -*-
% Module            : NBC_data_preprocess.m
% Author            : bss
% Project           : ģʽʶ�����ҵ ������
% State             : 
% Description       : 
% 

function data = NBC_data_preprocess(rawData, l, w)

num_match = 380;

data_by_act = rawData(:, [1, 4]);  % ��1��Ϊ����ID, ��2��Ϊ����
% [ʵ�ʱ���ID * 2 - ���Ͷ�] ��Ϊmatch_id
data_by_act(:, 1) = rawData(:, 1) * 2 - rawData(:, 2);
% ��չ����
I_pass = rawData(:, 4) == 1;
data_by_act(:, 2) = data_by_act(:, 2) + 5;
data_by_act(I_pass, 2) = 1;
data_by_act(logical(rawData(:, 11)), 2) = 4;
data_by_act(logical(rawData(:, 12)), 2) = 5;
data_by_act(logical(rawData(:, 13)), 2) = 3;
data_by_act(logical(rawData(:, 14)), 2) = 2;
data_by_act(logical(rawData(:, 16)), 2) = 6;
data_by_act(logical(rawData(:, 15)), 2) = 15;
% pass: 1-6
% �ɹ�ʧ��
succeed = rawData(:, 6) == 1;
data_by_act(:, 2) = data_by_act(:, 2) * 2 - succeed;
% pass: 1 -- 12
% ʱ��
data_by_act(:, 2) = data_by_act(:, 2) + 12;
data_by_act(I_pass, 2) = (data_by_act(I_pass, 2) - 12) * 2 - (rawData(I_pass, 5) < 2700);
% pass: 1 -- 24
% ����
data_by_act(:, 2) = data_by_act(:, 2) + 24 * (l * w - 1);
data_by_act(I_pass, 2) = data_by_act(I_pass, 2) - 24 * (l * w - 1);
data_by_act(I_pass, 2) = data_by_act(I_pass, 2) * l;
for i = 1:l-1
    data_by_act(I_pass, 2) = data_by_act(I_pass, 2) - (rawData(I_pass, 7) < (100 / l * i));
end
data_by_act(I_pass, 2) = data_by_act(I_pass, 2) * w;
for i = 1:w-1
    data_by_act(I_pass, 2) = data_by_act(I_pass, 2) - (rawData(I_pass, 8) < (100 / w * i));
end
% pass: 1 -- 24*(w*l-1)

% ���������λ���
num_action = max(data_by_act(:, 2));
data = zeros(num_match, num_action); % ÿ�������������ͳ���ÿ���������ִ���
for i = 1:num_match
    I = data_by_act(:, 1) == i;
    data(i, :) = histc(data_by_act(I, 2), 1:num_action);
end
