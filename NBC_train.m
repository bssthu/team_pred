% -*- coding: gbk -*-
% Module            : NBC_train.m
% Author            : bss
% Project           : 模式识别大作业 足球赛
% State             : 
% Description       : 
% 

function theta = NBC_train(trainData, trainLabels)

%% Init
num_class = 20;
num_action = 9;

theta = zeros(num_class, num_action);
action_count = zeros(num_class, num_action);

%% Preprocess
train_data = NBC_data_preprocess(trainData, trainLabels);

%% Train
for i = 1:num_class
    for j = 1:num_action
        I = (train_data(:, 2) == i) .* (train_data(:, 3) == j);
        action_count(i, j) = sum(I);
    end
    theta(i, :) = action_count(i, :) / sum(action_count(i, :));
end
