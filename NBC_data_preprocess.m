% -*- coding: gbk -*-
% Module            : NBC_data_preprocess.m
% Author            : bss
% Project           : 模式识别大作业 足球赛
% State             : 
% Description       : 
% 

function [data, labels] = NBC_data_preprocess(rawData, rawLabels)

N_label = size(rawLabels, 1);
N_data = size(rawData, 1);

data = rawData(:, [1, 4]);  % 第1列为比赛ID, 第2列为动作
% [实际比赛ID * 2 - 主客队] 作为match_id
data(:, 1) = rawData(:, 1) * 2 - rawData(:, 2);
labels = zeros(N_data, 1);  % 球队ID, 每行对应一次动作

for i = 1:N_label
    I = (rawData(:, 1) == rawLabels(i, 1)) ...
            .* (rawData(:, 2) == rawLabels(i, 2));
    I = logical(I);
    labels(I) = rawLabels(i, 3);
end
