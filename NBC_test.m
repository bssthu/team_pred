% -*- coding: gbk -*-
% Module            : NBC_test.m
% Author            : bss
% Project           : 模式识别大作业 足球赛
% State             : 
% Description       : 
% 

function correct_rate = NBC_test(test_data, test_labels, theta)

%% Init
num_class = 20;
num_match = 380;

p_match = zeros(num_match, num_class);
theta_log = log(theta + 0.0000001);

%% Estimate
for i = 1:num_match
    I = test_data(:, 1) == i;
    p_match(i, :) = sum(theta_log(:, test_data(I, 2)), 2)';
end

%% Test
[~, est_label] = max(p_match, [], 2);
correct_rate = sum(est_label == test_labels) / num_match;
