% -*- coding: gbk -*-
% Module            : softmax_test.m
% Author            : bss
% Project           : 模式识别大作业 足球赛
% State             : 
% Description       : 
% 

function y_est = softmax_test(data, theta)

[m, ~] = size(data);
data = [data, ones(m, 1)];

[~, y_est] = max(theta * data');
y_est = y_est';
