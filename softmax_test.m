% -*- coding: gbk -*-
% Module            : softmax_test.m
% Author            : bss
% Project           : ģʽʶ�����ҵ ������
% State             : 
% Description       : 
% 

function y_est = softmax_test(data, theta)

[m, ~] = size(data);
data = [data, ones(m, 1)];

[~, y_est] = max(theta * data');
y_est = y_est';
