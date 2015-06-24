% -*- coding: gbk -*-
% Module            : NBC_train.m
% Author            : bss
% Project           : ģʽʶ�����ҵ ������
% State             : 
% Description       : 
% 

function theta = NBC_train(trainData, trainLabels)

%% Init
num_class = 20;
num_action = 9;
N_data = size(trainData, 1);
N_label = size(trainLabels, 1);

theta = zeros(num_class, num_action);
action_count = zeros(num_class, num_action);

%% Preprocess
train_data = trainData(:, [1, 4]);  % ��һ��Ϊ���ID���ڶ���Ϊ����
for i = 1:N_label
    I = (trainData(:, 1) == trainLabels(i, 1)) ...
            .* (trainData(:, 2) == trainLabels(i, 2));
    I = logical(I);
    train_data(I, 1) = trainLabels(i, 3);
end

%% Train
for i = 1:num_class
    for j = 1:num_action
        I = (train_data(:, 1) == i) .* (train_data(:, 2) == j);
        action_count(i, j) = sum(I);
    end
    theta(i, :) = action_count(i, :) / sum(action_count(i, :));
end
