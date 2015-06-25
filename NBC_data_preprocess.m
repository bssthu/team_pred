% -*- coding: gbk -*-
% Module            : NBC_data_preprocess.m
% Author            : bss
% Project           : ģʽʶ�����ҵ ������
% State             : 
% Description       : 
% 

function data = NBC_data_preprocess(rawData, labels)

N_label = length(labels);

data = rawData(:, [1, 1, 4]);  % ��1��Ϊ����ID, ��2��Ϊ���ID, ��3��Ϊ����

for i = 1:N_label
    I = (rawData(:, 1) == labels(i, 1)) ...
            .* (rawData(:, 2) == labels(i, 2));
    I = logical(I);
    data(I, 2) = labels(i, 3);
end
