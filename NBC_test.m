% -*- coding: gbk -*-
% Module            : NBC_test.m
% Author            : bss
% Project           : 模式识别大作业 足球赛
% State             : 
% Description       : 
% 

function [correct_rate, est_label] = NBC_test(test_data, test_labels, theta)

%% Init
num_class = 20;
num_match = 380;
eps = 0.0000001;

p_match = zeros(num_match, num_class);
theta_log = log(theta + eps);

%% Estimate
for i = 1:num_match
    for j = 1:num_class
        p_match(i, j) = sum(theta_log(j, :) .* test_data(i, :));
    end
end

%% Test
[~, est_label] = max(p_match, [], 2);
correct_rate = sum(est_label == test_labels) / num_match;
