% -*- coding: gbk -*-
% Module            : NBC_data_preprocess.m
% Author            : bss
% Project           : 模式识别大作业 足球赛
% State             : 
% Description       : 
% 

function data = NBC_data_preprocess(rawData)

num_match = 380;
num_action = 15;

data_by_act = rawData(:, [1, 4]);  % 第1列为比赛ID, 第2列为动作
% [实际比赛ID * 2 - 主客队] 作为match_id
data_by_act(:, 1) = rawData(:, 1) * 2 - rawData(:, 2);
% 扩展动作
data_by_act(logical(rawData(:, 11)), 2) = 10;
data_by_act(logical(rawData(:, 12)), 2) = 11;
data_by_act(logical(rawData(:, 13)), 2) = 12;
data_by_act(logical(rawData(:, 14)), 2) = 13;
data_by_act(logical(rawData(:, 15)), 2) = 14;
data_by_act(logical(rawData(:, 16)), 2) = 15;

data = zeros(num_match, num_action); % 每场比赛（分主客场）每个动作出现次数
for i = 1:num_match
    I = data_by_act(:, 1) == i;
    data(i, :) = histc(data_by_act(I, 2), 1:num_action);
end



