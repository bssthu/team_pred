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
num_action = 9;
num_match = 380;    % [(比赛ID - 190) * 2 - 主客队] 作为这里的 match_id
num_match_half = 190;
N_data = size(testData, 1);
N_label = size(testLabels, 1);

p_match = zeros(num_match, num_class);

%% Preprocess
test_data = NBC_data_preprocess(testData, testLabels);
test_data(:, 1) = (testData(:, 1) - num_match_half) * 2 - testData(:, 2);

%% Estimate
theta_log = log(theta);
for i = 1:N_data
    match_id = test_data(i, 1);
    action = test_data(i, 3);
    for j = 1:num_class
        p_match(match_id, j) = p_match(match_id, j) + theta_log(j, action);
    end
end

%% Test
test_label = testLabels(:, 3);
[~, est_label] = max(p_match, [], 2);
correct_rate = sum(est_label == test_label) / num_match;
