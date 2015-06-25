% -*- coding: gbk -*-
% Module            : softmax_data_preprocess.m
% Author            : bss
% Project           : 模式识别大作业 足球赛
% State             : 
% Description       : 
% 

function [data, labels] = softmax_data_preprocess(rawData, rawLabels)

num_match = 380;
N_label = size(rawLabels, 1);
N_data = size(rawData, 1);

data = rawData(num_match, [1, 4]);  % 行代表每场比赛，列代表每个动作的出现次数
% [实际比赛ID * 2 - 主客队] 作为match_id
data(:, 1) = rawData(:, 1) * 2 - rawData(:, 2);
labels = zeros(N_data, 1);  % 球队ID, 每行对应一次动作

for i = 1:N_label
    I = (rawData(:, 1) == rawLabels(i, 1)) ...
            .* (rawData(:, 2) == rawLabels(i, 2));
    I = logical(I);
    labels(I) = rawLabels(i, 3);
end
