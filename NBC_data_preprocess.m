% -*- coding: gbk -*-
% Module            : NBC_data_preprocess.m
% Author            : bss
% Project           : 模式识别大作业 足球赛
% State             : 
% Description       : 
% 

function data = NBC_data_preprocess(rawData, l, w)

num_match = 380;

data_by_act = rawData(:, [1, 4]);  % 第1列为比赛ID, 第2列为动作
% [实际比赛ID * 2 - 主客队] 作为match_id
data_by_act(:, 1) = rawData(:, 1) * 2 - rawData(:, 2);
% 扩展动作
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
% 成功失败
succeed = rawData(:, 6) == 1;
data_by_act(:, 2) = data_by_act(:, 2) * 2 - succeed;
% pass: 1 -- 12
% 时间
data_by_act(:, 2) = data_by_act(:, 2) + 12;
data_by_act(I_pass, 2) = (data_by_act(I_pass, 2) - 12) * 2 - (rawData(I_pass, 5) < 2700);
% pass: 1 -- 24
% 坐标
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

% 按比赛场次划分
num_action = max(data_by_act(:, 2));
data = zeros(num_match, num_action); % 每场比赛（分主客场）每个动作出现次数
for i = 1:num_match
    I = data_by_act(:, 1) == i;
    data(i, :) = histc(data_by_act(I, 2), 1:num_action);
end
