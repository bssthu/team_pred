% -*- coding: gbk -*-
% Module            : NBC_data_preprocess.m
% Author            : bss
% Project           : ģʽʶ�����ҵ ������
% State             : 
% Description       : 
% 

function [data, labels] = NBC_data_preprocess(rawData, rawLabels)

N_label = size(rawLabels, 1);
N_data = size(rawData, 1);

data = rawData(:, [1, 4]);  % ��1��Ϊ����ID, ��2��Ϊ����
% [ʵ�ʱ���ID * 2 - ���Ͷ�] ��Ϊmatch_id
data(:, 1) = rawData(:, 1) * 2 - rawData(:, 2);
labels = zeros(N_data, 1);  % ���ID, ÿ�ж�Ӧһ�ζ���

for i = 1:N_label
    I = (rawData(:, 1) == rawLabels(i, 1)) ...
            .* (rawData(:, 2) == rawLabels(i, 2));
    I = logical(I);
    labels(I) = rawLabels(i, 3);
end
