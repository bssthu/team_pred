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

p_match = zeros(num_match, num_class);
theta_log = log(theta + 0.0000001);

%% Preprocess
test_data = NBC_data_preprocess(testData, testLabels);
test_data(:, 1) = (testData(:, 1) - num_match_half) * 2 - testData(:, 2);

%% Estimate
for i = 1:num_match
    I = test_data(:, 1) == i;
    p_match(i, :) = sum(theta_log(:, test_data(I, 3)), 2)';
end

%% Test
test_label = testLabels(:, 3);
[~, est_label] = max(p_match, [], 2);
correct_rate = sum(est_label == test_label) / num_match;
