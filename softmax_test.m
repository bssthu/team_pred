% -*- coding: gbk -*-
% Module            : softmax_test.m
% Author            : bss
% Project           : ģʽʶ�����ҵ ������
% State             : 
% Description       : 
% 

function [correct_rate, est_label] = softmax_test(test_data, test_labels, theta)

[m, ~] = size(test_data);
test_data = [test_data, ones(m, 1)];

[~, est_label] = max(theta * test_data');
est_label = est_label';

correct_rate = sum(est_label == test_labels) / length(test_labels);
