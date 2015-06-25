% -*- coding: gbk -*-
% Module            : softmax_error.m
% Author            : bss
% Project           : 模式识别大作业 足球赛
% State             : 
% Description       : 
% 

function e = softmax_error(x, y, theta)

y_est = softmax_test(x, theta);
e = sum(y_est ~= y) / length(y);
