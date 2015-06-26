% -*- coding: utf-8 -*-
% Module            : entropy_test_nearest.m
% Author            : bss
% Project           : 模式识别大作业 足球赛
% State             : 
% Description       : 
% 

function [test_correct, est_label] =  entropy_test_nearest(...
        train_data, train_label, test_data, test_label)

    [m_test, ~] = size(test_data);

    D = pdist2(test_data, train_data);
    [~, I] = min(D, [], 2);
    est_label = train_label(I);
    test_correct = sum(est_label == test_label) / m_test;
end
