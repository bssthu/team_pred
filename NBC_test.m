% -*- coding: gbk -*-
% Module            : NBC_test.m
% Author            : bss
% Project           : 模式识别大作业 足球赛
% State             : 
% Description       : 
% 

function correct_rate = NBC_test(testData, testLabels, theta)

%% Init
num_class = 20;
num_match = 380;    % [(比赛ID - 190) * 2 - 主客队] 作为这里的 match_id
num_match_half = 190;
N_data = size(testData, 1);
N_label = size(testLabels, 1);

p_match = zeros(num_match, num_class);

%% Preprocess
test_data = testData(:, [1, 4]);  % 第一列为比赛ID，第二列为动作
test_data(:, 1) = (testData(:, 1) - num_match_half) * 2 - testData(:, 2);

%% Estimate
theta_log = log(theta + 0.000001);
time_frame = ceil(testData(:, 5) / 2700);
time_frame(time_frame == 0) = 1;
for i = 1:N_data
    match_id = test_data(i, 1);
    action = test_data(i, 2);
    act_type = action * time_frame(i);
    for j = 1:num_class
        p_match(match_id, j) = p_match(match_id, j) + theta_log(j, act_type);
    end
end

%% Test
test_label = testLabels(:, 3);
[~, est_label] = max(p_match, [], 2);
correct_rate = sum(est_label == test_label) / num_match;
