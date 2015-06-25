% -*- coding: gbk -*-
% Module            : NBC_data_preprocess.m
% Author            : bss
% Project           : 模式识别大作业 足球赛
% State             : 
% Description       : 
% 

function data = NBC_data_preprocess(rawData, labels)

N_label = length(labels);

data = rawData(:, [1, 1, 4]);  % 第1列为比赛ID, 第2列为球队ID, 第3列为动作

for i = 1:N_label
    I = (rawData(:, 1) == labels(i, 1)) ...
            .* (rawData(:, 2) == labels(i, 2));
    I = logical(I);
    data(I, 2) = labels(i, 3);
end
