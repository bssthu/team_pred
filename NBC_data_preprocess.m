% -*- coding: gbk -*-
% Module            : NBC_data_preprocess.m
% Author            : bss
% Project           : ģʽʶ�����ҵ ������
% State             : 
% Description       : 
% 

function data = NBC_data_preprocess(rawData)

num_match = 380;
num_action = 9;
N_data = size(rawData, 1);

data_by_act = rawData(:, [1, 4]);  % ��1��Ϊ����ID, ��2��Ϊ����
% [ʵ�ʱ���ID * 2 - ���Ͷ�] ��Ϊmatch_id
data_by_act(:, 1) = rawData(:, 1) * 2 - rawData(:, 2);

data = zeros(num_match, num_action); % ÿ�������������ͳ���ÿ���������ִ���
for i = 1:num_match
    I = data_by_act(:, 1) == i;
    data(i, :) = histc(data_by_act(I, 2), 1:9);
end
